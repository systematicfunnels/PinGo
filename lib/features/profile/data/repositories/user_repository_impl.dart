import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_repository_impl.g.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data
    return const User(
      id: 'user_1',
      username: 'Explorer',
      role: 'Local Guide',
      bio: 'Capturing the hidden corners of the city, one pin at a time.',
    );
  }

  @override
  Future<void> updateUser(User user) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, we would save to DB/API here
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl();
}
