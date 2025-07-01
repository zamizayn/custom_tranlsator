import 'package:custom_google_translate/tranlsation_controller.dart';
import 'package:custom_google_translate/custom_google_translate.dart';

extension TranslateExtension on String {
  /// Translates this string to the selected language.
  ///
  /// Returns the original string if translation fails or if language is 'en'.
  Future<String> translated({String from = 'auto'}) async {
    final lang = TranslationController.instance.selectedLang.value;

    if (lang == 'en') return this;

    try {
      return await GoogleTranslator().translate(this, from: from, to: lang);
    } catch (_) {
      return this; // Fallback to original text
    }
  }
}
