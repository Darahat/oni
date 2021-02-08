//Weather update card calling from pages.Home.dart
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizeSettings.dart';

import 'package:oni/makeResponsiveUI/base_widget.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizationDataEntry.dart';

class Personalize extends StatefulWidget {
  Personalize(
      {Key key,
      this.todoSwitchValue,
      this.stepcountSwitchValue,
      this.fitnessSwitchValue,
      this.weatherSwitchValue})
      : super(key: key);
  bool todoSwitchValue;
  bool stepcountSwitchValue;
  bool fitnessSwitchValue;
  bool weatherSwitchValue;
  @override
  _PersonalizeState createState() => new _PersonalizeState();
}

class _PersonalizeState extends State<Personalize> {
  final user = FirebaseAuth.instance.currentUser;
  var _index = 3;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // BaseWidget help to get screen size and resize every component of it according to device sreen size
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/onilogo.png',
                height: 30,
              ),
              Text(' Personalize ')
            ],
          ),
        ),
        body: SafeArea(
            child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.all(width * .020),
                          child: CircleAvatar(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.red,
                            radius: height * .065,
                            backgroundImage: NetworkImage(
                              user.photoURL,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.all(width * .020),
                          child: Text(
                            '${user.displayName ?? 'default value'}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 25.0,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.all(width * .020),
                          child: Text(
                            '${user.email ?? 'default value'}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .07,
                    ),
                    PersonalizeSettings(
                        todoSwitchValue: widget.todoSwitchValue,
                        stepcountSwitchValue: widget.stepcountSwitchValue,
                        fitnessSwitchValue: widget.fitnessSwitchValue,
                        weatherSwitchValue: widget.weatherSwitchValue)
                  ],
                ))),
      );
    });
  }
}
