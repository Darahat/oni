//Weather update card calling from pages.Home.dart
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oni/makeResponsiveUI/base_widget.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizationCards.dart';

class Personalize extends StatefulWidget {
  Personalize({Key key}) : super(key: key);

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
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Personalize Oni'),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    new Container(
                        width: width * .2,
                        height: width * .2,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                user.photoURL,
                              ),
                            ))),
                    SizedBox(height: height * 0.03),
                    Container(
                      child: Text(
                        '${user.displayName ?? 'default value'}',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ],
            ))),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Personalization Card',
                style: TextStyle(fontSize: 25),
              ),
            ),
            PersonalizationCards()
          ],
        )),
      );
    });
  }
}
