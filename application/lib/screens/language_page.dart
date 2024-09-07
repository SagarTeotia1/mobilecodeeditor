import 'package:flutter/material.dart';
import '../models/language.dart';
import '../services/api_service.dart';
import '../widgets/code_editor.dart';
import '../widgets/question_display.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LanguagePage extends StatefulWidget {
  final Language language;

  LanguagePage({required this.language});

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final ApiService _apiService = ApiService();
  String _question = '';
  String _code = '';
  String _output = '';
  int _userRank = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  Future<void> _generateQuestion() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final question = await _apiService.generateQuestion(widget.language.name);
      setState(() {
        _question = question;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _question = 'Failed to generate question. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _runCode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await _apiService.runCode(widget.language.name, _code, _question);
      setState(() {
        _output = result['output'];
        _userRank = result['rank'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _output = 'Error running code. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language.name),
      ),
      body: _isLoading
          ? Center(child: SpinKitCubeGrid(color: Colors.blue))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionDisplay(question: _question),
                  SizedBox(height: 20),
                  CodeEditor(
                    code: _code,
                    onCodeChanged: (newCode) => setState(() => _code = newCode),
                    language: widget.language.name,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _runCode,
                    child: Text('Run Code'),
                  ),
                  SizedBox(height: 20),
                  Text('Output:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_output),
                  SizedBox(height: 20),
                  Text('Your Rank: $_userRank', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
    );
  }
}