
import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.red,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    shadowColor: Colors.grey,
  );
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.grey[900],
    cardColor: Colors.grey[900],
    scaffoldBackgroundColor: Color(0xFF17191D),
    shadowColor: Colors.grey,
  );
}
