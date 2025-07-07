class TranslationConfig {
  static String? _apiKey;

  /// Set your API key once.
  static void init(String apiKey) {
    _apiKey = apiKey;
  }

  static String get apiKey {
    if (_apiKey == null) {
      throw Exception(
          'Google Translate API key is not set. Call TranslationConfig.init(apiKey) first.');
    }
    return _apiKey!;
  }
}
