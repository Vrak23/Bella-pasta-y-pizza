import 'package:flutter/material.dart';

/// Paleta de colores oficial para Bella Pasta & Pizza (SENATI)
/// Inspirada en la gastronomía italiana: albahaca fresca, salsa pomodoro y masa artesanal.
class AppColors {
  // Colores Principales (Rojo Pomodoro)
  static const Color primary = Color(0xFFC62828);
  static const Color primaryDark = Color(0xFF8E0000);
  static const Color primaryLight = Color(0xFFFF5F52);

  // Colores Secundarios (Verde Albahaca)
  static const Color secondary = Color(0xFF2E7D32);
  static const Color secondaryDark = Color(0xFF005005);
  static const Color secondaryLight = Color(0xFF60AD5E);

  // Acentos (Queso Mozzarella & Horno a la Leña)
  static const Color accent = Color(0xFFFFA000);
  static const Color accentLight = Color(0xFFFFD54F);

  // Fondos y Superficies
  static const Color background = Color(0xFFFBF8F5);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Textos
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color textLight = Colors.white;

  // Bandera Italiana Oficial
  static const Color italianGreen = Color(0xFF009246);
  static const Color italianWhite = Color(0xFFFFFFFF);
  static const Color italianRed = Color(0xFFCE2B37);

  // Estados & Bordes
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);

  // Degradados
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary, primaryDark],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, primaryDark],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFD32F2F),
      Color(0xFFC62828),
      Color(0xFF8E0000),
    ],
  );
}
