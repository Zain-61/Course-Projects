import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({required this.icon, this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: IconTheme(
        data: IconThemeData(
          color: Colors.white,
          size: 50,
          // weight: FontWeight.w600, // Set icon weight to FontWeight.w600
        ),
        child: Icon(icon),
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF25284A),
      constraints: BoxConstraints.tightFor(
        width: 60.0,
        height: 60.0,
      ),
    );
  }
}
