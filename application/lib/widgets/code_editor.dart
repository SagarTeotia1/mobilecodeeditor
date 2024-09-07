import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeEditor extends StatelessWidget {
  final String code;
  final Function(String) onCodeChanged;
  final String language;

  CodeEditor({
    required this.code,
    required this.onCodeChanged,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: HighlightView(
        code,
        language: language.toLowerCase(),
        theme: githubTheme,
        padding: EdgeInsets.all(12),
        textStyle: TextStyle(fontSize: 14),
      ),
    );
  }
}