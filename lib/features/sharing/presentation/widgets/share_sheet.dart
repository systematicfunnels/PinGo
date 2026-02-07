import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/presentation/widgets/atoms/pingo_text.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/sharing/presentation/share_controller.dart';

class ShareSheet extends ConsumerStatefulWidget {
  final Pin pin;

  const ShareSheet({super.key, required this.pin});

  @override
  ConsumerState<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<ShareSheet> {
  late ContentVisibility _currentVisibility;
  bool _isSensitiveDetected = false;

  final List<String> _sensitiveKeywords = [
    'home',
    'address',
    'secret',
    'private',
    'hidden',
    'password',
    'code',
    'kids',
    'school'
  ];

  @override
  void initState() {
    super.initState();
    _currentVisibility = widget.pin.visibility;
    _checkForSensitiveContent();
  }

  void _checkForSensitiveContent() {
    final text = '${widget.pin.title} ${widget.pin.description}'.toLowerCase();
    setState(() {
      _isSensitiveDetected =
          _sensitiveKeywords.any((keyword) => text.contains(keyword));
    });
  }

  Future<void> _updateVisibility(ContentVisibility visibility) async {
    setState(() => _currentVisibility = visibility);

    // Immediate update as per spec
    final updatedPin = Pin(
      id: widget.pin.id,
      title: widget.pin.title,
      description: widget.pin.description,
      latitude: widget.pin.latitude,
      longitude: widget.pin.longitude,
      createdAt: widget.pin.createdAt,
      isSynced: widget.pin.isSynced,
      visibility: visibility,
      type: widget.pin.type,
      mediaPaths: widget.pin.mediaPaths,
      mapId: widget.pin.mapId,
      troupeId: widget.pin.troupeId,
      journeyId: widget.pin.journeyId,
      isDraft: widget.pin.isDraft,
    );

    try {
      await ref.read(pinsControllerProvider.notifier).updatePin(updatedPin);
      if (mounted) {
        SnackbarUtils.show('Visibility updated', isError: false);
      }
    } catch (e) {
      // Revert on error
      if (mounted) {
        setState(() => _currentVisibility = widget.pin.visibility);
        SnackbarUtils.showError('Failed to update visibility: $e');
      }
    }
  }

  Future<void> _copyLink() async {
    final link = await ref
        .read(shareControllerProvider.notifier)
        .generatePinLink(widget.pin);
    await Clipboard.setData(ClipboardData(text: link));
    if (mounted) {
      HapticFeedback.mediumImpact();
      SnackbarUtils.show('Link copied', isError: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.top16,
        boxShadow: AppElevation.modal,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: AppSpacing.xxl,
                height: AppSpacing.xs,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.neutral.s300,
                  borderRadius: AppRadius.allFull,
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl, vertical: AppSpacing.md),
              child: Row(
                children: [
                  Icon(Icons.share_outlined, color: AppColors.neutral.s900),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    'Share Memory',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close, color: AppColors.neutral.s700),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sensitive Content Warning
                  if (_isSensitiveDetected &&
                      _currentVisibility == ContentVisibility.public)
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primary.s500.withValues(alpha: 0.1),
                        borderRadius: AppRadius.all12,
                        border: Border.all(
                            color:
                                AppColors.primary.s500.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.privacy_tip_outlined,
                              color: AppColors.primary.s500),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PingoText.heading(
                                  'Smart Privacy Check',
                                  color: AppColors.primary.s500,
                                  size: PingoTextSize.small,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                PingoText.body(
                                  'Consider keeping this Private or Trusted.',
                                  color: AppColors.primary.s500,
                                  size: PingoTextSize.small,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Visibility Selector
                  PingoVisibilitySelector(
                    selected: _currentVisibility,
                    onChanged: _updateVisibility,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Link Sharing Section
                  PingoText.heading(
                    'Share Link',
                    size: PingoTextSize.small,
                    color: AppColors.neutral.s700,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  Opacity(
                    opacity: _currentVisibility == ContentVisibility.private
                        ? 0.5
                        : 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.neutral.s50,
                        borderRadius: AppRadius.all12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.link,
                                size: 20, color: AppColors.neutral.s900),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PingoText.heading(
                                  _currentVisibility ==
                                          ContentVisibility.private
                                      ? 'Link sharing is disabled'
                                      : 'Link ready to share',
                                  size: PingoTextSize.small,
                                ),
                                if (_currentVisibility !=
                                    ContentVisibility.private)
                                  PingoText.body(
                                    'Anyone with the link can view',
                                    color: AppColors.neutral.s700,
                                    size: PingoTextSize.small,
                                  ),
                              ],
                            ),
                          ),
                          if (_currentVisibility != ContentVisibility.private)
                            IconButton(
                              onPressed: _copyLink,
                              icon: Icon(Icons.copy,
                                  color: AppColors.primary.s500),
                              tooltip: 'Copy Link',
                            ),
                        ],
                      ),
                    ),
                  ),

                  if (_currentVisibility == ContentVisibility.private)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: PingoText.body(
                        'Make this memory Trusted or Public to share a link.',
                        color: AppColors.neutral.s700,
                        size: PingoTextSize.small,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
