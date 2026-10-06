import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              onChanged: ref.read(authProvider.notifier).setEmail,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: authState.obscurePassword,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              onChanged: ref.read(authProvider.notifier).setPassword,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mostrar contraseña'),
              value: !authState.obscurePassword,
              onChanged: (_) =>
                  ref.read(authProvider.notifier).togglePasswordVisibility(),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      final bool ok =
                          await ref.read(authProvider.notifier).login();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ok
                                  ? 'Bienvenido, ${ref.read(authProvider).email}'
                                  : 'Error al iniciar sesión',
                            ),
                          ),
                        );
                      }
                    },
              child: authState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
