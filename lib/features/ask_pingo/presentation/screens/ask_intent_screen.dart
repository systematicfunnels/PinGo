import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum IntentOption {
  whatStoodOut,
  patterns,
  meaningful,
  safety,
  overall,
}

class AskIntentScreen extends StatefulWidget {
  const AskIntentScreen({super.key});

  @override
  State<AskIntentScreen> createState() => _AskIntentScreenState();
}

class _AskIntentScreenState extends State<AskIntentScreen> {
  IntentOption? _selected;

  final List<Map<String, dynamic>> _options = [
    {
      'id': IntentOption.whatStoodOut,
      'icon': Icons.auto_awesome_outlined,
      'label': 'What stood out?',
    },
    {
      'id': IntentOption.patterns,
      'icon': Icons.repeat,
      'label': 'Any interesting patterns?',
    },
    {
      'id': IntentOption.meaningful,
      'icon': Icons.favorite_border,
      'label': 'Why is this meaningful?',
    },
    {
      'id': IntentOption.safety,
      'icon': Icons.shield_outlined,
      'label': 'Is this area safe?',
    },
    {
      'id': IntentOption.overall,
      'icon': Icons.sentiment_satisfied_alt_outlined,
      'label': 'Tell me about the overall vibe',
    },
  ];

  void _handleContinue() {
    if (_selected != null) {
      context.push(RoutePaths.askInput);
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
                          'What kind of insight are you looking for?',
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
