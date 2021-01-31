import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizingFunctions.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/BMIChartlineTitles.dart';

class PersonalizationCards extends StatefulWidget {
  PersonalizationCards({Key key}) : super(key: key);

  @override
  _PersonalizationCardsState createState() => _PersonalizationCardsState();
}

class _PersonalizationCardsState extends State<PersonalizationCards> {
  double _bmi = 0.0;
  int _selectedAge = 14;
  double _selectedWeight = 56.0;
  String _selectedReligion = '';
  double _selectedHeight = 4.0;
  String _selectedGender = 'Male';
  bool _relegionNotification = true;
  final List<Color> gradientColor = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  final userCollection = FirebaseFirestore.instance.collection('users');
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Future getCurrentUserData() async {
    User user = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot ds = await userCollection.doc(user.uid).get();
      setState(() {
        _selectedReligion = ds.get('religion');
        _selectedGender = ds.get('gender');
        _selectedHeight = ds.get('height');
        _selectedWeight = ds.get('weight');
        _relegionNotification = ds.get('relegiousnotification');
        // _bmi = ds.get('bmi');
        _selectedAge = ds.get('age');
      });
      print('$_selectedAge ddddddddddddddddddddddddddddddddddddddddddddd');
    } catch (e) {
      print(
          '${e.toString()}asddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    }
  }

  personalizeCard(index) {
    if (index == 0) {
      //Returning Age card
      return ageCard(context);
    } else if (index == 1) {
      //Returning Weight Card
      return heightWeightCard(context);
    } else if (index == 2) {
      //Returning Relegion Card
      return religionCard(context);
    } else {
      //Returning Profession Card
      return Text('Your Profession');
    }
  }

  bmiIndexFunction() {}
  Widget ageCard(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return new Center(
      child: new Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Choose your Age",
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      )
                    ],
                  ))),
          SizedBox(
            height: totalHeight * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ageiconChanger(_selectedAge, _selectedGender),
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
          Container(
            width: totalWidth * .8,
            child: Card(
                child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Select your Gender',
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
            )),
          ),
          genderSelection(context)
        ],
      ),
    );
  }

  Widget genderSelection(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectedGender = 'Male'),
          child: Container(
              // margin: EdgeInsets.fromLTRB(10, 10, right, bottom),
              margin: EdgeInsets.all(totalWidth * .035),
              child: CircleAvatar(
                radius: totalHeight * .033,
                backgroundColor: _selectedGender == 'Male'
                    ? Color(0xfffffde7)
                    : Colors.transparent,
                child: CircleAvatar(
                  radius: totalHeight * .02,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/icons/mensymbol.png',
                  ),
                ),
              )),
        ),
        GestureDetector(
            onTap: () => setState(() => _selectedGender = 'Female'),
            child: Container(
                // margin: EdgeInsets.fromLTRB(10, 10, right, bottom),
                margin: EdgeInsets.all(totalWidth * .035),
                child: CircleAvatar(
                  radius: totalHeight * .033,
                  backgroundColor: _selectedGender == 'Female'
                      ? Color(0xfffffde7)
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: totalHeight * .02,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/icons/femalesymbol.png',
                    ),
                  ),
                ))),
        GestureDetector(
            onTap: () => setState(() => _selectedGender = 'Transgender'),
            child: Container(
                // margin: EdgeInsets.fromLTRB(10, 10, right, bottom),
                margin: EdgeInsets.all(totalWidth * .035),
                child: CircleAvatar(
                  radius: totalHeight * .033,
                  backgroundColor: _selectedGender == 'Transgender'
                      ? Color(0xfffffde7)
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: totalHeight * .02,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/icons/transgender.png'),
                  ),
                ))),
      ],
    ));
  }

  Widget heightWeightCard(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double heightSquare = (_selectedHeight * 0.3048) * 2;
    double calculatedBMI = _selectedWeight / heightSquare;
    _bmi = calculatedBMI;
    return new Center(
        child: new Column(children: <Widget>[
      Card(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Body Mass Index(BMI)",
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
              ]))),
      new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 10),
            height: totalHeight * .25,
            child: LineChart(
              LineChartData(
                  backgroundColor: Colors.black,
                  minY: 0,
                  maxY: 150,
                  minX: 10,
                  maxX: 32,
                  titlesData: LineTitles.getTitleData(),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                      );
                    },
                  ),
                  lineBarsData: [
                    LineChartBarData(
                        spots: [
                          FlSpot(10, 0),
                          FlSpot(calculatedBMI, _selectedWeight)
                        ],
                        isCurved: true,
                        barWidth: 2,
                        colors: gradientColor,
                        belowBarData: BarAreaData(
                          show: true,
                          colors: gradientColor
                              .map((color) => color.withOpacity(.3))
                              .toList(),
                        ))
                  ]),
            ),
          ),
          Text('Height(Foot)'),
          Slider(
            value: _selectedHeight,
            min: 3,
            max: 10,
            divisions: 70,
            label: _selectedHeight.toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                _selectedHeight = value;
              });
            },
          ),
          Text('Weight(KG)'),
          Slider(
            value: _selectedWeight,
            min: 30,
            max: 150,
            divisions: 100,
            label: _selectedWeight.round().toString(),
            onChanged: (double value) {
              setState(() {
                _selectedWeight = value;
              });
            },
          )
        ],
      ),
    ]));
  }

  // religion picker
  int relegionIndex = 0;
  Widget religionCard(BuildContext context) {
    if (_selectedReligion == 'islam') {
      relegionIndex = 0;
    } else if (_selectedReligion == 'Christianity') {
      relegionIndex = 1;
    } else if (_selectedReligion == 'Hinduism') {
      relegionIndex = 2;
    } else if (_selectedReligion == 'Buddhism') {
      relegionIndex = 3;
    } else if (_selectedReligion == 'Judism') {
      relegionIndex = 4;
    } else {
      relegionIndex = 5;
    }
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Center(
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select your religion",
                          style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                        ),
                      ]))),
        ),
        SizedBox(
          height: totalHeight * 0.01,
        ),
        Center(
          child: Container(
              height: totalHeight * 0.3,
              width: totalWidth * 1,
              // had to use cupertino picker cz nothing else fitted this UI
              child: Center(
                child: CupertinoPicker(
                  looping: false,
                  backgroundColor: Colors.transparent,
                  itemExtent: 30,
                  magnification: 1.5,
                  scrollController:
                      FixedExtentScrollController(initialItem: relegionIndex),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/islam.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Islam",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/cross.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Christianity",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/hindu.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Hinduism",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/buddhism.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Buddhism",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/hebrew.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Judism",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/shikh.png',
                          height: totalWidth * .05,
                        ),
                        Text(' '),
                        Text(
                          "Seikhism",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
        Row(
          children: [
            Checkbox(
              value: this._relegionNotification,
              onChanged: (bool value) {
                setState(() {
                  this._relegionNotification = value;
                });
              },
            ),
            Flexible(child: new Text("I want to get relegious notification"))
          ],
        )
      ],
    );
  }

  Widget professionCard(BuildContext context) {
    return Text('Select Your profession');
  }
  // method to save data in firebase

  void saveData() async {
    print("age $_selectedAge, relegious $_relegionNotification ");
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'age': _selectedAge,
        'weight': _selectedWeight,
        'religion': _selectedReligion,
        'gender': _selectedGender,
        'height': _selectedHeight,
        'relegiousnotification': _relegionNotification,
        'bmi': _bmi.toStringAsFixed(2),
      });
    } catch (e) {
      print('upload error !!!!!!!!!!!!!!!!!!!!!!!!!!!! $e');
    }
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
                  height: height * .53,
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
                    viewportFraction: 0.95,
                    scale: 1,
                  ),
                ),
                SizedBox(height: height * 0.05),
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
