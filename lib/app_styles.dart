import 'package:flutter/material.dart';

// --- PALET WARNA ---
class AppColors {
  static const Color primary = Color(0xFF0D6EFD);
  static const Color lightBlue = Color(0xFFA6C7FF);
  static const Color background = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color danger = Color(0xFFDC3545);
}

// --- GAYA TEKS ---
class AppTextStyles {
  static const TextStyle headerTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle profileName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [Shadow(blurRadius: 5, color: Colors.black26)],
  );

  static const TextStyle profileEmail = TextStyle(
    fontSize: 15,
    color: Colors.white70,
  );

  static const TextStyle settingItem = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textPrimary,
  );
}