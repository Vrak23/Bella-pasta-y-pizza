import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 2: Registro y Login
/// Asignada a: Integrante 2
/// Responsabilidades:
/// - Campos de entrada (Usuario / Email, Contraseña)
/// - Validación de formularios y controladores de texto
/// - Botón para iniciar sesión y enlace para registrarse
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar de usuario circular
            CircleAvatar(
              radius: 46,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: const Icon(
                Icons.person_rounded,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¡Bienvenido de vuelta!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Ingresa tus credenciales para ordenar tus pizzas y pastas favoritas.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.menu);
                },
                child: const Text('Ingresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
