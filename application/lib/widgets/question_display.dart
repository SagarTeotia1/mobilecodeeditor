import 'package:flutter/material.dart';

class QuestionDisplay extends StatelessWidget {
  final String question;

  QuestionDisplay({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        question,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}