class User {
  final String id;
  final String username;
  final String role;
  final String bio;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.username,
    required this.role,
    required this.bio,
    this.avatarUrl,
  });

  // Empty user for initial state
  factory User.empty() {
    return const User(
      id: '',
      username: '',
      role: '',
      bio: '',
    );
  }
}
