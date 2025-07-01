library custom_google_translate;

import 'dart:convert';
import 'package:custom_google_translate/tranlsation_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// A simple Google Translator using unofficial Google Translate API.
class GoogleTranslator {
  final String _baseUrl = 'https://translate.googleapis.com/translate_a/single';

  /// Translates [text] from [from] language to [to] language.
  ///
  /// [from] defaults to 'auto' (auto-detect), [to] defaults to 'en'.
  Future<String> translate(String text, {String from = 'auto', String to = 'en'}) async {
    final Uri url = Uri.parse(
      '$_baseUrl?client=gtx&sl=$from&tl=$to&dt=t&q=${Uri.encodeComponent(text)}',
    );

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body[0][0][0]; // Extract translated text
    } else {
      throw Exception('Translation failed: ${response.statusCode}');
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
              return const SizedBox(
                width: 20,
                height: 20,
                // child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
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