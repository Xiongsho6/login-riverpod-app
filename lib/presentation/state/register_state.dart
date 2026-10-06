class RegisterState {
  final String name;
  final String email;
  final String password;
  final bool isLoading;
  final bool obscurePassword;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.obscurePassword = true,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLoading,
    bool? obscurePassword,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
