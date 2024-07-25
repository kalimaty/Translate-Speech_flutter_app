import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'view_models/translation_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TranslationViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
















// old code  before refactoring
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:translator/translator.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   FlutterTts flutterTts = FlutterTts();
//   GoogleTranslator translator = GoogleTranslator();
//   String inputText = '';
//   bool _loading = false;

//   // Create a TextEditingController for managing input text
//   TextEditingController _textEditingController = TextEditingController();

//   List<String> _translatedTexts =
//       List.filled(9, ''); // Initialize with empty strings
//   List<bool> _showTranslation =
//       List.filled(9, false); // Track translation visibility for each language

//   List<String> _languagesCode = [
//     'ar',
//     'en',
//     'fr',
//     'zh-cn',
//     'hi',
//     'de',
//     'it',
//     'es',
//     'ja'
//   ];

//   List<String> _defaultTexts = [
//     'Arabic Egypt',
//     'English United Kingdom',
//     'French',
//     'Chinese',
//     'Hindi',
//     'German',
//     'Italian',
//     'Spanish',
//     'Japanese',
//   ];

//   List<String> _flags = [
//     'egypt.jpg',
//     'united-kingdom.png',
//     'france.png',
//     'china.png',
//     'india.png',
//     'germany.png',
//     'italy.png',
//     'spain.png',
//     'japan.png',
//   ];

//   Future translate() async {
//     List<String> translatedTexts = [];
//     setState(() {
//       _loading = true;
//     });
//     // Perform translation for each language
//     for (String code in _languagesCode) {
//       Translation translation = await translator.translate(inputText, to: code);
//       String translatedText = translation.text;
//       translatedTexts.add(translatedText);
//     }
//     // Update UI with the translated texts
//     setState(() {
//       _translatedTexts = translatedTexts;
//       _showTranslation = List.filled(9, false); // Reset visibility on translate
//       _loading = false;
//     });
//   }

//   Future speak(String languageCode, String text) async {
//     await flutterTts.setLanguage(languageCode);
//     await flutterTts.setPitch(1);
//     await flutterTts.setVolume(1);
//     await flutterTts.setSpeechRate(1);
//     await flutterTts.speak(text);
//     await flutterTts.getLanguages.then((value) => print(value));
//   }

//   void _toggleTranslation(int index) {
//     setState(() {
//       _showTranslation[index] = !_showTranslation[index];
//     });
//   }

//   void _reset() {
//     // Reset input text and translations
//     setState(() {
//       inputText = ''; // Reset inputText variable
//       _textEditingController.clear(); // Clear the text field
//       _translatedTexts = List.filled(9, '');
//       _showTranslation = List.filled(9, false);
//     });
//   }

//   @override
//   void dispose() {
//     _textEditingController
//         .dispose(); // Dispose of the controller when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       appBar: AppBar(
//         title: Text('Translate & Speech'),
//         centerTitle: true,
//         backgroundColor: Color(0xffFFC100),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _reset, // Call reset method
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller:
//                 _textEditingController, // Attach the controller to the TextField
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.all(25),
//               hintText: 'Enter Text...',
//               hintStyle: TextStyle(color: Colors.white),
//               border: InputBorder.none,
//               filled: true,
//               fillColor: Color(0xff263238),
//               suffixIcon: _loading
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircularProgressIndicator(
//                         backgroundColor: Colors.white,
//                       ),
//                     )
//                   : IconButton(
//                       icon: Icon(
//                         Icons.translate,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         if (inputText.isNotEmpty) translate();
//                       },
//                     ),
//             ),
//             onChanged: (input) {
//               inputText = input;
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               physics: BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics(),
//               ),
//               itemCount: _languagesCode.length,
//               itemBuilder: (context, index) {
//                 return FlagButton(
//                   text: _showTranslation[index]
//                       ? _translatedTexts[index]
//                       : _defaultTexts[index],
//                   flag: _flags[index], // Use flag image path from _flags list
//                   onTap: () {
//                     if (_translatedTexts.isNotEmpty) {
//                       speak(_languagesCode[index], _translatedTexts[index]);
//                       _toggleTranslation(index);
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FlagButton extends StatelessWidget {
//   final String text;
//   final String flag;
//   final VoidCallback onTap;

//   FlagButton({
//     required this.text,
//     required this.flag,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 'assets/flags/$flag', // Path to the flag image
//                 width: 50, // Width of the flag image
//                 height: 30, // Height of the flag image
//                 fit: BoxFit.cover, // Adjust the fit of the image
//               ),
//               SizedBox(width: 16.0), // Space between image and text
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
