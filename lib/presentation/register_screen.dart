import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/register_provider.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              onChanged: ref.read(registerProvider.notifier).setName,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              onChanged: ref.read(registerProvider.notifier).setEmail,
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: registerState.obscurePassword,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              onChanged: ref.read(registerProvider.notifier).setPassword,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mostrar contraseña'),
              value: !registerState.obscurePassword,
              onChanged: (_) => ref
                  .read(registerProvider.notifier)
                  .togglePasswordVisibility(),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: registerState.isLoading
                  ? null
                  : () async {
                      final bool ok =
                          await ref.read(registerProvider.notifier).register();
                      if (context.mounted) {
                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Cuenta creada para ${ref.read(registerProvider).email}',
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al crear la cuenta'),
                            ),
                          );
                        }
                      }
                    },
              child: registerState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
