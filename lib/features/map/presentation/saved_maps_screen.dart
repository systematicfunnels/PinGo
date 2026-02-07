import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

class SavedMapsScreen extends StatelessWidget {
  const SavedMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Maps'),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map_outlined, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            const Text(
              'No saved offline maps yet.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
