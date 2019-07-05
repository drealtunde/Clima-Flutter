import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double lat;
double long;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getWeatherViaLocation();
  }

  void getWeatherViaLocation() async {
    Location location = Location();
    await location.getLocation();
    lat = location.latitude;
    long = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }
}
