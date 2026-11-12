import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 5: Carrito de Compras
/// Asignada a: Integrante 5
/// Responsabilidades:
/// - Estado global con Provider (CartProvider)
/// - Listado de ítems agregados con cantidades (+ / -) y botón eliminar
/// - Resumen de costo (subtotal, delivery, total)
/// - Botón Continuar hacia la confirmación
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Tu Carrito de Compras',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Gestionado con Provider para sincronizar cantidades y totales.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('Confirmar Pedido'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.orderSuccess);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
