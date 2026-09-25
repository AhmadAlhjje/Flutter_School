import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../domain/file_entities.dart';

IconData fileKindIcon(FileKind kind) => switch (kind) {
  FileKind.pdf => Icons.picture_as_pdf_rounded,
  FileKind.document => Icons.description_rounded,
  FileKind.presentation => Icons.slideshow_rounded,
  FileKind.spreadsheet => Icons.table_chart_rounded,
  FileKind.archive => Icons.folder_zip_rounded,
  FileKind.image => Icons.image_rounded,
  FileKind.other => Icons.insert_drive_file_rounded,
};

Color fileKindColor(FileKind kind) => switch (kind) {
  FileKind.pdf => AppColors.danger,
  FileKind.spreadsheet => AppColors.success,
  FileKind.presentation => AppColors.warning,
  _ => AppColors.primary,
};

/// A file row: kind icon, extension and size. Opens the in-app viewer.
class FileTile extends StatelessWidget {
  const FileTile({super.key, required this.file});

  final FileItem file;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final color = fileKindColor(file.kind);
    return ContentTile(
      title: file.title,
      subtitle: '${file.extension.toUpperCase()} · ${formatBytes(file.sizeBytes, locale: locale)}',
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(fileKindIcon(file.kind), color: color),
      ),
      onTap: () => context.push(Uri(path: Routes.file(file.id), queryParameters: {'title': file.title}).toString()),
    );
  }
}
