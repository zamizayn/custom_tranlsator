# custom_google_translate

A customizable Flutter package to easily translate your app's text widgets using Google Translate API. Supports global language switching and a reusable `TranslateText` widget to simplify translations.

---

## ✨ Features

- 🌐 Translate any text into 100+ languages using Google Translate API.
- 🧠 Cache and manage a global target language without having to pass it every time.
- 🧱 `TranslateText` widget works just like Flutter's `Text` widget.
- 🎯 Option to dynamically change language at runtime.
- 📦 Easy integration into any Flutter project.

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  custom_google_translate: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🧪 Usage



### 1. Wrap Your App With `TranslationControllerProvider`

```dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationConfig.init('API_KEY');
  runApp(const TranslateExampleApp());
}
```

### 2. Use the `TranslateText` Widget

```dart
TranslateText(
  'Hola mundo',
  style: TextStyle(fontSize: 24),
)
```

By default, the target language is English. To change it:

```dart
TranslationController.instance.setLanguage('hi'); // Set to Hindi
```

---

## 🌍 Supported Languages

All Google Translate-supported languages are available, including:

- English (`en`)
- Hindi (`hi`)
- Spanish (`es`)
- French (`fr`)
- German (`de`)
- Japanese (`ja`)
- Chinese (`zh`)
- Arabic (`ar`)
- Russian (`ru`)
- And many more...

You can use the `_languages` map provided in the example to populate dropdowns.

---

## 📂 Example

```dart
import 'package:flutter/material.dart';
import 'package:custom_google_translate/custom_google_translate.dart';

void main() {
  runApp(TranslationControllerProvider(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translation Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TranslateText Widget Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: TranslationController.instance.currentLanguage,
              items: _languages.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  TranslationController.instance.setLanguage(value);
                }
              },
            ),
            const SizedBox(height: 20),
            const TranslateText(
              "Hola mundo",
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## ⚠️ Important Notes

- This package uses the **unofficial free Google Translate API** (via `translate.googleapis.com`). For production apps, consider using an authenticated or official service to ensure long-term reliability.
- Internet access is required for translation.

---

## 📄 License

MIT License

---

## 💬 Contributing

Feel free to open issues or pull requests on [GitHub](https://github.com/your_username/custom_google_translate).
