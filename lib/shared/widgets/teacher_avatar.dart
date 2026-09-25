import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';

/// Teacher photo (served by the API) or initials.
class TeacherAvatar extends StatelessWidget {
  const TeacherAvatar({super.key, required this.name, this.imagePath, this.size = 44, this.muted = false});

  final String name;

  /// API-relative path such as `/api/v1/media/teachers/<id>/image?v=...`.
  final String? imagePath;
  final double size;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().split(RegExp(r'\s+')).take(2).map((part) => part.isEmpty ? '' : part[0]).join();
    final fallback = CircleAvatar(
      radius: size / 2,
      backgroundColor: muted ? AppColors.muted : AppColors.primarySoft,
      child: Text(
        initials,
        style: TextStyle(color: muted ? AppColors.secondary : AppColors.primary, fontWeight: FontWeight.w700),
      ),
    );
    if (imagePath == null) return fallback;
    return ClipOval(
      child: Opacity(
        opacity: muted ? 0.55 : 1,
        child: Image.network(
          '${AppConfig.apiBaseUrl}$imagePath',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => fallback,
        ),
      ),
    );
  }
}
