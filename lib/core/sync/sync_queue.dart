// Queue for pending sync operations
class SyncQueue {
  final List<Map<String, dynamic>> _queue = [];

  void add(Map<String, dynamic> operation) {
    _queue.add(operation);
  }

  List<Map<String, dynamic>> get pendingOperations => List.unmodifiable(_queue);
  
  void clear() => _queue.clear();
}
