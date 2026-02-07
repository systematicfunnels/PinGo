import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum ContextOption {
  thisJourney,
  savedPlace,
  recordedRoute,
  allJourneys,
}

class AskContextScreen extends StatefulWidget {
  const AskContextScreen({super.key});

  @override
  State<AskContextScreen> createState() => _AskContextScreenState();
}

class _AskContextScreenState extends State<AskContextScreen> {
  ContextOption? _selected;

  final List<Map<String, dynamic>> _options = [
    {
      'id': ContextOption.thisJourney,
      'icon': Icons.map_outlined,
      'label': 'This journey', // TODO: Use localized strings
    },
    {
      'id': ContextOption.savedPlace,
      'icon': Icons.location_on_outlined,
      'label': 'A saved place',
    },
    {
      'id': ContextOption.recordedRoute,
      'icon': Icons.route_outlined,
      'label': 'A recorded route',
    },
    {
      'id': ContextOption.allJourneys,
      'icon': Icons.library_books_outlined,
      'label': 'All my journeys',
    },
  ];

  void _handleContinue() {
    if (_selected != null) {
      context.push(RoutePaths.askIntent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _selected != null ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.surface,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                      disabledForegroundColor: AppColors.surface.withOpacity(0.5),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 0,
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What would you like to ask about?',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontFamily: 'Serif',
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        ..._options.map((option) {
                          final isSelected = _selected == option['id'];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: InkWell(
                              onTap: () => setState(() => _selected = option['id']),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primary.withOpacity(0.05) : AppColors.surface,
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : AppColors.border,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.primary.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          )
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        option['icon'],
                                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        option['label'],
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Your questions are private and only shared with Pingo AI to generate helpful responses.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
