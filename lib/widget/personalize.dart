//Weather update card calling from pages.Home.dart
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oni/ui/base_widget.dart';

class Personalize extends StatefulWidget {
  Personalize({Key key}) : super(key: key);

  @override
  _PersonalizeState createState() => new _PersonalizeState();
}

class _PersonalizeState extends State<Personalize> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
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
                Card(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Image.network(
                        user.photoURL,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          '${user.displayName ?? 'default value'}',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))),
            Card(
              child: Text('asdfasdf'),
            )
          ],
        )),
      );
    });
  }
}
