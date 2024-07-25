import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/translation_view_model.dart';
import '../widgets/language_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.blueGrey.shade300,
          // backgroundColor: Colors.amber,
          appBar: AppBar(
            title: Text(
              'Translate & Speech',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 102, 179, 241),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: viewModel.reset, // Call reset method
              ),
            ],
          ),
          body: Column(
            children: [
              TextField(
                autofocus: true,
                controller:
                    viewModel.textController, // Use controller from viewModel
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  hintText: 'Enter Text...',
                  hintStyle: TextStyle(color: Colors.indigo),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromARGB(255, 219, 236, 245),
                  suffixIcon: viewModel.loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.translate,
                            color: Colors.green,
                            size: 40,
                          ),
                          onPressed: () {
                            if (viewModel.inputText.isNotEmpty)
                              viewModel.translate();
                          },
                        ),
                ),
                onChanged: (input) {
                  viewModel.inputText = input;
                },
              ),
              LanguageListView(), // Use the new LanguageListView widget
            ],
          ),
        );
      },
    );
  }
}
