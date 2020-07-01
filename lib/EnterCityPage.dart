import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './HomeScreen.dart';

class EnterCityPage extends StatefulWidget {
  @override
  _EnterCityPageState createState() => _EnterCityPageState();
}

class _EnterCityPageState extends State<EnterCityPage> {
  TextEditingController _controller = TextEditingController();

  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                if (_controller.text != null && _controller.text != '') {
                  _preferences.setString('city', _controller.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Weather App',)));
                }
              },
              child: Text("Get Weather Data"),
            )
          ],
        ),
      ),
    );
  }
}
