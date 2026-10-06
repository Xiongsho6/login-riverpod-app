import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/register_state.dart';

final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);

class RegisterNotifier extends Notifier<RegisterState> {
  static const String _apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  @override
  RegisterState build() => const RegisterState();

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<bool> register() async {
    if (state.isLoading) return false;
    state = state.copyWith(isLoading: true);
    try {
      final Uri endpoint = Uri.parse('$_apiBaseUrl/auth/register');
      await Future<void>.delayed(const Duration(seconds: 2));
      return endpoint.hasAuthority || _apiBaseUrl.isNotEmpty;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
