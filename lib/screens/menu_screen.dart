import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 3: Menú de Categorías
/// Asignada a: Integrante 3
/// Responsabilidades:
/// - Listado de categorías (Pizzas, Pastas, Bebidas, Promociones)
/// - Grid o Listview con Cards para los productos
/// - Barra inferior de navegación (BottomNavigationBar)
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Bella Pasta & Pizza'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Menú de Categorías',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Aquí se listarán las pizzas, pastas y bebidas con sus precios.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.local_pizza_outlined),
                label: const Text('Ver Detalle de Producto'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.productDetail);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
