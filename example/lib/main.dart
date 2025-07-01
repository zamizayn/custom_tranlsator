import 'package:custom_google_translate/google_translate_extension.dart';
import 'package:custom_google_translate/tranlsation_controller.dart';
import 'package:flutter/material.dart';
import 'package:custom_google_translate/custom_google_translate.dart';

void main() {
  runApp(const TranslateExampleApp());
}

class TranslateExampleApp extends StatelessWidget {
  const TranslateExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translation Demo',
      home: const TranslationHome(),
    );
  }
}

class TranslationHome extends StatefulWidget {
  const TranslationHome({super.key});

  @override
  State<TranslationHome> createState() => _TranslationHomeState();
}

class _TranslationHomeState extends State<TranslationHome> {
  String _selectedLang = 'en'; // default: English

  // Language codes + labels
  final Map<String, String> _languages = {
    'af': 'Afrikaans',
    'sq': 'Albanian',
    'am': 'Amharic',
    'ar': 'Arabic',
    'hy': 'Armenian',
    'az': 'Azerbaijani',
    'eu': 'Basque',
    'be': 'Belarusian',
    'bn': 'Bengali',
    'bs': 'Bosnian',
    'bg': 'Bulgarian',
    'ca': 'Catalan',
    'ceb': 'Cebuano',
    'zh': 'Chinese (Simplified)',
    'zh-TW': 'Chinese (Traditional)',
    'co': 'Corsican',
    'hr': 'Croatian',
    'cs': 'Czech',
    'da': 'Danish',
    'nl': 'Dutch',
    'en': 'English',
    'eo': 'Esperanto',
    'et': 'Estonian',
    'fi': 'Finnish',
    'fr': 'French',
    'fy': 'Frisian',
    'gl': 'Galician',
    'ka': 'Georgian',
    'de': 'German',
    'el': 'Greek',
    'gu': 'Gujarati',
    'ht': 'Haitian Creole',
    'ha': 'Hausa',
    'haw': 'Hawaiian',
    'he': 'Hebrew',
    'hi': 'Hindi',
    'hmn': 'Hmong',
    'hu': 'Hungarian',
    'is': 'Icelandic',
    'ig': 'Igbo',
    'id': 'Indonesian',
    'ga': 'Irish',
    'it': 'Italian',
    'ja': 'Japanese',
    'jv': 'Javanese',
    'kn': 'Kannada',
    'kk': 'Kazakh',
    'km': 'Khmer',
    'rw': 'Kinyarwanda',
    'ko': 'Korean',
    'ku': 'Kurdish',
    'ky': 'Kyrgyz',
    'lo': 'Lao',
    'la': 'Latin',
    'lv': 'Latvian',
    'lt': 'Lithuanian',
    'lb': 'Luxembourgish',
    'mk': 'Macedonian',
    'mg': 'Malagasy',
    'ms': 'Malay',
    'ml': 'Malayalam',
    'mt': 'Maltese',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mn': 'Mongolian',
    'my': 'Myanmar (Burmese)',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'ny': 'Nyanja (Chichewa)',
    'or': 'Odia (Oriya)',
    'ps': 'Pashto',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'pa': 'Punjabi',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sm': 'Samoan',
    'gd': 'Scots Gaelic',
    'sr': 'Serbian',
    'st': 'Sesotho',
    'sn': 'Shona',
    'sd': 'Sindhi',
    'si': 'Sinhala (Sinhalese)',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'so': 'Somali',
    'es': 'Spanish',
    'su': 'Sundanese',
    'sw': 'Swahili',
    'sv': 'Swedish',
    'tl': 'Tagalog (Filipino)',
    'tg': 'Tajik',
    'ta': 'Tamil',
    'tt': 'Tatar',
    'te': 'Telugu',
    'th': 'Thai',
    'tr': 'Turkish',
    'tk': 'Turkmen',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'ug': 'Uyghur',
    'uz': 'Uzbek',
    'vi': 'Vietnamese',
    'cy': 'Welsh',
    'xh': 'Xhosa',
    'yi': 'Yiddish',
    'yo': 'Yoruba',
    'zu': 'Zulu',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TranslateText('TranslateText Widget Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder<String>(
              future: 'Select Language'.translated(),
              builder: (context, snapshot) {
                final translatedLabel = snapshot.data ?? 'Select Language';

                return TextFormField(
                  decoration: InputDecoration(
                    labelText: translatedLabel,
                  ),
                );
              },
            ),
            // Language selector dropdown
            DropdownButtonFormField<String>(
              value: _selectedLang,
              decoration: const InputDecoration(
                labelText: 'Select Language',
                border: OutlineInputBorder(),
              ),
              items: _languages.entries
                  .map((entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    TranslationController.instance.setLanguage(value);
                  });
                }
              },
            ),
            const SizedBox(height: 30),

            // Translated text
            TranslateText(
              "Hola mundo",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
