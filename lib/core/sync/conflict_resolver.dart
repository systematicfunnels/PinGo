// Strategy for resolving data conflicts
abstract class ConflictResolver<T> {
  T resolve(T local, T remote);
}
