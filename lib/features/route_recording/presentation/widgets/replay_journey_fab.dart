import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';

class ReplayJourneyFab extends StatelessWidget {
  final int journeyId;

  const ReplayJourneyFab({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context) {
    return PingoFab(
      onPressed: () => context.push(
        RoutePaths.memoryReplay.replaceFirst(':id', journeyId.toString()),
      ),
      icon: Icons.play_circle_outline,
      label: 'Replay Journey',
      isExtended: true,
    );
  }
}
