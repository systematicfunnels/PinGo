enum ContentVisibility {
  private, // Just for me (Default)
  trusted, // Shared with trusted contacts
  public   // Visible to everyone (Future use)
}

extension ContentVisibilityExtension on ContentVisibility {
  String get label {
    switch (this) {
      case ContentVisibility.private:
        return 'Just for me';
      case ContentVisibility.trusted:
        return 'People I trust';
      case ContentVisibility.public:
        return 'Everyone';
    }
  }
}
