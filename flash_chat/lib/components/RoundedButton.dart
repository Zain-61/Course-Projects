import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  //const button({super.key});

  final String buttonText;
  final VoidCallback onPressedCallback;
  final Color buttonColor;

  const RoundedButton({super.key, required this.buttonText, required this.onPressedCallback,required this.buttonColor});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressedCallback();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
