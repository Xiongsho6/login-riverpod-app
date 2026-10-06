import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/register_provider.dart';
import 'validators/form_validators.dart';
import 'widgets/app_text_field.dart';
import 'widgets/loading_button.dart';
import 'widgets/password_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final bool ok = await ref.read(registerProvider.notifier).register();
    if (!mounted) return;
    final String email = ref.read(registerProvider).email.trim();
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cuenta creada para $email')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear la cuenta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(registerProvider.select((state) => state.isLoading));
    final notifier = ref.read(registerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta'), centerTitle: true),
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
                    label: 'Nombre',
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.name,
                    onChanged: notifier.setName,
                    validator: FormValidators.name,
                  ),
                  const SizedBox(height: 16),
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
                    validator: FormValidators.newPassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  LoadingButton(
                    label: 'Registrarse',
                    isLoading: isLoading,
                    onPressed: _submit,
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
