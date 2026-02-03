import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/bootstrap/app_startup.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/routing/app_router.dart';

class PinGoApp extends ConsumerWidget {
  const PinGoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(appStartupProvider);

    return startup.when(
      data: (_) {
        final router = ref.watch(goRouterProvider);
        return MaterialApp.router(
          title: 'PinGo',
          theme: AppTheme.lightTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, st) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
