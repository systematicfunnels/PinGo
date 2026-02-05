import 'package:share_plus/share_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/share_repository.dart';

part 'share_repository_impl.g.dart';

class ShareRepositoryImpl implements ShareRepository {
  @override
  Future<void> shareText({required String text, String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  @override
  Future<void> shareUrl({required String url, String? message}) async {
    final text = message != null ? '$message\n$url' : url;
    await SharePlus.instance.share(ShareParams(text: text));
  }
}

@riverpod
ShareRepository shareRepository(Ref ref) {
  return ShareRepositoryImpl();
}
