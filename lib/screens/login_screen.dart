import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/app_logo.dart';

/// Pantalla 2: Registro y Login.
/// Asignada al Integrante 2.
///
/// Incluye formularios, controladores, validación de correo y contraseña,
/// confirmación de contraseña y avatar de perfil.
///
/// Nota académica: el flujo es una demostración local. Para autenticar cuentas
/// reales se debe conectar posteriormente un backend o proveedor de identidad.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isRegistering = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Ingresa tus nombres y apellidos.';
    if (name.length < 3) return 'El nombre debe tener al menos 3 caracteres.';
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Ingresa tu correo electrónico.';

    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
    if (!emailPattern.hasMatch(email)) {
      return 'Ingresa un correo electrónico válido.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Ingresa tu contraseña.';
    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }
    return null;
  }

  String? _validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña.';
    }
    if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden.';
    }
    return null;
  }

  void _changeMode(bool registering) {
    if (_isRegistering == registering) return;
    setState(() {
      _isRegistering = registering;
      _obscurePassword = true;
      _obscureConfirmPassword = true;
    });
    _formKey.currentState?.reset();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final name = _isRegistering
        ? _nameController.text.trim()
        : _nameFromEmail(email);

    // Se crea un modelo sin incluir la contraseña.
    final user = UserModel(name: name, email: email);

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.menu,
      arguments: user,
    );
  }

  String _nameFromEmail(String email) {
    final userPart = email.split('@').first.replaceAll(RegExp(r'[._-]+'), ' ');
    if (userPart.isEmpty) return 'Cliente';

    return userPart
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.16),
          width: 1.5,
        ),
      ),
      child: const Icon(
        Icons.person_rounded,
        size: 54,
        color: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRegistering = _isRegistering;

    return Scaffold(
      appBar: AppBar(
        title: Text(isRegistering ? 'Crear cuenta' : 'Registro y Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  const AppLogo(size: 82, showSubtitle: false),
                  const SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shadowColor: Colors.black.withValues(alpha: 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
                      child: Form(
                        key: _formKey,
                        child: AutofillGroup(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(child: _buildAvatar()),
                              const SizedBox(height: 18),
                              Text(
                                isRegistering
                                    ? '¡Únete a Bella Pasta!'
                                    : 'Iniciar sesión',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                isRegistering
                                    ? 'Crea tu cuenta para disfrutar de tus pizzas y pastas favoritas.'
                                    : 'Ingresa tus credenciales para continuar con tu pedido.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 26),
                              if (isRegistering) ...[
                                TextFormField(
                                  controller: _nameController,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.name],
                                  validator: _validateName,
                                  decoration: _inputDecoration(
                                    label: 'Nombres y apellidos',
                                    icon: Icons.person_outline_rounded,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.email],
                                validator: _validateEmail,
                                decoration: _inputDecoration(
                                  label: 'Correo electrónico',
                                  icon: Icons.email_outlined,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                textInputAction: isRegistering
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                autofillHints: isRegistering
                                    ? const [AutofillHints.newPassword]
                                    : const [AutofillHints.password],
                                validator: _validatePassword,
                                onFieldSubmitted: isRegistering
                                    ? null
                                    : (_) => _submitForm(),
                                decoration: _inputDecoration(
                                  label: 'Contraseña',
                                  icon: Icons.lock_outline_rounded,
                                  suffixIcon: IconButton(
                                    tooltip: _obscurePassword
                                        ? 'Mostrar contraseña'
                                        : 'Ocultar contraseña',
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              if (isRegistering) ...[
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: _obscureConfirmPassword,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.newPassword],
                                  validator: _validatePasswordConfirmation,
                                  onFieldSubmitted: (_) => _submitForm(),
                                  decoration: _inputDecoration(
                                    label: 'Confirmar contraseña',
                                    icon: Icons.lock_reset_rounded,
                                    suffixIcon: IconButton(
                                      tooltip: _obscureConfirmPassword
                                          ? 'Mostrar contraseña'
                                          : 'Ocultar contraseña',
                                      onPressed: () {
                                        setState(() {
                                          _obscureConfirmPassword =
                                              !_obscureConfirmPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscureConfirmPassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 26),
                              SizedBox(
                                height: 54,
                                child: ElevatedButton.icon(
                                  onPressed: _submitForm,
                                  icon: Icon(
                                    isRegistering
                                        ? Icons.person_add_alt_1_rounded
                                        : Icons.login_rounded,
                                  ),
                                  label: Text(
                                    isRegistering ? 'Crear cuenta' : 'Ingresar',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      isRegistering
                                          ? '¿Ya tienes una cuenta?'
                                          : '¿Todavía no tienes una cuenta?',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        _changeMode(!isRegistering),
                                    child: Text(
                                      isRegistering
                                          ? 'Inicia sesión'
                                          : 'Regístrate',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Bella Pasta & Pizza · SENATI',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
