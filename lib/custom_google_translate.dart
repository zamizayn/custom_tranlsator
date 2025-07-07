library custom_google_translate;

import 'dart:convert';
import 'package:custom_google_translate/tranlsation_controller.dart';
import 'package:custom_google_translate/translation_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// A simple Google Translator using unofficial Google Translate API.
///
///
class GoogleTranslator {
  final String _baseUrl =
      'https://translation.googleapis.com/language/translate/v2';

  /// Translates [text] from [from] language to [to] language.
  Future<String> translate(String text,
      {String from = 'auto', String to = 'auto'}) async {
    final apiKey = TranslationConfig.apiKey;
    final Uri url = Uri.parse('$_baseUrl?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'source': 'en',
        'target': to,
        'format': 'text',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return body['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Translation failed: ${response.body}');
    }
  }
}

class TranslateText extends StatefulWidget {
  final String text;
  final String from;

  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const TranslateText(
    this.text, {
    Key? key,
    this.from = 'auto',
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  State<TranslateText> createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {

   String? _translatedText;
  String? _lastLang;

  @override
  void initState() {
    super.initState();
    _lastLang = TranslationController.instance.selectedLang.value;
    _fetchTranslation(_lastLang!);
  }

  void _fetchTranslation(String lang) async {
    if (lang == 'en') {
      setState(() {
        _translatedText = widget.text;
      });
      return;
    }

    try {
      final translated = await GoogleTranslator().translate(
        widget.text,
        from: widget.from,
        to: lang,
      );
      if (mounted) {
        setState(() {
          _translatedText = translated;
          _lastLang = lang;
        });
      }
    } catch (e) {
      // fallback
      if (mounted) {
        setState(() {
          _translatedText = widget.text;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: TranslationController.instance.selectedLang,
      builder: (context, lang, _) {
        if (lang != _lastLang) {
          _fetchTranslation(lang);
        }

        return Text(
          _translatedText ?? widget.text,
          style: widget.style,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          locale: widget.locale,
          softWrap: widget.softWrap,
          overflow: widget.overflow,
          textScaleFactor: widget.textScaleFactor,
          maxLines: widget.maxLines,
          semanticsLabel: widget.semanticsLabel,
          strutStyle: widget.strutStyle,
          textWidthBasis: widget.textWidthBasis,
          textHeightBehavior: widget.textHeightBehavior,
        );
      },
    );
  }
}