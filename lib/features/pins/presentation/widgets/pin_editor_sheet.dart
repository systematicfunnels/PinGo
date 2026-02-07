import 'dart:async';
import 'dart:io';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/presentation/widgets/atoms/pingo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import '../../domain/models/pin.dart';
import '../controllers/pins_controller.dart';
import 'package:pingo/features/map/presentation/user_maps_controller.dart';
import 'package:pingo/features/troupes/presentation/troupes_controller.dart';

class PinEditorSheet extends ConsumerStatefulWidget {
  final double? initialLat;
  final double? initialLng;
  final Pin? pinToEdit;
  final bool captureImmediately;

  const PinEditorSheet({
    super.key,
    this.initialLat,
    this.initialLng,
    this.pinToEdit,
    this.captureImmediately = false,
  });

  @override
  ConsumerState<PinEditorSheet> createState() => _PinEditorSheetState();
}

class _PinEditorSheetState extends ConsumerState<PinEditorSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late ContentVisibility _visibility;
  late PinType _type;
  late List<String> _mediaPaths;
  int? _selectedMapId;
  int? _selectedTroupeId;
  int? _currentPinId;
  bool _isFinalSave = false;
  bool _hasChanges = false;
  bool _allowPop = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    final pin = widget.pinToEdit;
    _currentPinId = pin?.id;
    _titleController = TextEditingController(text: pin?.title);
    _descController = TextEditingController(text: pin?.description);
    _visibility = pin?.visibility ?? ContentVisibility.private;
    _type = pin?.type ?? PinType.memory;
    _mediaPaths = List.from(pin?.mediaPaths ?? []);
    _selectedMapId = pin?.mapId;
    _selectedTroupeId = pin?.troupeId;

    _titleController.addListener(_onContentChanged);
    _descController.addListener(_onContentChanged);

    if (widget.captureImmediately) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pickImage();
      });
    }
  }

  void _onContentChanged() {
    if (!_hasChanges) {
      _hasChanges = true;
    }

    // Debounce save draft
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted && !_isFinalSave && _hasChanges) {
        _savePin(isDraft: true);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _titleController.removeListener(_onContentChanged);
    _descController.removeListener(_onContentChanged);
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, // Immediate camera as per request
        imageQuality: 80,
      );
      if (image != null) {
        // Haptic feedback for shutter/save
        // Note: Camera app usually handles shutter sound
        setState(() {
          _mediaPaths.add(image.path);
          _hasChanges = true;
        });
      }
    } catch (e) {
      SnackbarUtils.showError(e);
    }
  }

  Future<void> _savePin({bool isDraft = false}) async {
    if (!isDraft && _isFinalSave) return;

    // Drafts don't need validation
    if (!isDraft && !_formKey.currentState!.validate()) return;

    // If it's a draft and title is empty, use a placeholder or skip if completely empty
    if (isDraft &&
        _titleController.text.isEmpty &&
        _descController.text.isEmpty &&
        _mediaPaths.isEmpty) {
      return; // Nothing to save
    }

    // Capture values before UI disposal
    final title = _titleController.text.isEmpty
        ? (isDraft ? 'Untitled Draft' : 'Untitled')
        : _titleController.text;
    final description = _descController.text;
    final visibility = _visibility;
    final type = _type;
    final mediaPaths = List<String>.from(_mediaPaths);
    final mapId = _selectedMapId;
    final troupeId = _selectedTroupeId;
    final currentId = _currentPinId;
    final initialLat = widget.initialLat;
    final initialLng = widget.initialLng;
    final pinToEdit = widget.pinToEdit;

    // OPTIMISTIC UI: Close immediately for final saves
    if (!isDraft) {
      _isFinalSave = true;
      _allowPop = true;

      if (mounted) {
        SnackbarUtils.show('Moment saved', isError: false);
        Navigator.of(context).pop();
      }
    } else {
      // Drafts might show a loading state if manual, or be silent
      // For manual draft save (back button), we just wait
    }

    // Run Save Logic (Background)
    // Using a microtask or just unawaited future to ensure it runs after frame
    Future(() async {
      try {
        double lat = initialLat ?? 0;
        double lng = initialLng ?? 0;

        // If no location provided, we must fetch it (this might take a moment)
        if (initialLat == null || initialLng == null) {
          final position = await Geolocator.getCurrentPosition();
          lat = position.latitude;
          lng = position.longitude;
        }

        if (currentId != null) {
          // Update existing pin
          final updatedPin = Pin(
            id: currentId,
            title: title,
            description: description,
            latitude: pinToEdit?.latitude ?? lat,
            longitude: pinToEdit?.longitude ?? lng,
            createdAt: pinToEdit?.createdAt ?? DateTime.now(),
            isSynced: pinToEdit?.isSynced ?? false,
            visibility: visibility,
            type: type,
            mediaPaths: mediaPaths,
            mapId: mapId,
            troupeId: troupeId,
            journeyId: pinToEdit?.journeyId,
            isDraft: isDraft,
          );
          await ref.read(pinsControllerProvider.notifier).updatePin(updatedPin);
        } else {
          // Create new pin
          await ref.read(pinsControllerProvider.notifier).addPin(
                title,
                description,
                lat,
                lng,
                visibility: visibility,
                type: type,
                mediaPaths: mediaPaths,
                mapId: mapId,
                troupeId: troupeId,
                isDraft: isDraft,
              );
        }
      } catch (e) {
        debugPrint('Background save failed: $e');
        SnackbarUtils.showError(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: _allowPop,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          if (!_isFinalSave && _hasChanges) {
            await _savePin(isDraft: true);
            if (context.mounted) {
              SnackbarUtils.show('Saved as draft', isError: false);
            }
          }
          _allowPop = true;
          if (context.mounted) {
            setState(() {});
            Navigator.of(context).pop(result);
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.neutral.s100,
            borderRadius: AppRadius.top16,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    width: AppSpacing.xxl,
                    height: AppSpacing.xs,
                    margin: const EdgeInsets.only(top: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.neutral.s300,
                      borderRadius: AppRadius.allFull,
                    ),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.pinToEdit != null
                            ? 'Edit Pin'
                            : 'Capture Moment',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(Icons.close, color: AppColors.neutral.s700),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: AppSpacing.allXl,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              hintText: 'What is this place?',
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter a title'
                                : null,
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Media Picker
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                        right: AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral.s50,
                                      borderRadius: AppRadius.all12,
                                      border: Border.all(
                                          color: AppColors.neutral.s300),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_a_photo_outlined,
                                            color: AppColors.neutral.s700),
                                        const SizedBox(height: 4),
                                        PingoText.body(
                                          'Add Photo',
                                          size: PingoTextSize.small,
                                          color: AppColors.neutral.s700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ..._mediaPaths.map((path) => Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(
                                          right: AppSpacing.sm),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(path)),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: AppRadius.all12,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _mediaPaths.remove(path);
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                    AppSpacing.xs),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black54,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close,
                                                    size: AppSpacing.lg,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),

                          TextFormField(
                            controller: _descController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: _type == PinType.safety
                                  ? 'Hazard Description'
                                  : 'Description',
                              hintText: _type == PinType.safety
                                  ? 'Describe the danger...'
                                  : 'Why is it special?',
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Type',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(
                            spacing: AppSpacing.sm,
                            children: PinType.values.map((type) {
                              return ChoiceChip(
                                label: Text(type.name.toUpperCase()),
                                selected: _type == type,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: AppRadius.all4,
                                ),
                                onSelected: (selected) {
                                  if (selected) setState(() => _type = type);
                                },
                              );
                            }).toList(),
                          ),
                          if (_type == PinType.safety) ...[
                            const SizedBox(height: AppSpacing.md),
                            Container(
                              padding: AppSpacing.allMd,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.error.s500.withValues(alpha: 0.1),
                                borderRadius: AppRadius.all8,
                                border: Border.all(
                                    color: AppColors.error.s500
                                        .withValues(alpha: 0.5)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded,
                                      color: AppColors.error.s500),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Text(
                                      'Marking this as a hazard will alert other users nearby.',
                                      style: TextStyle(
                                          color: AppColors.error.s500
                                              .withValues(alpha: 0.8)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          PingoVisibilitySelector(
                            selected: _visibility,
                            onChanged: (v) => setState(() => _visibility = v),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _buildMapSelector(),
                          const SizedBox(height: AppSpacing.md),
                          _buildTroupeSelector(),
                          const SizedBox(
                              height:
                                  AppSpacing.sm), // Bottom spacer for scroll
                        ],
                      ),
                    ),
                  ),
                ),

                // Sticky Footer
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.lg),
                  child: PingoButton.primary(
                    onPressed: _savePin,
                    isLoading: false,
                    label: 'Save Memory',
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildMapSelector() {
    final mapsAsync = ref.watch(userMapsControllerProvider);
    return mapsAsync.when(
      data: (maps) {
        if (maps.isEmpty) return const SizedBox.shrink();
        return DropdownButtonFormField<int>(
          initialValue:
              maps.any((m) => m.id == _selectedMapId) ? _selectedMapId : null,
          decoration: InputDecoration(
            labelText: 'Add to Map',
            filled: true,
            fillColor: AppColors.neutral.s100,
            border: OutlineInputBorder(
              borderRadius: AppRadius.all12,
              borderSide: BorderSide.none,
            ),
          ),
          items: maps.map((map) {
            return DropdownMenuItem<int>(
              value: map.id,
              child: Text(map.name),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedMapId = value),
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildTroupeSelector() {
    final troupesAsync = ref.watch(troupesControllerProvider);
    return troupesAsync.when(
      data: (troupes) {
        if (troupes.isEmpty) return const SizedBox.shrink();
        return DropdownButtonFormField<int>(
          initialValue: troupes.any((t) => t.id == _selectedTroupeId)
              ? _selectedTroupeId
              : null,
          decoration: InputDecoration(
            labelText: 'Add to Troupe',
            filled: true,
            fillColor: AppColors.neutral.s100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.md),
              borderSide: BorderSide.none,
            ),
          ),
          items: troupes.map((troupe) {
            return DropdownMenuItem<int>(
              value: troupe.id,
              child: Text(troupe.name),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedTroupeId = value),
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
