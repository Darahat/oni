//Home page
import 'package:flutter/material.dart';
import 'package:oni/componentsOfPages/homewidgets/bodyStrucCard.dart';
import 'package:oni/componentsOfPages/homewidgets/draggableScrollableNav.dart';
import 'package:oni/componentsOfPages/homewidgets/activity_card.dart';
import 'package:oni/componentsOfPages/homewidgets/weather_card.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class OniHome extends StatefulWidget {
  OniHome({Key key}) : super(key: key);

  @override
  _OniHomeState createState() => _OniHomeState();
}

class _OniHomeState extends State<OniHome> {
  Position _currentPosition;
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double lat;
  double lon;

  @override
  void initState() {
    super.initState();
    // _determinePosition();
    ws = new WeatherFactory(key);
    _getCurrentLocation();
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });
// get 5 days forecast data
    List<Weather> forecasts = await ws.fiveDayForecastByLocation(
        _currentPosition.latitude, _currentPosition.longitude);

    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

// get location (lat & long)
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print("/////////////////////////////// $position");
      setState(() {
        _currentPosition = position;
        queryWeather(_currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print('aaaaaaaaaa$e');
    });
  }

// geting weather (parameter is latitude and longitude)
  void queryWeather(lati, long) async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });
    try {
      await ws
          .currentWeatherByLocation(
              _currentPosition.latitude, _currentPosition.longitude)
          .then((weather) {
        setState(() {
          _data = [weather];
          _state = AppState.FINISHED_DOWNLOADING;
        });
      });
    } catch (e) {
      print('aaaaaaaaaa$e');
    }

    // weather.cloudiness;
    // weather.humidity;
    // weather.rainLast3Hours;
    // weather.sunrise;
    // weather.tempMax;
    // weather.tempMin;
    // weather.temperature;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Oni'),
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, position) {
                  return Column(
                    children: [
                      FirstCard(data: _data),
                      ActivityCard(),
                      BodyStrucInfo()
                    ],
                  );
                }),
            DraggableScrollableNav()
          ],
        ));
  }
}
