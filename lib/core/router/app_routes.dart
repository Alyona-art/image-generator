class AppRoutes {
  static const String home = '/';
  static const String result = '/result';

  static String resultWithPrompt(String prompt) {
    return '$result?prompt=${Uri.encodeComponent(prompt)}';
  }
}
