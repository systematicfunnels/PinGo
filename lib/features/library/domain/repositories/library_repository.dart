import '../models/library_stats.dart';
import '../models/library_search_result.dart';

abstract class LibraryRepository {
  Future<LibraryStats> getStats();
  Future<LibrarySearchResult> search(String query);
}
