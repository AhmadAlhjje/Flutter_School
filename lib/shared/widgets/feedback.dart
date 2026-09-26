import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Success messages are green, failures red, anything else the default dark.
enum FeedbackTone { success, error, info }

/// A short message at the bottom of the screen, colored by [tone] (e.g. "password changed" in
/// green). [content] is usually a [Text]; a widget lets the text be localized where it is shown.
SnackBar feedbackSnackBar(
  Widget content, {
  FeedbackTone tone = FeedbackTone.success,
  Duration duration = const Duration(seconds: 4),
  SnackBarAction? action,
}) {
  final (background, icon) = switch (tone) {
    FeedbackTone.success => (AppColors.success, Icons.check_circle_rounded),
    FeedbackTone.error => (AppColors.danger, Icons.error_rounded),
    FeedbackTone.info => (null, Icons.info_rounded),
  };
  return SnackBar(
    backgroundColor: background,
    duration: duration,
    action: action == null
        ? null
        : SnackBarAction(label: action.label, onPressed: action.onPressed, textColor: Colors.white),
    content: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            child: content,
          ),
        ),
      ],
    ),
  );
}

void showFeedback(
  ScaffoldMessengerState messenger,
  String message, {
  FeedbackTone tone = FeedbackTone.success,
  Duration duration = const Duration(seconds: 4),
  SnackBarAction? action,
}) {
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(feedbackSnackBar(Text(message), tone: tone, duration: duration, action: action));
}
