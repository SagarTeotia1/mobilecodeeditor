import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://mobilecodeeditor.onrender.com/';

  Future<String> generateQuestion(String language) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate-question'),
      body: {'language': language},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['question'];
    } else {
      throw Exception('Failed to generate question');
    }
  }

  Future<Map<String, dynamic>> runCode(String language, String code, String question) async {
    final response = await http.post(
      Uri.parse('$baseUrl/run-code'),
      body: {
        'language': language,
        'code': code,
        'question': question,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to run code');
    }
  }

  Future<void> submitQuestion(String language, String question) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit-question'),
      body: {
        'language': language,
        'question': question,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit question');
    }
  }
}