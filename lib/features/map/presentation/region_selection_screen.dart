import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/map/presentation/saved_maps_controller.dart';

class RegionSelectionScreen extends ConsumerStatefulWidget {
  const RegionSelectionScreen({super.key});

  @override
  ConsumerState<RegionSelectionScreen> createState() =>
      _RegionSelectionScreenState();
}

class _RegionSelectionScreenState extends ConsumerState<RegionSelectionScreen> {
  final MapController _mapController = MapController();

  // Default download settings
  final int _minZoom = 12;
  final int _maxZoom = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Region'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _showDownloadDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(51.509364, -0.128928), // Default London
              initialZoom: 13.0,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.pingo',
              ),
            ],
          ),

          // Selection Frame (Visual guide)
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.primary, width: AppSpacing.xs),
              ),
            ),
          ),

          // Helper text
          Positioned(
            bottom: AppSpacing.xxl,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md)),
              child: Padding(
                padding: AppSpacing.allMd,
                child: Text(
                  'Pan and zoom to select the area to download.\nCurrently visible area will be saved.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDownloadDialog() {
    final bounds = _mapController.camera.visibleBounds;
    final nameController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Download Region'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Region Name',
                hintText: 'e.g. My Neighborhood',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Zoom Levels: $_minZoom - $_maxZoom',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'This will download map tiles for offline use. Larger areas may take longer.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.pop(context); // Close input dialog
                _startDownload(nameController.text, bounds);
              }
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _startDownload(String name, LatLngBounds bounds) {
    // Create the future
    final streamFuture =
        ref.read(savedMapsControllerProvider.notifier).downloadRegion(
              name: name,
              bounds: bounds,
              minZoom: _minZoom,
              maxZoom: _maxZoom,
            );

    // Show unified download dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RegionDownloadDialog(
        streamFuture: streamFuture,
        onSuccess: () {
          if (mounted) {
            context.pop(); // Go back to SavedMapsScreen
          }
        },
      ),
    );
  }
}

class RegionDownloadDialog extends StatefulWidget {
  final Future<Stream<DownloadProgress>> streamFuture;
  final VoidCallback onSuccess;

  const RegionDownloadDialog({
    super.key,
    required this.streamFuture,
    required this.onSuccess,
  });

  @override
  State<RegionDownloadDialog> createState() => _RegionDownloadDialogState();
}

class _RegionDownloadDialogState extends State<RegionDownloadDialog> {
  double _progress = 0;
  bool _isDone = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initDownload();
  }

  void _initDownload() {
    widget.streamFuture.then((stream) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      stream.listen(
        (event) {
          if (!mounted) return;
          setState(() {
            _progress = event.percentageProgress / 100;
            _isDone = event.percentageProgress == 100;
          });
          if (_isDone) {
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                Navigator.pop(context); // Close dialog
                widget.onSuccess();
              }
            });
          }
        },
        onError: (e) {
          if (mounted) {
            setState(() {
              _error = e.toString();
              _isLoading = false;
            });
          }
        },
      );
    }).catchError((e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(_error!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text(_isLoading ? 'Starting Download...' : 'Downloading Map...'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading)
            const CircularProgressIndicator()
          else ...[
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _isDone
                  ? 'Download Complete!'
                  : '${(_progress * 100).toStringAsFixed(1)}%',
            ),
          ],
        ],
      ),
    );
  }
}
