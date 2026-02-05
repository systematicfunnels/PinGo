import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/visibility_selector.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/troupes/presentation/troupes_controller.dart';
import 'package:pingo/shared/widgets/sticky_action_bottom_bar.dart';

class CreateTroupeScreen extends ConsumerStatefulWidget {
  const CreateTroupeScreen({super.key});

  @override
  ConsumerState<CreateTroupeScreen> createState() => _CreateTroupeScreenState();
}

class _CreateTroupeScreenState extends ConsumerState<CreateTroupeScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  ContentVisibility _visibility = ContentVisibility.private;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(bool isStart) async {
    final initialDate = isStart ? _startDate : (_endDate ?? _startDate);
    final firstDate = isStart
        ? DateTime(1900) // Allow trips back to 1900
        : _startDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          // Reset end date if it's before new start date
          if (_endDate != null && _endDate!.isBefore(_startDate)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _createTroupe() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(troupesControllerProvider.notifier).createTroupe(
            _nameController.text,
            _startDate,
            description:
                _descController.text.isEmpty ? null : _descController.text,
            endDate: _endDate,
            visibility: _visibility,
          );

      if (mounted) {
        context.pop(); // Return to previous screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create troupe: $e')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Troupe'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.allXl,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Info
                      Text(
                        'Plan a Trip',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Organize your pins and memories by day.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.neutral.s700,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Troupe Name',
                          hintText: 'e.g., Summer in Tokyo',
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a name'
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Description Field
                      TextFormField(
                        controller: _descController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Description (Optional)',
                          hintText: 'What is this trip about?',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Date Selection
                      Row(
                        children: [
                          Expanded(
                            child: _DateSelector(
                              label: 'Start Date',
                              date: _startDate,
                              onTap: () => _selectDate(true),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _DateSelector(
                              label: 'End Date',
                              date: _endDate,
                              placeholder: 'Optional',
                              onTap: () => _selectDate(false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Visibility
                      VisibilitySelector(
                        selected: _visibility,
                        onChanged: (v) => setState(() => _visibility = v),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            StickyActionBottomBar(
              label: 'Create Troupe',
              onPressed: _isLoading ? null : _createTroupe,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String? placeholder;
  final VoidCallback onTap;

  const _DateSelector({
    required this.label,
    required this.date,
    this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.neutral.s700,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.md),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.neutral.s50,
              borderRadius: BorderRadius.circular(AppSpacing.md),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.neutral.s700,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    date != null
                        ? DateFormat.yMMMd().format(date!)
                        : (placeholder ?? ''),
                    style: TextStyle(
                      color: date != null
                          ? AppColors.neutral.s900
                          : AppColors.neutral.s500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
