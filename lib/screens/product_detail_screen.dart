import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 4: Detalle y Personalización
/// Asignada a: Integrante 4
/// Responsabilidades:
/// - Visualización de la pizza/pasta seleccionada
/// - Selector de tamaño (Personal, Mediana, Familiar)
/// - Checkbox / Switches para ingredientes adicionales
/// - Cálculo de subtotal y total en tiempo real con setState()
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel?;

    return Scaffold(
      appBar: AppBar(
        title: Text(product != null ? product.name : 'Detalle y Personalización'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.tune_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                product?.name ?? 'Personalización de Producto',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (product != null) ...[
                const SizedBox(height: 6),
                Text(
                  product.formattedPrice,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                product?.description ??
                    'Aquí se seleccionan los ingredientes adicionales y se calcula el total.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart_rounded),
                label: const Text('Agregar al Carrito'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
