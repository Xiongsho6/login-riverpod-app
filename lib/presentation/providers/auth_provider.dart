import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  static const String _apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  @override
  AuthState build() => const AuthState();

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<bool> login() async {
    if (state.isLoading) return false;
    state = state.copyWith(isLoading: true);
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (_apiBaseUrl.isEmpty) return true;
      final Uri endpoint = Uri.parse('$_apiBaseUrl/auth/login');
      return endpoint.hasAuthority;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
