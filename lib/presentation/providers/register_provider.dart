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

  Future<bool> register() async {
    if (state.isLoading) return false;
    state = state.copyWith(isLoading: true);
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (_apiBaseUrl.isEmpty) return true;
      final Uri endpoint = Uri.parse('$_apiBaseUrl/auth/register');
      return endpoint.hasAuthority;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
