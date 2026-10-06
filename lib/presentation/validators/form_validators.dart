class FormValidators {
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? name(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Ingresa tu nombre';
    if (text.length < 2) return 'El nombre es muy corto';
    return null;
  }

  static String? email(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Ingresa tu email';
    if (!_emailRegex.hasMatch(text)) return 'Email no válido';
    return null;
  }

  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
    return null;
  }

  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }
}
