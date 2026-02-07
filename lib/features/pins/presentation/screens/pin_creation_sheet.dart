import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/routing/route_paths.dart';

class PinCreationSheet extends StatelessWidget {
  final double? lat;
  final double? lng;

  const PinCreationSheet({
    super.key,
    this.lat,
    this.lng,
  });

  void _navigateToEditor(BuildContext context) {
    context.pop(); // Close sheet first
    
    final queryParams = <String, String>{};
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lng != null) queryParams['lng'] = lng.toString();
    
    final uri = Uri(
      path: RoutePaths.pinEditor,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    
    context.push(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Save this moment',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Options
              _buildOption(
                context,
                icon: Icons.camera_alt_outlined,
                label: 'Add photo',
                sublabel: 'Capture what you see',
                color: AppColors.primary,
                onTap: () => _navigateToEditor(context),
              ),
              const SizedBox(height: 12),
              _buildOption(
                context,
                icon: Icons.edit_note_outlined,
                label: 'Write note',
                sublabel: 'Remember this feeling',
                color: AppColors.primary,
                onTap: () => _navigateToEditor(context),
              ),
              const SizedBox(height: 12),
              _buildOption(
                context,
                icon: Icons.favorite_border,
                label: 'Mark experience',
                sublabel: 'Something special happened here',
                color: AppColors.accent,
                onTap: () => _navigateToEditor(context),
              ),
              const SizedBox(height: 12),
              _buildOption(
                context,
                icon: Icons.warning_amber_rounded,
                label: 'Safety note',
                sublabel: 'Share caution with others',
                color: AppColors.danger,
                onTap: () => _navigateToEditor(context),
              ),

              const SizedBox(height: 24),
              Text(
                'You can return to this later…',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String sublabel,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    sublabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
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
