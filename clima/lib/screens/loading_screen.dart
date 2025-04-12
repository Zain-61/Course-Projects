import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Getdata{
  void getData(BuildContext context,lat,long)async{
    Location location=Location();
    var url =Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=b24ad2a987c31121a891d3f387d4a65d&units=metric');
    http.Response response= await http.get(url);
    String data=response.body;
    var temp,id,cityName;
    if(data==null)
      {
        temp=900;
        id=900;
        cityName='';
      }
    else
      {
    id=jsonDecode(data)['weather'][0]['id'];
    temp=jsonDecode(data)['main']['temp'];
    cityName=jsonDecode(data)['name'];}
    print (temp);
    print(id);
    print(cityName);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen(temp:temp,id:id,cityName:cityName)),
    );

  }
}
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

  static void getLocation(BuildContext context) {}
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation(context);
  }

  static void getLocation(BuildContext context) {
    Location location=Location();
    location.getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SpinKitDoubleBounce(color: Colors.white,size: 80,),),);
    // return Scaffold(
    //   body: Center(
    //     child: FilledButton.tonal(
    //       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    //       onPressed: () {
    //         // getData();
    //         // getLocation();
    //       },
    //       child: Text('Get Location'),
    //     ),
    //   ),
    // );
  }
}
