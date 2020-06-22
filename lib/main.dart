import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './WeatherResponse.dart';

const API_KEY = '<Add Your API Key here>';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherResponse weatherResponse;
  TextEditingController _controller = TextEditingController();

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
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'Enter your city',
                    prefixIcon: Icon(Icons.location_city)),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await getWeatherData(_controller.text);
              },
              child: Text("Get Weather Data"),
            )
          ],
        ),
      ),
    );
  }
}
