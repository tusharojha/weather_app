import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/EnterCityPage.dart';
import 'package:weatherapp/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences _preferences;
  String _city;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async{
    _preferences = await SharedPreferences.getInstance();
    _city = _preferences.getString('city');

    // Navigate between screens
    if(_city == null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterCityPage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Weather App',)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Weather App"),
        ),
      ),
    );
  }
}
