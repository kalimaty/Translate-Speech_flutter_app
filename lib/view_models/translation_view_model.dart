import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class TranslationViewModel with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  final GoogleTranslator _translator = GoogleTranslator();
  final TextEditingController textController = TextEditingController();

  List<String> _translatedTexts = List.filled(9, '');
  List<bool> _showTranslation = List.filled(9, false);
  bool _loading = false;
  String _inputText = '';

  final List<String> _languagesCode = [
    'ar',
    'en',
    'fr',
    'zh-cn',
    'hi',
    'de',
    'it',
    'es',
    'ja'
  ];

  final List<String> _defaultTexts = [
    'Arabic Egypt',
    'English United Kingdom',
    'French',
    'Chinese',
    'Hindi',
    'German',
    'Italian',
    'Spanish',
    'Japanese',
  ];

  final List<String> _flags = [
    'egypt.jpg',
    'united-kingdom.png',
    'france.png',
    'china.png',
    'india.png',
    'germany.png',
    'italy.png',
    'spain.png',
    'japan.png',
  ];

  List<String> get translatedTexts => _translatedTexts;
  List<bool> get showTranslation => _showTranslation;
  bool get loading => _loading;
  List<String> get flags => _flags;
  List<String> get defaultTexts => _defaultTexts;
  List<String> get languagesCode => _languagesCode;
  String get inputText => _inputText;

  set inputText(String text) {
    _inputText = text;
    notifyListeners();
  }

  Future<void> translate() async {
    _loading = true;
    notifyListeners();

    List<String> translatedTexts = [];
    for (String code in _languagesCode) {
      //تنفيذ الترجمة لكل لغة في القائمة.
      Translation translation =
          await _translator.translate(_inputText, to: code);
      translatedTexts.add(translation.text);
    }
//تخززين قيمة   تنفيذ الترجمة لكل لغة في القائمة.
    _translatedTexts = translatedTexts;
    //  تذكر      List<String> _translatedTexts = List.filled(9, '');
    _showTranslation = List.filled(9, false); //لعرض الترجمة
    _loading = false;
    notifyListeners();
  }

  Future<void> speak(String languageCode, String text) async {
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setPitch(1);
    await _flutterTts.setVolume(1);
    await _flutterTts.setSpeechRate(1);
    await _flutterTts.speak(text);
  }

  void toggleTranslation(int index) {
    _showTranslation[index] = !_showTranslation[index];
    notifyListeners();
  }

  void reset() {
    _inputText = '';
    textController.clear();
    _translatedTexts = List.filled(9, '');
    _showTranslation = List.filled(9, false);
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
