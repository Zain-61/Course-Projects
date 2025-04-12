import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:coin_ticker/price_screen.dart';
import 'package:coin_ticker/coin_data.dart';





class fetchData{
   Future<String> getData(String coin,String currency )async{
    var url =Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=4BC402EA-5A05-469A-BE94-87841DE224C4');
    http.Response response= await http.get(url);
      String data=response.body;
     double RAte=jsonDecode(data)['rate'];
    var formatter = NumberFormat.currency(symbol: '', decimalDigits: 0);
    String rate = formatter.format(RAte);
   // print(rate);
    return rate;
  }
}