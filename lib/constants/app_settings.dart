class AppSettings {
  static int get appVersionInt => int.parse(_appVersion.replaceAll('.', ''));
  static String get appVersion => _appVersion;
  static const String _appVersion = '1.00.0';
}
