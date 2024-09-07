import 'package:flutter/foundation.dart';
import '../models/language.dart';

class AppState extends ChangeNotifier {
  List<Language> _languages = [
    Language(name: 'Python', icon: '🐍'),
    Language(name: 'JavaScript', icon: '🌐'),
    Language(name: 'Java', icon: '☕'),
    Language(name: 'C++', icon: '🔧'),
    Language(name: 'C#', icon: '🎯'),
    Language(name: 'Ruby', icon: '💎'),
    Language(name: 'Swift', icon: '🍎'),
    Language(name: 'Go', icon: '🐹'),
    Language(name: 'Kotlin', icon: '🤖'),
    Language(name: 'TypeScript', icon: '📘'),
  ];

  List<Language> get languages => _languages;
}