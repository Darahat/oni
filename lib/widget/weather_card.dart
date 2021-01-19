//rain possiblity
//temp
//air speed

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oni/ui/base_widget.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

class FirstCard extends StatefulWidget {
  FirstCard({Key key, this.data}) : super(key: key);
  final List<Weather> data;
  @override
  _FirstCardState createState() => _FirstCardState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return Text(
      'Morning',
      style: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
  if (hour < 17) {
    return Text(
      'Afternoon',
      style: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
  return Text(
    'Evening',
    style: GoogleFonts.lato(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 0.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.network(
                                  "http://openweathermap.org/img/wn/${widget.data[0].weatherIcon}@2x.png",
                                  color: Colors.white,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${widget.data[0].weatherDescription.capitalize()}",
                                  style: GoogleFonts.lato(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[greeting()],
                            ),
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "${widget.data[0].temperature.celsius.round()}\u00B0",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 75,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Feels Like ${widget.data[0].tempFeelsLike.celsius.round()} \u00B0",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
//rain possiblity
//temp
//air speed
//  Position _currentPosition;
//   String key = '856822fd8e22db5e1ba48c0e7d69844a';
//   WeatherFactory ws;
//   List<Weather> _data = [];
//   double lat = 0.0;
//   double lon = 0.0;
//   @override
//   void initState() {
//     super.initState();
//     // _determinePosition();
//     ws = new WeatherFactory(key);
//     _getCurrentLocation();
//   }

//   _getCurrentLocation() {
//     // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//         if (_currentPosition.latitude != 0.0) {
//           return queryWeather(24.747149, 90.420273);
//         } else {}
//       });
//     }).catchError((e) {
//       print('aaaaaaaaaa$e');
//     });
//   }

//   void queryWeather(lati, long) async {
//     print(
//         "this is my position hurray .....................................................$lati $long");
// // fetchApI().then((){
//     /// Removes keyboard
//     FocusScope.of(context).requestFocus(FocusNode());

//     setState(() {});
//     try {
//       await ws
//           .currentWeatherByLocation(
//               _currentPosition.latitude, _currentPosition.longitude)
//           .then((weather) {
//         setState(() {
//           _data = [weather];
//         });
//       });
//     } catch (e) {
//       print('aaaaaaaaaa$e');
//     }

//     // weather.cloudiness;
//     // weather.humidity;
//     // weather.rainLast3Hours;
//     // weather.sunrise;
//     // weather.tempMax;
//     // weather.tempMin;
//     // weather.temperature;
//   }
