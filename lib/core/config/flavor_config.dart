enum Flavor { dev, staging, prod }

class FlavorConfig {
  final Flavor flavor;
  final String updateUrl;

  const FlavorConfig({required this.flavor, required this.updateUrl});

  static late FlavorConfig instance;

  String get name => flavor.name;

  // factory FlavorConfig({required Flavor flavor, required String driveFileId}) {
  //   _instance = FlavorConfig._internal(flavor, driveFileId);
  //   return _instance;
  // }

  // FlavorConfig._internal(this.flavor, this.driveFileId);
  // static FlavorConfig get instance => _instance;
}
