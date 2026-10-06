class AuthState {
  final String email;
  final String password;
  final bool isLoading;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
  });

  AuthState copyWith({String? email, String? password, bool? isLoading}) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
