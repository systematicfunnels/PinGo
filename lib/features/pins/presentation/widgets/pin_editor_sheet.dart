import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/presentation/widgets/visibility_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import '../controllers/pins_controller.dart';

class PinEditorSheet extends ConsumerStatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const PinEditorSheet({
    super.key,
    this.initialLat,
    this.initialLng,
  });

  @override
  ConsumerState<PinEditorSheet> createState() => _PinEditorSheetState();
}

class _PinEditorSheetState extends ConsumerState<PinEditorSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  ContentVisibility _visibility = ContentVisibility.private;
  PinType _type = PinType.memory;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _savePin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      double lat = widget.initialLat ?? 0;
      double lng = widget.initialLng ?? 0;

      // If no location provided, get current
      if (widget.initialLat == null || widget.initialLng == null) {
        // Simple permission check - assuming permissions are handled by Map/Onboarding for now
        // In a real app we'd want robust permission handling here too
        final position = await Geolocator.getCurrentPosition();
        lat = position.latitude;
        lng = position.longitude;
      }

      await ref.read(pinsControllerProvider.notifier).addPin(
            _titleController.text,
            _descController.text,
            lat,
            lng,
            visibility: _visibility,
            type: _type,
          );

      if (mounted) {
        context.pop(); // Close sheet
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save pin: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(top: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
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
                    'Capture Moment',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon:
                        const Icon(Icons.close, color: AppColors.textSecondary),
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
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'What is this place?',
                          filled: true,
                          fillColor: AppColors.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.5),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a title'
                            : null,
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
                          filled: true,
                          fillColor: AppColors.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.5),
                          ),
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
                            color: AppColors.danger.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.sm),
                            border: Border.all(
                                color: AppColors.danger.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded,
                                  color: AppColors.danger),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  'Marking this as a hazard will alert other users nearby.',
                                  style: TextStyle(
                                      color: AppColors.danger
                                          .withValues(alpha: 0.8)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.md),
                      VisibilitySelector(
                        selected: _visibility,
                        onChanged: (v) => setState(() => _visibility = v),
                      ),
                      const SizedBox(
                          height: AppSpacing.sm), // Bottom spacer for scroll
                    ],
                  ),
                ),
              ),
            ),

            // Sticky Footer
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.lg),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _savePin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.lg),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Memory'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
