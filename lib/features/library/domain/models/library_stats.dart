class LibraryStats {
  final int pinCount;
  final int mapCount;
  final int journeyCount;
  final int offlineMapCount;

  const LibraryStats({
    required this.pinCount,
    required this.mapCount,
    required this.journeyCount,
    required this.offlineMapCount,
  });

  const LibraryStats.empty()
      : pinCount = 0,
        mapCount = 0,
        journeyCount = 0,
        offlineMapCount = 0;
}
