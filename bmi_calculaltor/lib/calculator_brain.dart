import 'dart:math';

class CalulatorBrain {
  final height;
  final weight;
  CalulatorBrain({this.height, this.weight});

  double bmi = 12;
  String getBMI() {
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (bmi >= 25) {
      return 'OVER WEIGHT';
    } else if (bmi > 18.5)
      return 'NORMAL';
    else
      return 'UNDER WEIGHT';
  }

  String getAdvice(){
    if (bmi >= 25) {
      return 'You have higher than normal body weight. Try to exercise more.';
    } else if (bmi > 18.5)
      return 'You have a normal body weight. Good job!';
    else
      return 'You have lower than normal body weight. You can eat a bit more.';

  }

}

