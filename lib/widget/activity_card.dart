//Weather update card calling from pages.Home.dart
import 'package:flutter/material.dart';
import 'package:oni/ui/base_widget.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class ActivityCard extends StatefulWidget {
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '', _steps = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

//get count step
  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

// get activity status change
  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

//if activity status get any error or not available
  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

//if  step count  get any error or not available
  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = '0';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  var personalStepChoice = 6000;

  @override
  Widget build(BuildContext context) {
    int steps = int.parse(_steps);
    var percentCalc = (steps / personalStepChoice);
    double caloriBurnt = (.032 * steps);

    print(caloriBurnt);
    // BaseWidget help to get screen size and resize every component of it according to device sreen size
    return BaseWidget(
        builder: (context, sizingInfo) => Container(
            child: InkWell(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.all(10),
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  Icons.directions_walk,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Steps',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CircularPercentIndicator(
                                        radius: 120.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: percentCalc,
                                        center: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "$_steps",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("/$personalStepChoice"),
                                            Text(
                                              'Steps taken',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      Container(
                                        child: Column(children: [
                                          Text(
                                            'Excersize',
                                          ),
                                          Icon(
                                            _status == 'walking'
                                                ? Icons.directions_walk
                                                : _status == 'stopped'
                                                    ? Icons.accessibility_new
                                                    : Icons.self_improvement,
                                            color: Colors.green,
                                            size: 25,
                                          ),
                                        ]),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 25.0, 0, 0),
                                          child: Column(children: [
                                            Text('Total Calory Burnt'),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.local_fire_department,
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                                Text(
                                                    "${caloriBurnt.toStringAsFixed(2)} cal.")
                                              ],
                                            )
                                          ])),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ))))));
  }
}
