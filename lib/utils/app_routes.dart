import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/order_history_screen.dart';

/// Definición centralizada de las rutas del reto integrador SENATI:
/// 1. Splash / Bienvenida
/// 2. Registro y Login
/// 3. Menú de Categorías
/// 4. Detalle y Personalización
/// 5. Carrito de Compras
/// 6. Confirmación de Pedido
/// + Historial de Pedidos (SQLite)
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String menu = '/menu';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String orderSuccess = '/order-success';
  static const String orderHistory = '/order-history';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        login: (context) => const LoginScreen(),
        menu: (context) => const MenuScreen(),
        productDetail: (context) => const ProductDetailScreen(),
        cart: (context) => const CartScreen(),
        orderSuccess: (context) => const OrderSuccessScreen(),
        orderHistory: (context) => const OrderHistoryScreen(),
      };
}
