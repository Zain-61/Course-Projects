import 'package:flutter/material.dart';
import 'package:coin_ticker/coin_data.dart';
import 'package:coin_ticker/fetch_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedCurrency = 'PKR';
  String Brate = '?';
  String Erate = '?';
  String Lrate = '?';
  fetchData fetchDataInstance = fetchData();
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCurrency = 'PKR';
      Brate = '?';
    });
    fetchDataInstance.getData('BTC', 'PKR').then((newRate) {
      setState(() {
        Brate = newRate;
      });
    });
    setState(() {
      selectedCurrency = 'PKR';
      Erate = '?';
    });
    fetchDataInstance.getData('ETH', 'PKR').then((newRate) {
      setState(() {
        Erate = newRate;
      });
    });
    setState(() {
      selectedCurrency = 'PKR';
      Lrate = '?';
    });
    fetchDataInstance.getData('LTC', 'PKR').then((newRate) {
      setState(() {
        Lrate = newRate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
        // backgroundColor: Colors.yellow,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $Brate $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $Erate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $Lrate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Center(
                child: DropdownButton<String>(
                    menuMaxHeight:300,
                  value: selectedCurrency,
                    items: [
                      for (String A in currenciesList)
                        DropdownMenuItem(
                          child: Text('$A'),
                          value: '$A',
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCurrency = value!;
                        Brate = '?';
                      });
                      fetchDataInstance.getData('BTC', '$value').then((newRate) {
                        setState(() {
                          Brate = newRate;
                        });
                      });
                      setState(() {
                        selectedCurrency = value!;
                        Erate = '?';
                      });
                      fetchDataInstance.getData('ETH', '$value').then((newRate) {
                        setState(() {
                          Erate = newRate;
                        });
                      });
                      setState(() {
                        selectedCurrency = value!;
                        Lrate = '?';
                      });
                      fetchDataInstance.getData('LTC', '$value').then((newRate) {
                        setState(() {
                          Lrate = newRate;
                        });
                      });
                    },
                  isDense: true,
                  iconSize: 30,
                    ),
              )),
        ],
      ),
    );
  }
}
