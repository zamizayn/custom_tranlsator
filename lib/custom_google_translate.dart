library custom_google_translate;

import 'dart:convert';
import 'dart:developer';
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

class TranslateText extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: TranslationController.instance.selectedLang,
      builder: (context, lang, _) {
        return FutureBuilder<String>(
          future: GoogleTranslator().translate(text, from: from, to: lang),
          builder: (context, snapshot) {
            if (lang == 'en') {
              return Text(
                text,
                style: style,
                textAlign: textAlign,
                textDirection: textDirection,
                locale: locale,
                softWrap: softWrap,
                overflow: overflow,
                textScaleFactor: textScaleFactor,
                maxLines: maxLines,
                semanticsLabel: semanticsLabel,
                strutStyle: strutStyle,
                textWidthBasis: textWidthBasis,
                textHeightBehavior: textHeightBehavior,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                text,
                style: style,
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: overflow,
              );
            } else if (snapshot.hasError) {
              return Text(
                text,
                style: style,
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: overflow,
              );
            } else {
              return Text(
                snapshot.data ?? '',
                style: style,
                textAlign: textAlign,
                textDirection: textDirection,
                locale: locale,
                softWrap: softWrap,
                overflow: overflow,
                textScaleFactor: textScaleFactor,
                maxLines: maxLines,
                semanticsLabel: semanticsLabel,
                strutStyle: strutStyle,
                textWidthBasis: textWidthBasis,
                textHeightBehavior: textHeightBehavior,
              );
            }
          },
        );
      },
    );
  }
}
