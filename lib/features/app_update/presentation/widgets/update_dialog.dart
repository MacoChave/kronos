import 'package:flutter/material.dart';
import 'package:kronos/core/theme/silk_theme.dart';
import 'package:kronos/core/widgets/NeuDialog.dart';
import 'package:kronos/features/app_update/domain/entities/version_info.dart';

import '../../data/services/update_service.dart';

class UpdateDialog extends StatefulWidget {
  final VersionInfo info;
  const UpdateDialog({super.key, required this.info});

  static Future<void> show(BuildContext context, VersionInfo info) {
    return NeuDialog.show(
      context: context,
      barrierDismissible: true,
      child: UpdateDialog(info: info),
    );
  }

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  double _progress = 0;
  bool _downloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: context.silk.card(radius: 14),
            child: Icon(Icons.system_update_rounded,
                color: context.silk.primary, size: 24),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nueva versión', style: context.silk.heading),
              Text('v${widget.info.version}',
                  style: context.silk.body.copyWith(color: context.silk.onSurface)),
            ],
          )
        ]),

        const SizedBox(height: 20),

        // Release notes
        Flexible(
          child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.2),
              padding: const EdgeInsets.all(16),
              decoration: context.silk.input(radius: 14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Novedades:',
                        style: context.silk.body
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...widget.info.releaseNotes.map((note) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ',
                                style: TextStyle(
                                    fontSize: 16, color: context.silk.onSurface)),
                            Expanded(
                              child: Text(note,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: context.silk.body
                                      .copyWith(color: context.silk.onSurface)),
                            ),
                          ],
                        ))
                  ],
                ),
              )),
        ),

        const SizedBox(height: 20),

        // Progress bar (only visible while downloading)
        if (_downloading) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: context.silk.background,
                color: context.silk.primary,
                minHeight: 6),
          ),
          const SizedBox(height: 20),
          Text(
            'Descargando... ${(_progress * 100).toStringAsFixed(0)}%',
            style: context.silk.body.copyWith(color: context.silk.onSurface),
          ),
          const SizedBox(height: 16),
        ],

        // Action button
        Row(
          children: [
            // Not now
            if (!_downloading)
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: context.silk.buttonRaised(),
                    alignment: Alignment.center,
                    child: Text('Ahora no', style: context.silk.caption),
                  ),
                ),
              ),

            if (!_downloading) const SizedBox(width: 12),

            // Download
            Expanded(
                child: GestureDetector(
              onTap: _downloading ? null : _startDownload,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: context.silk.buttonRaised(),
                alignment: Alignment.center,
                child: Text(_downloading ? 'Descargando...' : 'Actualizar',
                    style: context.silk.button),
              ),
            ))
          ],
        )
      ],
    );
  }

  Future<void> _startDownload() async {
    setState(() => _downloading = true);
    await UpdateService.downloadAndInstall(
      widget.info,
      onProgress: (p) => setState(() => _progress = p),
    );
    if (mounted) Navigator.pop(context);
  }
}
