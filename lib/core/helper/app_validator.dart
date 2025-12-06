abstract class AppValidator {
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }
    return null;
  }
}
