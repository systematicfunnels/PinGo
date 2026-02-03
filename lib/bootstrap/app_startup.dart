import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  // Add any async initialization here
  // e.g. await ref.watch(sharedPreferencesProvider.future);
  
  // For now, we just ensure the provider is alive
  return;
}
