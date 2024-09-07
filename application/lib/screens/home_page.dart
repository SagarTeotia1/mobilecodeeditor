import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'language_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Coding Practice App'),
      ),
      body: ListView.builder(
        itemCount: appState.languages.length,
        itemBuilder: (context, index) {
          final language = appState.languages[index];
          return ListTile(
            leading: Text(language.icon, style: TextStyle(fontSize: 24)),
            title: Text(language.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguagePage(language: language),
                ),
              );
            },
          );
        },
      ),
    );
  }
}