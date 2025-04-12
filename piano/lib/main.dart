//import 'dart:ui';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(piano());
}

playSound(No){
  final player = AudioPlayer();
  player.play(
      AssetSource('note$No.wav'),);
}



Expanded buildKey(No, color){
  return Expanded(
     child:TextButton(
      onPressed: () {
        playSound(No);
      },

      child: Text(''),
      style: TextButton.styleFrom(
        backgroundColor:
        color, // Sets button background color
      ),),
  );
}
class piano extends StatelessWidget {
  piano({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black38,
        body: SafeArea(
          child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(1,Colors.teal),
              buildKey(2,Colors.amber),
              buildKey(3,Colors.blue),
              buildKey(4,Colors.red),
              buildKey(5,Colors.tealAccent),
              buildKey(6,Colors.amberAccent),
              buildKey(7,Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
