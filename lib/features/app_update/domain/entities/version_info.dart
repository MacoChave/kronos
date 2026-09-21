class VersionInfo {
  final String version;
  final int buildNumber;
  final String url;
  final List<String> releaseNotes;

  const VersionInfo({
    required this.version,
    required this.buildNumber,
    required this.url,
    required this.releaseNotes,
  });

  bool isNewerThan(String currentVersion, int currentBuild) {
    return (currentVersion != version && buildNumber > currentBuild);
  }
}
