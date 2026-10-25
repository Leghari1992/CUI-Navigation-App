import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light(); // Initialized with a default value

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData getTheme() => _themeData;

  bool get isDarkMode => _themeData.brightness == Brightness.dark; // ✅ Add this line

  void setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
    await _saveTheme(themeData);
  }

  Future<void> _saveTheme(ThemeData themeData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeData.brightness == Brightness.dark);
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
