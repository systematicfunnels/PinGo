import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/presentation/widgets/atoms/pingo_text.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/presentation/widgets/organisms/pingo_confirmation_dialog.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/map/presentation/user_maps_controller.dart';
import 'package:pingo/features/troupes/presentation/troupes_controller.dart';
import 'package:pingo/shared/widgets/sticky_action_bottom_bar.dart';

class AddPinScreen extends ConsumerStatefulWidget {
  final int? journeyId;
  const AddPinScreen({super.key, this.journeyId});

  @override
  ConsumerState<AddPinScreen> createState() => _AddPinScreenState();
}

class _AddPinScreenState extends ConsumerState<AddPinScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  bool _isLoading = false;
  ContentVisibility _visibility = ContentVisibility.private;
  PinType _type = PinType.memory;
  final List<XFile> _mediaFiles = [];
  int? _selectedMapId;
  int? _selectedTroupeId;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _mediaFiles.add(image);
        });
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.showError('Failed to pick image: $e');
      }
    }
  }

  Future<void> _savePin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Always get current location for standalone add pin screen
      final position = await Geolocator.getCurrentPosition();

      await ref.read(pinsControllerProvider.notifier).addPin(
            _titleController.text,
            _descController.text,
            position.latitude,
            position.longitude,
            visibility: _visibility,
            type: _type,
            mediaPaths: _mediaFiles.map((f) => f.path).toList(),
            mapId: _selectedMapId,
            troupeId: _selectedTroupeId,
            journeyId: widget.journeyId,
          );

      if (mounted) {
        context.pop(); // Return to previous screen
      }
    } catch (e) {
      if (mounted) {
        SnackbarUtils.showError('Failed to save pin: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _onWillPop() async {
    final isDirty = _titleController.text.isNotEmpty ||
        _descController.text.isNotEmpty ||
        _mediaFiles.isNotEmpty;

    if (!isDirty) return true;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => PingoConfirmationDialog(
        title: 'Discard Changes?',
        content:
            'You have unsaved changes. Are you sure you want to discard them?',
        confirmLabel: 'Discard',
        cancelLabel: 'Keep Editing',
        isDestructive: true,
        onConfirm: () => Navigator.of(context).pop(true),
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const PingoText.heading('Capture Moment'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              if (await _onWillPop()) {
                if (mounted && context.mounted) context.pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo_outlined,
                                          color: AppColors.neutral.s700),
                                      const SizedBox(height: 4),
                                      PingoText.body(
                                        'Add Photo',
                                        color: AppColors.neutral.s700,
                                        size: PingoTextSize.small,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ..._mediaFiles.map((file) => Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                        right: AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      borderRadius: AppRadius.all12,
                                      image: DecorationImage(
                                        image: FileImage(File(file.path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _mediaFiles.remove(file);
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withValues(alpha: 0.5),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  size: 16,
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
                        PingoText.heading(
                          'Type',
                          size: PingoTextSize.medium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.sm,
                          children: PinType.values.map((type) {
                            return ChoiceChip(
                              label: Text(type.name.toUpperCase()),
                              selected: _type == type,
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
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.sm),
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
                            height: AppSpacing.xxl), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ),
              // Sticky Footer Button
              StickyActionBottomBar(
                label: 'Save Memory',
                onPressed: _isLoading ? null : _savePin,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapSelector() {
    final mapsAsync = ref.watch(userMapsControllerProvider);
    return mapsAsync.when(
      data: (maps) {
        if (maps.isEmpty) return const SizedBox.shrink();
        return DropdownButtonFormField<int>(
          initialValue:
              maps.any((m) => m.id == _selectedMapId) ? _selectedMapId : null,
          decoration: const InputDecoration(labelText: 'Add to Map'),
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
          decoration: const InputDecoration(labelText: 'Add to Troupe'),
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
