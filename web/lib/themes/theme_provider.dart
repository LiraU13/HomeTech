import 'package:flutter/material.dart';
import 'package:hometech/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (_themeData == lightMode) {
      _themeData = darkMode;
      await prefs.setBool('isDarkMode', true);
    } else {
      _themeData = lightMode;
      await prefs.setBool('isDarkMode', false);
    }
    notifyListeners();
  }
}

// CODIGO 1 -- CAMBIA EL MODO DESDE LA CONFIGURACIONES DEL DISPOSITIVO
// import 'package:flutter/material.dart';
// import 'package:hometech/themes/theme.dart';
// class ThemeProvider with ChangeNotifier {
//   ThemeData _themeData = lightMode;
//   ThemeData get themeData => _themeData;
//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }
//   void toggleTheme() {
//     if (_themeData == lightMode) {
//       themeData = darkMode;
//     } else {
//       themeData = lightMode;
//     }
//   }
// }
