import 'package:flutter/material.dart';
import 'package:oni/components/draggableScrollableNav.dart';
import 'package:oni/widget/activity_card.dart';
import 'package:oni/widget/personalize.dart';
import 'package:oni/widget/weather_card.dart';
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

  // void queryForecast() async {
  //   /// Removes keyboard
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   setState(() {
  //     _state = AppState.DOWNLOADING;
  //   });

  //   List<Weather> forecasts = await ws.fiveDayForecastByLocation(
  //       _currentPosition.latitude, _currentPosition.longitude);

  //   setState(() {
  //     _data = forecasts;
  //     _state = AppState.FINISHED_DOWNLOADING;
  //   });
  // }

  _getCurrentLocation() {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

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

  void queryWeather(lati, long) async {
    print(
        "this is my position hurray .....................................................$lati $long");
// fetchApI().then((){
    /// Removes keyboard
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Oni Weather'),
        ),
        // drawer: Drawer(
        //   // Add a ListView to the drawer. This ensures the user can scroll
        //   // through the options in the drawer if there isn't enough vertical
        //   // space to fit everything.
        //   child: DraggableScrollableNav(),
        // ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, position) {
                  return Column(
                    children: [
                      FirstCard(data: _data),
                    ],
                  );
                }),
            DraggableScrollableNav()
          ],
        )

        // Container(
        // color: const Color(0xff282B28),
        //   child: Column(
        // children: <Widget>[
        // if (_currentPosition != null)
        // Text(
        //     "LAT: ${_currentPosition.latitude}, LNGgy: ${_currentPosition.longitude}"),
        // _coordinateInputs(),
        // _buttons(),
        // ElevatedButton(
        //   onPressed: () {
        //     final provider =
        //         Provider.of<GoogleSignInProvider>(context, listen: false);
        //     provider.logout();
        //   },
        //   child: Text('Logout'),
        // ),
        // Text(
        //   'Output:',
        //   style: TextStyle(fontSize: 20),
        // ),
        // Divider(
        //   height: 20.0,
        //   thickness: 2.0,
        // ),
        // Expanded(child: _resultView())
        // ],
        // )
        // )
        );
  }
  // Widget contentFinishedDownload() {
  //   return Center(
  //     child: ListView.separated(
  //       itemCount: _data.length,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text(_data[index].toString()),
  //         );
  //       },
  //       separatorBuilder: (context, index) {
  //         return Divider();
  //       },
  //     ),
  //   );
  // }

  // Widget contentDownloading() {
  //   return Container(
  //       margin: EdgeInsets.all(25),
  //       child: Column(children: [
  //         Text(
  //           'Fetching Weather...',
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         Container(
  //             margin: EdgeInsets.only(top: 50),
  //             child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
  //       ]));
  // }

  // Widget contentNotDownloaded() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           'Press the button to download the Weather forecast',
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
  //     ? contentFinishedDownload()
  //     : _state == AppState.DOWNLOADING
  //         ? contentDownloading()
  //         : contentNotDownloaded();

  // void _saveLat(String input) {
  //   lat = double.tryParse(input);
  //   print(lat);
  // }

  // void _saveLon(String input) {
  //   lon = double.tryParse(input);
  //   print(lon);
  // }

  // Widget _coordinateInputs() {
  //   setState(() {});
  //   return Row(
  //     children: <Widget>[
  //       Expanded(
  //         child: Container(
  //             margin: EdgeInsets.all(5),
  //             child: TextField(
  //                 decoration: InputDecoration(
  //                     border: OutlineInputBorder(), hintText: 'Enter latitude'),
  //                 keyboardType: TextInputType.number,
  //                 onChanged: _saveLat,
  //                 onSubmitted: _saveLat)),
  //       ),
  //       Expanded(
  //           child: Container(
  //               margin: EdgeInsets.all(5),
  //               child: TextField(
  //                   decoration: InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       hintText: 'Enter longitude'),
  //                   keyboardType: TextInputType.number,
  //                   onChanged: _saveLon,
  //                   onSubmitted: _saveLon)))
  //     ],
  //   );
  // }

  // Widget _buttons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.all(5),
  //         child: FlatButton(
  //           child: Text(
  //             'Fetch weather',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           onPressed: queryWeather,
  //           color: Colors.blue,
  //         ),
  //       ),
  //       Container(
  //           margin: EdgeInsets.all(5),
  //           child: FlatButton(
  //             child: Text(
  //               'Fetch forecast',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             onPressed: queryForecast,
  //             color: Colors.blue,
  //           ))
  //     ],
  //   );
  // }

}
