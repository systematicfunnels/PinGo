// Network connectivity status
class NetworkStatus {
  Future<bool> get isConnected async {
    // For now assume connected or use connectivity_plus package if added
    return true;
  }
}
