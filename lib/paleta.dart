import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  Color _primaryColor = const Color(0xFF6C63FF);
  //Color _primaryColor = const Color.fromARGB(255, 211, 18, 18);
  Color get primaryColor => _primaryColor;
  Color get backgroundColor => const Color(0xFFF5F5F5);
  Color get textColor => Colors.black87;
  Color get textColorSecon => Colors.grey;
  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
