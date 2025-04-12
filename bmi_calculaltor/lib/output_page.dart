import 'package:flutter/material.dart';
import 'input_page.dart';
import 'card.dart';
import 'calculate_button.dart';

class outputPage extends StatelessWidget {
  outputPage(
      {required this.getBMI, required this.getAdvice, required this.getResult});
  final getBMI;
  final getResult;
  final getAdvice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 50),
            child: Text(
              'Your Result',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5),
            ),
          ),
          Expanded(
            child: card(
              colour: activeCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      getResult,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    child: Text(getBMI,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.w900)),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Normal BMI range:',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '18.5 to 24.9 kg/m²',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          getAdvice,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          calculateButton(name: 'Re-CALCULATE', onPress:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return InputPage();
              }),
            );
          }, )
        ],
      ),
    );
  }
}
