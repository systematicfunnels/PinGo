class GeoUtils {
  /// Formats a distance in meters to a human-readable string.
  /// Returns meters if < 1km, otherwise kilometers with 2 decimal places.
  static String formatDistance(double meters) {
    if (meters < 1000) return '${meters.toStringAsFixed(0)} m';
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }
}
