import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      return weightCard(context);
    } else if (index == 2) {
      //Returning Relegion Card
      return religionCard(context);
    } else {
      //Returning Profession Card
      return Text('Your Profession');
    }
  }

  int _selectedAge = 14;
  int _selectedWeight = 50;
  String _selectedReligion = '';

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
            initialValue: _selectedAge,
            minValue: 10,
            maxValue: 100,
            onChanged: (newValue) => setState(
              () => _selectedAge = newValue,
            ),
          ),
        ],
      ),
    );
  }

  // weight card

  Widget weightCard(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose your weight (KG)",
            style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
          ),
          new NumberPicker.integer(
            initialValue: _selectedWeight,
            minValue: 10,
            maxValue: 100,
            onChanged: (newValue) => setState(
              () => _selectedWeight = newValue,
            ),
          ),
        ],
      ),
    );
  }

  // religion picker

  Widget religionCard(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: totalHeight * 0.05,
        ),
        Center(
          child: Text(
            "Choose your religion",
            style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
          ),
        ),
        SizedBox(
          height: totalHeight * 0.01,
        ),
        Center(
          child: Container(
              height: totalHeight * 0.2,
              width: totalWidth * 1,
              // had to use cupertino picker cz nothing else fitted this UI
              child: Center(
                child: CupertinoPicker(
                  itemExtent: 30,
                  magnification: 1.5,
                  scrollController: FixedExtentScrollController(initialItem: 1),
                  onSelectedItemChanged: (int index) {
                    if (index == 0) {
                      _selectedReligion = "Islam";
                    } else if (index == 1) {
                      _selectedReligion = "Christianity";
                    } else if (index == 2) {
                      _selectedReligion = "Hinduism";
                    } else if (index == 3) {
                      _selectedReligion = "Buddhism";
                    } else if (index == 4) {
                      _selectedReligion = "Judism";
                    } else if (index == 5) {
                      _selectedReligion = "Seikhsm";
                    }

                    print(_selectedReligion);
                  },
                  children: [
                    Text(
                      "Islam",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Christianity",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Hinduism",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Buddhism",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Judism",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Seikhism",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  // TODO : have to create profession card

  // method to save data in firebase

  void saveData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'age': _selectedAge,
      'weight': _selectedWeight,
      'religion': _selectedReligion,
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          child: SingleChildScrollView(
            // converted it to column to fit save button
            // otherwise i have to pass the data to parent class
            // which takes time :3
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: height * .4,
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
                ),
                SizedBox(height: height * 0.08),
                Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      saveData();
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
