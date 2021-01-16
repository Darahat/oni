/*
 * Copyright 2018 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:oni/pages/pages.Home.dart';
import 'package:oni/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oni/widget/personalize.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final String title = 'Oni';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _messaging.getToken().then((token) {
    //   print(token);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      // home: HomePage(),
      home: SignUpPage(),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => OniHome(),
        '/personalize': (context) => Personalize()
      },
    );
  }
}
