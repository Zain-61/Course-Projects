import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/city_screen.dart';


class LocationScreen extends StatefulWidget {
  var temp;
  var id;
  var cityName;
  LocationScreen({required this.temp,required this.id, required this.cityName});
  @override
  _LocationScreenState createState() => _LocationScreenState();

}

class _LocationScreenState extends State<LocationScreen> {
  double? _temp;
  String? _cityName;
  double? _id;
  _LocationScreenState({double? temp,double? id, String? cityName}) {
    _temp = temp;
    _id=id;
    _cityName = cityName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {LoadingScreen.getLocation(context);},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder:  (context) => CityScreen()),
                    );},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${widget.temp.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${WeatherModel().getWeatherIcon(widget.id)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's ${WeatherModel().getMessage(widget.temp.round())}time in ${widget.cityName}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              // FilledButton.tonal(
              //         style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              //         onPressed: () {
              //           print(widget.temp);
              //           print(widget.id);
              // }, child: null,)
            ],
          ),
        ),
      ),
    );
  }
}
