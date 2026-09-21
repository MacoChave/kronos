import 'dart:convert';

import 'package:kronos/features/app_update/domain/entities/version_info.dart';

class VersionInfoModel extends VersionInfo {
  const VersionInfoModel({
    required super.version,
    required super.buildNumber,
    required super.url,
    required super.releaseNotes,
  });

  factory VersionInfoModel.fromJson(String flavorString, String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString)[flavorString];

    return VersionInfoModel(
      version: data['version'] ?? '',
      buildNumber: data['buildNumber'] ?? 0,
      url: data['url'] ?? '',
      releaseNotes: (data['release_notes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
