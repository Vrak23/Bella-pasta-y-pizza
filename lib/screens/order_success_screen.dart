import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 6: Confirmación de Pedido
/// Asignada a: Integrante 6
/// Responsabilidades:
/// - Inserción del pedido en SQLite (sqflite)
/// - Mensaje de éxito con ícono animado / checkmark verde
/// - Resumen del pedido guardado en la base de datos
/// - Botón para regresar al inicio / nuevo pedido
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary.withValues(alpha: 0.15),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 64,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '¡Pedido Confirmado!',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.secondary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tu pedido ha sido registrado en la base de datos local y el chef ya está preparando tu orden.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.menu,
                        (route) => false,
                      );
                    },
                    child: const Text('Volver al Menú'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
