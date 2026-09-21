import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kronos/features/app_update/data/models/version_info_model.dart';
import 'package:kronos/features/app_update/domain/entities/version_info.dart';
import 'package:kronos/core/config/flavor_config.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class UpdateService {
  /// Asegura que los enlaces de Dropbox se descarguen en lugar de mostrar la página web
  static String _formatUrl(String url) {
    if (url.contains('dropbox.com')) {
      return url.replaceAll('dl=0', 'dl=1');
    }
    return url;
  }

  /// Descarga el .md del flavor actual y compara con la versión instalada
  static Future<VersionInfo?> checkForUpdates() async {
    try {
      final url = FlavorConfig.instance.updateUrl;
      var parse = Uri.parse(_formatUrl(url));
      final response = await http.get(parse);

      if (response.statusCode != 200) return null;

      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;
      final currentBuild = int.tryParse(info.buildNumber) ?? 0;

      final remote = VersionInfoModel.fromJson(
          currentVersion.split('-').last ?? 'prod', response.body);

      return remote.isNewerThan(currentVersion, currentBuild) ? remote : null;
    } catch (error) {
      return null;
    }
  }

  /// Descarga el APK y lo abre para instalar
  static Future<void> downloadAndInstall(
    VersionInfo info, {
    required ValueChanged<double> onProgress,
  }) async {
    try {
      final dir = await getExternalStorageDirectory();
      final path = '${dir!.path}/update.apk';

      final client = http.Client();
      final finalApkUrl = _formatUrl(info.url);
      final request =
          await client.send(http.Request('GET', Uri.parse(finalApkUrl)));

      if (request.statusCode != 200) {
        throw Exception('Falló la descarga con código: ${request.statusCode}');
      }

      if (request.headers['content-type']?.contains('text/html') == true) {
        throw Exception(
            'El enlace de descarga devolvió una página HTML en lugar del APK. Verifica el enlace (por ej. advertencia de Google Drive).');
      }

      final total = request.contentLength ?? 1;

      final file = File(path);
      final sink = file.openWrite();
      int received = 0;

      await for (final chunk in request.stream) {
        sink.add(chunk);
        received += chunk.length;
        onProgress(received / total);
      }

      await sink.flush();
      await sink.close();
      await OpenFilex.open(path,
          type: 'application/vnd.android.package-archive');
    } catch (e) {
      if (kDebugMode) {
        print('Error durante la descarga o instalación: $e');
      }
    }
  }
}
