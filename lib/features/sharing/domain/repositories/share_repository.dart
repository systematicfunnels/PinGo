abstract interface class ShareRepository {
  Future<void> shareText({required String text, String? subject});
  Future<void> shareUrl({required String url, String? message});
}
