import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/pingo_button.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/visibility_selector.dart';
import 'package:pingo/core/presentation/widgets/share_confirmation_dialog.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';

class JourneySummaryScreen extends ConsumerStatefulWidget {
  final int journeyId;

  const JourneySummaryScreen({super.key, required this.journeyId});

  @override
  ConsumerState<JourneySummaryScreen> createState() =>
      _JourneySummaryScreenState();
}

class _JourneySummaryScreenState extends ConsumerState<JourneySummaryScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  ContentVisibility _visibility = ContentVisibility.private;
  bool _isLoading = true;
  Journey? _journey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _loadJourney();
  }

  Future<void> _loadJourney() async {
    final repository = ref.read(journeyRepositoryProvider);
    final journey = await repository.getJourneyById(widget.journeyId);

    if (mounted) {
      setState(() {
        _journey = journey;
        if (journey != null) {
          _nameController.text = journey.name ?? '';
          _descriptionController.text = journey.description ?? '';
          _visibility = journey.visibility;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveJourney() async {
    if (_journey == null) return;

    // OPTIMISTIC UI
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Journey saved'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go(RoutePaths.library);
    }

    // Background Save
    Future(() async {
      try {
        final updatedJourney = _journey!.copyWith(
          name: _nameController.text.trim().isEmpty
              ? 'My Journey'
              : _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          visibility: _visibility,
        );

        final repository = ref.read(journeyRepositoryProvider);
        await repository.updateJourney(updatedJourney);
      } catch (e) {
        debugPrint('Background journey save failed: $e');
        SnackbarUtils.showError(e);
      }
    });
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => ShareConfirmationDialog(
        title: 'Share Journey',
        content: 'Do you want to share this journey with the community?',
        isPublic: _visibility == ContentVisibility.public,
        onConfirm: () {
          setState(() {
            _visibility = ContentVisibility.public;
          });
          _saveJourney();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Journey shared successfully!')),
          );
        },
      ),
    );
  }

  void _openReplay() {
    context.push(RoutePaths.memoryReplay
        .replaceFirst(':id', widget.journeyId.toString()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_journey == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Journey not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Summary'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // If closed without saving, we assume it's kept as is (draft).
            // Or we could ask to discard.
            context.go(RoutePaths.library);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.allLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for Map Preview
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: const Center(
                child: Icon(Icons.map, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openReplay,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Replay'),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showShareDialog,
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              'Journey Details',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Journey Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Description (Visual only for now if not in model)
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Notes)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: AppSpacing.xl),

            VisibilitySelector(
              selected: _visibility,
              onChanged: (value) => setState(() => _visibility = value),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: AppSpacing.allLg,
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: PingoButton(
              onPressed: _saveJourney,
              isLoading: false,
              label: 'Save Journey',
            ),
          ),
        ),
      ),
    );
  }
}
