import 'package:pingo/features/map/data/repositories/user_map_repository_impl.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_feed_controller.g.dart';

@riverpod
class ExploreFeedController extends _$ExploreFeedController {
  @override
  Future<List<UserMap>> build() async {
    // Initial load
    return _fetchFeed();
  }

  Future<List<UserMap>> _fetchFeed() async {
    // In a real app, this would fetch from a remote API with pagination.
    // For now, we fetch local maps and simulate a network delay.
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    final maps = await ref.read(userMapRepositoryProvider).getUserMaps();

    // If empty, we can return some mock data for "Trending" simulation
    if (maps.isEmpty) {
      return _generateMockMaps();
    }
    return maps;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchFeed());
  }

  Future<void> loadMore() async {
    // Implement pagination logic here if needed
    // For now, since it's local/mock, we just keep existing state
  }

  // Mock data generator for empty state
  List<UserMap> _generateMockMaps() {
    return [
      UserMap(
        id: -1,
        name: 'Secret Coffee Spots',
        description: '5 locations • 1.2k views',
        createdAt: DateTime.now(),
        isSynced: true,
        authorName: 'BaristaJane',
      ),
      UserMap(
        id: -2,
        name: 'River Walk',
        description: '3.5 km • Easy trail along the Thames',
        createdAt: DateTime.now(),
        isSynced: true,
        authorName: 'NatureLover',
      ),
      UserMap(
        id: -3,
        name: 'City Park Hidden Gems',
        description: '12 locations you missed',
        createdAt: DateTime.now(),
        isSynced: true,
        authorName: 'UrbanExplorer',
      ),
      UserMap(
        id: -4,
        name: 'Midnight Jazz Clubs',
        description: 'Best spots for live music',
        createdAt: DateTime.now(),
        isSynced: true,
        authorName: 'JazzCat',
      ),
    ];
  }
}
