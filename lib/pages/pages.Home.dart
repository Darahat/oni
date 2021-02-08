//Home page
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oni/componentsOfPages/homewidgets/bodyStrucCard.dart';
import 'package:oni/componentsOfPages/homewidgets/draggabaleNav.dart';
import 'package:oni/componentsOfPages/homewidgets/activity_card.dart';
import 'package:oni/componentsOfPages/homewidgets/weather_card.dart';
import 'package:oni/pages/pages.personalize.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:flutter_icons/flutter_icons.dart';

import 'package:oni/provider/google_sign_in.dart';

import 'package:provider/provider.dart';

class OniHome extends StatefulWidget {
  OniHome({
    Key key,
  }) : super(key: key);

  @override
  _OniHomeState createState() => _OniHomeState();
}

class _OniHomeState extends State<OniHome> {
  String title, content;
  //Subscribing for post details
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Users");

  bool todoSwitchValue = false;
  bool stepcountSwitchValue = false;
  bool fitnessSwitchValue = false;
  bool weatherSwitchValue = false;

  @override
  conditioningHomeCards() {
    // if (widget.weatherSwitchValue == true) {
    //   return
    // }

    if (stepcountSwitchValue == true) {
      return ActivityCard();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: Colors.green,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Ionicons.ios_person, title: 'Profile'),
          // TabItem(icon: Icons.mic, title: 'Speak'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.logout, title: 'Logout'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (int i) {
          if (i == 1) {
            return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Personalize(
                      todoSwitchValue: todoSwitchValue,
                      stepcountSwitchValue: stepcountSwitchValue,
                      fitnessSwitchValue: fitnessSwitchValue,
                      weatherSwitchValue: weatherSwitchValue),
                ));
          } else if (i == 4) {
//               final provider =StreamProvider(
//   create: (_) => FirebaseAuth.instance.onAuthStateChanged,
// ),
//                   StreamProvider.of<GoogleSignInProvider>(context, listen: false);
//               provider.logout();
          }
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Oni'),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, position) {
            return Column(
              // children: [FirstCard(), ActivityCard()],
              children: [
                WeatherCard(),
                ActivityCard(),
                // conditioningHomeCards(),
                BodyStrucInfo()
              ],
            );
          }),
    );
  }
}
