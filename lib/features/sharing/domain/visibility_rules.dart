import 'package:pingo/core/domain/models/content_visibility.dart';

class VisibilityRules {
  static bool canShare(ContentVisibility visibility) {
    return visibility != ContentVisibility.private;
  }

  static String getShareDescription(ContentVisibility visibility) {
    switch (visibility) {
      case ContentVisibility.private:
        return 'Only you can see this. It cannot be shared.';
      case ContentVisibility.trusted:
        return 'Visible to trusted people. Link sharing works for them.';
      case ContentVisibility.public:
        return 'Visible to everyone. Anyone with the link can view.';
    }
  }
}
