import 'package:flutter/material.dart';
import 'package:quizlerr/question.dart';
import 'dart:math';
import 'dart:isolate';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Quiz Your Brain!',style: TextStyle(fontSize: 30),),
            ),
            backgroundColor: Colors.teal,
          ),
          body: const quizPage(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}


class quizPage extends StatefulWidget {
  const quizPage({super.key});

  @override
  State<quizPage> createState() => _quizPageState();
}


List<Widget> ScoreKeeper =[Icon(Icons.arrow_drop_down_rounded,size: 30,)];

int a=0;


class _quizPageState extends State<quizPage> {
  @override
  Widget build(BuildContext context) {
    void restartApp() {
      setState(() {
        a = 0;
        ScoreKeeper.clear();
        ScoreKeeper.add(Icon(Icons.arrow_drop_down_rounded, size: 30,));
      });
    }

    int questionNumber = Random().nextInt(195);
    void checkAnswer(bool value) {
      if (QuestionBank[questionNumber].answer == value) {
        ScoreKeeper.add(
          const Icon(Icons.check, color: Colors.green, size: 30),
        );
      }
      //if (QuestionBank[questionNumber].answer == value) {
      else{ScoreKeeper.add(
        const Icon(Icons.close, color: Colors.red, size: 30),
      );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ if(a<=9)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              color: Colors.white,
              child: Center(
                child:
                Text(
                  QuestionBank[questionNumber].question,
                  style: TextStyle(fontSize: 40,color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        if(a>9)
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 30, end: 30, top: 0, bottom: 0),
            child: Container(
              height: 620,
              width: 2,
              color: Colors.white,
              child: Center(
                child:
                Text(
                  'Quiz Complete\nYou Play Well!\nYou can Try it Again with New Facts',
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                ),
              ),
              
            ),
          ),
        if(a>9)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 13, 00),
                child: TextButton(
                  onPressed: () {
                    restartApp();

                  },
                  child: Center(
                    child: Text(
                      'Try Again!',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                 
                ),
              ),
            ],
          ),
        Row(
          children: [
            if (a<=9)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 13, 00),
                child: TextButton(
                  onPressed: () {
                    setState(() {

                        a++;
                        checkAnswer(true);
                    });
                  },
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
            ),
            if(a<=9)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 00, 20, 0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if(a<=9){
                        a++;
                        checkAnswer(false);}
                    });
                  },
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ),
          ],
        ),

        Wrap(
          children: ScoreKeeper,
        ),
      ],
    );
  }
}
