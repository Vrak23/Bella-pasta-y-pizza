import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_logo.dart';

/// Pantalla 1: Splash y Bienvenida (Bella Pasta & Pizza)
/// Desarrollada como StatefulWidget con animaciones fluidas,
/// presentación de marca gastronómica y navegación automática o por botón.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  Timer? _navigationTimer;
  int _activeHighlightIndex = 0;
  Timer? _highlightTimer;

  final List<Map<String, dynamic>> _highlights = [
    {
      'icon': Icons.local_pizza_rounded,
      'title': 'Pizzas Artesanales',
      'desc': 'Masa madre al horno de piedra con ingredientes 100% frescos',
    },
    {
      'icon': Icons.dinner_dining_rounded,
      'title': 'Pastas Tradicionales',
      'desc': 'Recetas originales italianas: Fettuccine, Lasagna y Ravioles',
    },
    {
      'icon': Icons.delivery_dining_rounded,
      'title': 'Delivery Rápido',
      'desc': 'De nuestra cocina a tu mesa caliente y en minutos',
    },
  ];

  @override
  void initState() {
    super.initState();

    // 1. Configuración de controladores de animación
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animController.forward();

    // 2. Rotación de destacados
    _highlightTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _activeHighlightIndex =
              (_activeHighlightIndex + 1) % _highlights.length;
        });
      }
    });

    // 3. Temporizador para navegar automáticamente si el usuario no pulsa el botón
    _navigationTimer = Timer(const Duration(seconds: 6), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen({String route = AppRoutes.login}) {
    _navigationTimer?.cancel();
    _highlightTimer?.cancel();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _highlightTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Cabecera decorativa curvada con gradiente italiano
          ClipPath(
            clipper: _HeaderCurvedClipper(),
            child: Container(
              height: size.height * 0.42,
              decoration: const BoxDecoration(
                gradient: AppColors.splashGradient,
              ),
              child: Stack(
                children: [
                  // Motivo decorativo de fondo translúcido
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: -30,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  // Banderita italiana sutil en la parte superior
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 60,
                        height: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.italianGreen,
                              Colors.white,
                              AppColors.italianRed,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Contenido Principal animado
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),

                // Logo Central Animado (Scale + Fade)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Center(
                      child: Hero(
                        tag: 'app_logo',
                        child: Material(
                          color: Colors.transparent,
                          child: const AppLogo(
                            size: 130,
                            showSubtitle: true,
                            isDark: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Sección Deslizable (Highlights + CTA)
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tarjeta de Beneficio Destacado (Uso de Card & Row)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, anim) =>
                                FadeTransition(opacity: anim, child: child),
                            child: Card(
                              key: ValueKey<int>(_activeHighlightIndex),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        _highlights[_activeHighlightIndex]
                                            ['icon'] as IconData,
                                        color: AppColors.primary,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _highlights[_activeHighlightIndex]
                                                ['title'] as String,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _highlights[_activeHighlightIndex]
                                                ['desc'] as String,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Indicadores de puntos (Dots)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _highlights.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                width:
                                    _activeHighlightIndex == index ? 20 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: _activeHighlightIndex == index
                                      ? AppColors.primary
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Botón Principal: Comenzar Ahora
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () => _navigateToNextScreen(
                                route: AppRoutes.login,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Comenzar Pedido',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Acceso rápido opcional al menú
                          TextButton(
                            onPressed: () => _navigateToNextScreen(
                              route: AppRoutes.menu,
                            ),
                            child: Text(
                              'Explorar Menú Directo',
                              style: GoogleFonts.poppins(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Pie de página institucional
                          Text(
                            'Bella Pasta & Pizza • Tradición Italiana',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Clipper para crear la curva suave de la cabecera del Splash
class _HeaderCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);

    final firstControlPoint = Offset(size.width / 2, size.height + 25);
    final firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
