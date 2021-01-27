import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oni/makeResponsiveUI/base_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:numberpicker/numberpicker.dart';

class PersonalizationCards extends StatefulWidget {
  PersonalizationCards({Key key}) : super(key: key);

  @override
  _PersonalizationCardsState createState() => _PersonalizationCardsState();
}

class _PersonalizationCardsState extends State<PersonalizationCards> {
  personalizeCard(index) {
    if (index == 0) {
      //Returning Age card
      return ageCard(context);
    } else if (index == 1) {
      //Returning Weight Card
      return Text('Your Weight');
    } else if (index == 2) {
      //Returning Relegion Card
      return Text('Your Relegion');
    } else {
      //Returning Profession Card
      return Text('Your Profession');
    }
  }

  int _currentValue = 20;

  Widget ageCard(BuildContext context) {
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
            "Choose your Age",
            style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
          ),
          new NumberPicker.integer(
              initialValue: _currentValue,
              minValue: 10,
              maxValue: 100,
              onChanged: (newValue) => setState(() => _currentValue = newValue))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Card(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Swiper(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Card(
                          child: personalizeCard(index),
                        ),
                      );
                    },
                    itemWidth: width / 2,
                    itemHeight: height / 2,
                    viewportFraction: 0.65,
                    scale: 0.8,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
