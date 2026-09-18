import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---- Brand (emerald) ----
  static const Color primary = Color(0xFF0C6E4F); // deep emerald
  static const Color primaryDark = Color(0xFF084C37); // darker emerald
  static const Color primaryLight = Color(0xFFE3F0EB); // soft tint
  static const Color accent = Color(0xFFC9A24B); // subtle gold (luxury touch)

  // ---- Surfaces ----
  static const Color background = Color(0xFFF6F8F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFEFEFEF);
  static const Color border = Color(0xFFEAEDEC);
  static const Color fieldFill = Color(0xFFF1F4F2);

  // ---- Text ----
  static const Color textPrimary = Color(0xFF14201B);
  static const Color textSecondary = Color(0xFF6F7787);

  // ---- Status ----
  static const Color danger = Color(0xFFE53E3E);
  static const Color star = Color(0xFFFFC107);
  static const Color price = Color(0xFF0C6E4F);
  static const Color disabled = Color(0xFFB0B6BE);

  // ---- Professional soft shadows (cards / buttons) ----
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: const Color(0xFF0C6E4F).withOpacity(0.07),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get subtleShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ];
}
