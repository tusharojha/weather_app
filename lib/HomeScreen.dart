import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './WeatherResponse.dart';

const API_KEY = '<YOUR_OPEN_WEATHER_MAP_API_KEY>';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherResponse weatherResponse;
  SharedPreferences _preferences;


  @override
  void initState(){
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async{
    _preferences = await SharedPreferences.getInstance();
    getWeatherData(_preferences.getString('city'));
  }

  getWeatherData(String city) async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY');

    if (response.statusCode == 200) {
      setState(() {
        weatherResponse = WeatherResponse.fromJSON(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            weatherResponse != null
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          weatherResponse.main,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(weatherResponse.description),
                        Text(weatherResponse.temperature.toString()),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
