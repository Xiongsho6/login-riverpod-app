import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'register_screen.dart';
import 'validators/form_validators.dart';
import 'widgets/app_text_field.dart';
import 'widgets/loading_button.dart';
import 'widgets/password_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final bool ok = await ref.read(authProvider.notifier).login();
    if (!mounted) return;
    final String email = ref.read(authProvider).email.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Bienvenido, $email' : 'Error al iniciar sesión'),
      ),
    );
  }

  void _openRegister() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(authProvider.select((state) => state.isLoading));
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: notifier.setEmail,
                    validator: FormValidators.email,
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    onChanged: notifier.setPassword,
                    validator: FormValidators.loginPassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  LoadingButton(
                    label: 'Ingresar',
                    isLoading: isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: isLoading ? null : _openRegister,
                    child: const Text('¿No tienes cuenta? Regístrate'),
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
