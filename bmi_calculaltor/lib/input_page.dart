import 'package:bmi_calculaltor/output_page.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'icon_Content.dart';
import 'calculator_brain.dart';
import 'round_button.dart';
import 'calculate_button.dart';


const inactiveCardColour = Color(0xFF25284A);
const activeCardColour = Color(0xFF151A3C);
const bottomContainerColour = Color(0xFFFF0067);

int height = 200;
int weight = 50;
int age = 30;

const numberlayout =
    TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w900);

Color maleCardColour = inactiveCardColour;
Color femaleCardColor = inactiveCardColour;

void updateColor() {
  if (maleCardColour == inactiveCardColour) {
    maleCardColour = activeCardColour;
    femaleCardColor = inactiveCardColour;
  } else {
    maleCardColour = inactiveCardColour;
    femaleCardColor = activeCardColour;
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BMI CALCULATOR',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: card(
                      onPress: () {
                        setState(() {
                          updateColor();
                        });
                      },
                      colour: maleCardColour,
                      cardChild: iconContent(
                        name: 'MALE',
                        iconeShape: Icons.male,
                      ),
                    ),
                  ),
                  Expanded(
                    child: card(
                      onPress: () {
                        setState(() {
                          updateColor();
                        });
                      },
                      colour: femaleCardColor,
                      cardChild: iconContent(
                        name: 'FEMALE',
                        iconeShape: Icons.female,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: card(
                colour: activeCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('$height', style: numberlayout),
                        Text(' cm',
                            style: TextStyle(fontSize: 25, color: Colors.grey))
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFFF0067),
                        overlayColor: Color(0x29FF0067),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 16),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30),
                      ),
                      child: Slider(
                          value: height.toDouble(),
                          min: 50,
                          max: 260,
                          inactiveColor: Colors.grey,
                          onChanged: (newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          }),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: card(
                      colour: activeCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: TextStyle(fontSize: 25, color: Colors.grey),
                          ),
                          Text(
                            '$weight',
                            style: numberlayout,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RoundButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                    if (weight==651)
                                      weight=1;
                                  });
                                },
                              ),
                              RoundButton(icon: Icons.remove,  onPressed: () {
                                setState(() {
                                  weight--;
                                  if(weight==0)
                                    weight=650;
                                });
                              },),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: card(
                      colour: activeCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: TextStyle(fontSize: 25, color: Colors.grey),
                          ),
                          Text(
                            '$age',
                            style: numberlayout,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RoundButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                    if(age==126)
                                      age=1;
                                  });
                                },
                              ),
                              RoundButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                    if(age==0)
                                      age=125;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            calculateButton(name: 'CALCULATE',onPress: () {
              CalulatorBrain obj = CalulatorBrain(height: height,weight: weight);

              Navigator.push(context, MaterialPageRoute(builder: (context){
                String getBMI=obj.getBMI();
                String getResult=obj.getResult();
                String getAdvice=obj.getAdvice();
                return outputPage(getBMI: getBMI,getAdvice: getAdvice,getResult: getResult,);
              }),); },)
          ],
        ));
  }
}
