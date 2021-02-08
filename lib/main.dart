/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:oni/pages/pages.Home.dart';
import 'package:oni/pages/pages.signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oni/pages/pages.personalize.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:workmanager/workmanager.dart';
import 'package:oni/BackgroundTasks/PeriodicWeatherCheck.dart';

const PeriodicWeatherCheckTaskName = "PeriodicWeatherCheck";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    switch (task) {
      case PeriodicWeatherCheckTaskName:
        // PeriodicWeatherCheck().checkWeather(true);
        break;
    }
    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  Workmanager.cancelAll();
  Workmanager.registerPeriodicTask("2", PeriodicWeatherCheckTaskName,
      initialDelay: Duration(seconds: 30));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final String title = 'Oni';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PermissionStatus _permissionStatus;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    _askActivityPermission();
  }

// For permission from user
  void _askActivityPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _permissionStatus = await Permission.activityRecognition.status;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // customise status bar color

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      home: SignUpPage(),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => OniHome(),
      },
    );
  }
}
