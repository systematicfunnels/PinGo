import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';

class ReplayJourneyFab extends StatelessWidget {
  final int journeyId;

  const ReplayJourneyFab({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push(
        RoutePaths.memoryReplay.replaceFirst(':id', journeyId.toString()),
      ),
      icon: const Icon(Icons.play_circle_outline),
      label: const Text('Replay Journey'),
      backgroundColor: AppColors.primary.s500,
      foregroundColor: AppColors.neutral.s100,
    );
  }
}
