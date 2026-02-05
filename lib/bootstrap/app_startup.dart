// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/database/database_provider.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  // 1. Initialize Database
  final db = ref.watch(appDatabaseProvider);
  // Perform a simple query to ensure DB is open and ready
  await db.customSelect('SELECT 1').get();

  // 2. Add other async initialization here
  // e.g. await ref.watch(sharedPreferencesProvider.future);
}
