import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_status.g.dart';

// Network connectivity status
class NetworkStatus {
  Future<bool> get isConnected async {
    // For now assume connected or use connectivity_plus package if added
    return true;
  }
}

@Riverpod(keepAlive: true)
NetworkStatus networkStatus(Ref ref) {
  return NetworkStatus();
}
