import 'package:flutter/material.dart';
import 'input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF0A1033),
            foregroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.black.withOpacity(1), // Add this line
          ),
          scaffoldBackgroundColor: Color(0xFF0A1033),
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white))
      ),
      home: InputPage(),
    );
  }
}

