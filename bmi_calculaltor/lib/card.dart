import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class card extends   StatelessWidget {
  final Color colour;
  final Widget? cardChild;
 final VoidCallback? onPress;
  card({required this.colour, this.cardChild ,this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colour,
        ),
      ),
    );
  }
}