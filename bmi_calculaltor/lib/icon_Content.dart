import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class iconContent extends StatelessWidget {
  String? name;
  IconData? iconeShape;


  iconContent({this.name, this.iconeShape});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconeShape,
          size: 100,
          color: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          name!,
          style: TextStyle(fontSize: 25, color: Colors.grey),
        )
      ],
    );
  }
}
