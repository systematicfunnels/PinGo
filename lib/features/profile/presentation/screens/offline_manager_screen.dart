import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';

class OfflineManagerScreen extends StatefulWidget {
  const OfflineManagerScreen({super.key});

  @override
  State<OfflineManagerScreen> createState() => _OfflineManagerScreenState();
}

class _OfflineManagerScreenState extends State<OfflineManagerScreen> {
  // Mock data
  List<_OfflineRegion> _regions = [
    _OfflineRegion(
      id: '1',
      name: 'Kyoto city center',
      areaSize: '25 km²',
      fileSize: '142 MB',
      lastUpdated: '2 days ago',
      quality: 'detailed',
    ),
    _OfflineRegion(
      id: '2',
      name: 'Northern Alps trails',
      areaSize: '120 km²',
      fileSize: '385 MB',
      lastUpdated: '1 week ago',
      quality: 'standard',
    ),
  ];

  final int _totalStorage = 527; // MB

  void _deleteRegion(String id) {
    setState(() {
      _regions.removeWhere((r) => r.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Region deleted')),
    );
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => const _DownloadRegionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Offline Maps',
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your downloaded maps for offline use',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Storage Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.storage, color: AppColors.textSecondary),
                          SizedBox(width: 8),
                          Text(
                            'Storage Used',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$_totalStorage MB',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.35,
                    backgroundColor: AppColors.background,
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Downloads are limited to 2GB on free plan',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Download Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showDownloadDialog,
                icon: const Icon(Icons.download),
                label: const Text('Download New Region'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Regions List
            const Text(
              'Downloaded Regions',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            if (_regions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text('No maps downloaded'),
                ),
              )
            else
              ..._regions.map((region) => _RegionCard(
                    region: region,
                    onDelete: () => _deleteRegion(region.id),
                  )),
          ],
        ),
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final _OfflineRegion region;
  final VoidCallback onDelete;

  const _RegionCard({
    required this.region,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        region.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            region.areaSize,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text('·', style: TextStyle(color: AppColors.textSecondary)),
                          ),
                          Text(
                            region.fileSize,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textSecondary.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              region.quality == 'detailed' ? 'Detailed' : 'Standard',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Updated ${region.lastUpdated}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 20, color: AppColors.textSecondary),
                      onPressed: () {},
                      tooltip: 'Update',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.textSecondary),
                      onPressed: onDelete,
                      tooltip: 'Delete',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadRegionDialog extends StatefulWidget {
  const _DownloadRegionDialog();

  @override
  State<_DownloadRegionDialog> createState() => _DownloadRegionDialogState();
}

class _DownloadRegionDialogState extends State<_DownloadRegionDialog> {
  String _quality = 'standard';
  bool _isAreaSelected = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Download New Region',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => setState(() => _isAreaSelected = !_isAreaSelected),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _isAreaSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isAreaSelected
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.1),
                    width: _isAreaSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _isAreaSelected
                      ? const [
                          Icon(Icons.check_circle,
                              size: 40, color: AppColors.primary),
                          SizedBox(height: 8),
                          Text('Region Selected',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            'Tap to change selection',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ]
                      : const [
                          Icon(Icons.location_on,
                              size: 40, color: AppColors.textSecondary),
                          SizedBox(height: 8),
                          Text('Select area on map',
                              style: TextStyle(color: AppColors.primary)),
                          Text(
                            'Tap to simulate selection',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Map Quality',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _quality,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.2)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'standard', child: Text('Standard (Roads & Parks)')),
                DropdownMenuItem(
                    value: 'detailed',
                    child: Text('Detailed (Topography & Trails)')),
              ],
              onChanged: (v) => setState(() => _quality = v!),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Area Size',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13)),
                      Text('~45 km²',
                          style: TextStyle(
                              color: AppColors.primary, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Estimated Size',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13)),
                      Text('~180 MB',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                          color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isAreaSelected
                        ? () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Download started')),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.primary.withValues(alpha: 0.5),
                    ),
                    child: const Text('Download'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineRegion {
  final String id;
  final String name;
  final String areaSize;
  final String fileSize;
  final String lastUpdated;
  final String quality;

  _OfflineRegion({
    required this.id,
    required this.name,
    required this.areaSize,
    required this.fileSize,
    required this.lastUpdated,
    required this.quality,
  });
}
