class AuthState {
  final String email;
  final String password;
  final bool isLoading;
  final bool obscurePassword;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.obscurePassword = true,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
