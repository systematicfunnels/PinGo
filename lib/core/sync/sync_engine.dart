// Core sync engine interface
abstract class SyncEngine {
  Future<void> sync();
  Future<void> push();
  Future<void> pull();
}
