import 'package:flutter/material.dart';

/// Brand palette — identical to the dashboards' design tokens (spec §9).
abstract final class AppColors {
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1D4ED8);
  static const text = Color(0xFF0F172A);
  static const secondary = Color(0xFF64748B);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFDC2626);
  static const border = Color(0xFFE2E8F0);

  static const primarySoft = Color(0xFFE9F0FD);
  static const successSoft = Color(0xFFE8F6EC);
  static const dangerSoft = Color(0xFFFCE9E9);
  static const muted = Color(0xFFF1F5F9);
}
