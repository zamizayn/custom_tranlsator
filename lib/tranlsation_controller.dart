import 'package:flutter/foundation.dart';

class TranslationController {
  TranslationController._privateConstructor();

  static final TranslationController _instance = TranslationController._privateConstructor();
  static TranslationController get instance => _instance;

  final ValueNotifier<String> _selectedLang = ValueNotifier<String>('en');
  ValueNotifier<String> get selectedLang => _selectedLang;

  void setLanguage(String langCode) {
    _selectedLang.value = langCode;
  }

  String get currentLanguage => _selectedLang.value;
}
