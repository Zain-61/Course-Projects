import 'package:flutter/material.dart';
import 'input_page.dart';

class calculateButton extends StatelessWidget {
  final name;
  final onPress;
  calculateButton({required this.name,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPress,
      child: Container(
        color: bottomContainerColour,
        margin: EdgeInsets.only(top: 20),
        height: 80,
        width: double.infinity,
        child: Center(
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white, fontSize: 30, letterSpacing: 1,fontWeight: FontWeight.w800),
            )),
      ),
    );
  }
}
