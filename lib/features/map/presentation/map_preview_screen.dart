import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/map/data/repositories/map_repository_impl.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/map/presentation/user_maps_controller.dart';

class MapPreviewScreen extends ConsumerStatefulWidget {
  final String mapId;

  const MapPreviewScreen({super.key, required this.mapId});

  @override
  ConsumerState<MapPreviewScreen> createState() => _MapPreviewScreenState();
}

class _MapPreviewScreenState extends ConsumerState<MapPreviewScreen> {
  bool _isLoading = true;
  MapPreview? _mapData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchMapData();
  }

  Future<void> _fetchMapData() async {
    try {
      final mapPreview =
          await ref.read(mapRepositoryProvider).getMapPreview(widget.mapId);
      if (mounted) {
        setState(() {
          _mapData = mapPreview;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveMap() async {
    if (_mapData == null) return;

    // OPTIMISTIC UI: Save immediately
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Map saved to Library'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      context.go('/library');
    }

    // Background Save
    Future(() async {
      try {
        await ref.read(userMapsControllerProvider.notifier).createMap(
              _mapData!.name,
              description: _mapData!.description,
              authorName: _mapData!.authorName,
              sourceUrl: 'pingo://map/${widget.mapId}',
              visibility: ContentVisibility.private,
            );
      } catch (e) {
        debugPrint('Failed to save map in background: $e');
        SnackbarUtils.showError(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Preview'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _mapData == null
                  ? const Center(child: Text('Map not found'))
                  : Column(
                      children: [
                        // Map Placeholder (Visual Preview)
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: AppColors.neutral.s100,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                // Mock Map Background
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: 0.1,
                                    child: Image.network(
                                      'https://tile.openstreetmap.org/12/2048/1365.png', // Placeholder tile
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                          child: Icon(Icons.map,
                                              size: 64,
                                              color: AppColors.neutral.s300)),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.public,
                                          size: 48,
                                          color: AppColors.primary.s500),
                                      const SizedBox(height: AppSpacing.sm),
                                      Text(
                                        'Preview Mode',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: AppColors.primary.s500,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Details Sheet
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppRadius.top16,
                              boxShadow: AppElevation.modal,
                            ),
                            padding: AppSpacing.allLg,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.primary.s500,
                                      child: Text(
                                        _mapData!.authorName[0],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _mapData!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          'by ${_mapData!.authorName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.neutral.s500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Text(
                                  _mapData!.description,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStat(context, 'Pins',
                                        _mapData!.pinCount.toString()),
                                    _buildStat(context, 'Routes',
                                        _mapData!.routeCount.toString()),
                                    _buildStat(context, 'Updated', '2d ago'),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  child: PingoButton.primary(
                                    onPressed: _saveMap,
                                    isLoading: false,
                                    label: 'Add to Library',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary.s500,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral.s700,
              ),
        ),
      ],
    );
  }
}
