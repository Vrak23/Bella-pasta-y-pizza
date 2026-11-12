import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

/// Widget de logotipo para Bella Pasta & Pizza.
/// Soporta modo compacto para AppBars y modo completo para Splash / Login.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showSubtitle;
  final bool isDark;

  const AppLogo({
    super.key,
    this.size = 140,
    this.showSubtitle = true,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Emblema circular con sombrero de chef y cinta italiana
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.primary,
              width: size > 100 ? 4 : 2,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Banderola tricolor curva superior
              Positioned(
                top: size * 0.12,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size * 0.14,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.italianGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: size * 0.14,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Container(
                      width: size * 0.14,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.italianRed,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              // Icono de chef / pizza central
              Icon(
                Icons.restaurant_menu_rounded,
                size: size * 0.45,
                color: AppColors.primary,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Nombre "Bella" en tipografía itálica estilizada
        Text(
          'Bella',
          style: GoogleFonts.playfairDisplay(
            fontSize: size * 0.28,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            color: isDark ? Colors.white : AppColors.primary,
            letterSpacing: 1.2,
          ),
        ),

        // Subtítulo "PASTA & PIZZA"
        Text(
          'PASTA & PIZZA',
          style: GoogleFonts.poppins(
            fontSize: (size * 0.12).clamp(10, 18),
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
            color: isDark ? Colors.white70 : AppColors.textPrimary,
          ),
        ),

        if (showSubtitle) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 18, height: 2, color: AppColors.italianGreen),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'AUTÉNTICO SABOR ITALIANO',
                  style: GoogleFonts.poppins(
                    fontSize: (size * 0.08).clamp(8, 12),
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white60 : AppColors.secondary,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(width: 18, height: 2, color: AppColors.italianRed),
            ],
          ),
        ],
      ],
    );
  }
}
