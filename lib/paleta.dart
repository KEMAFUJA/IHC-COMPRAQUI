import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  Color _primaryColor = const Color(0xFF00427D);
  Color _secundaryColor = const Color(0xFF2563EB);
  Color _accentColor = const Color(0xFFFBBF24);

  //Color _primaryColor = const Color.fromARGB(255, 211, 18, 18);
  Color get primaryColor => _primaryColor;
  Color get secundaryColor => _secundaryColor;
  Color get accentColor => _accentColor;

  Color get backgroundColor => const Color(0xFFF5F5F5);
  Color get textColor => Colors.black87;
  Color get textColorSecon => Colors.grey;
  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  void setSecundaryColor(Color color) {
    _secundaryColor = color;
    notifyListeners();
  }

  void setAccentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }
}
