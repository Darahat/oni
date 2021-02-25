import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizingFunctions.dart';

class BMIDataCollection extends StatefulWidget {
  BMIDataCollection({Key key}) : super(key: key);

  @override
  _BMIDataCollectionState createState() => _BMIDataCollectionState();
}

class _BMIDataCollectionState extends State<BMIDataCollection> {
  double _bmi = 0.0;
  int _selectedAge;
  double _selectedWeight = 56.0;
  NumberPicker integerNumberPicker;
  NumberPicker decimalNumberPicker;
  double _selectedHeight = 4.0;
  String _selectedGender = 'Male';
  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  void saveData() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'age': _selectedAge,
        'weight': _selectedWeight,
        'gender': _selectedGender,
        'height': _selectedHeight,
        'bmi': _bmi.toStringAsFixed(2),
      });
    } catch (e) {
      print('upload error !!!!!!!!!!!!!!!!!!!!!!!!!!!! $e');
    }
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
        // _selectedReligion = ds.get('religion');
        _selectedGender = ds.get('gender');
        _selectedHeight = ds.get('height');
        _selectedWeight = ds.get('weight');
        _selectedAge = ds.get('age');
        // _relegionNotification = ds.get('relegiousnotification');
        // _bmi = ds.get('bmi');
      });
    } catch (e) {
      print(
          '${e.toString()}asddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    }
  }

  Widget genderSelection(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectedGender = 'Male'),
          child: Container(
              // margin: EdgeInsets.fromLTRB(10, 10, right, bottom),
              margin: EdgeInsets.all(totalWidth * .035),
              child: CircleAvatar(
                radius: totalHeight * .02,
                backgroundColor: _selectedGender == 'Male'
                    ? Color(0xfffffde7)
                    : Colors.transparent,
                child: CircleAvatar(
                  radius: totalHeight * .015,
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
                  radius: totalHeight * .02,
                  backgroundColor: _selectedGender == 'Female'
                      ? Color(0xfffffde7)
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: totalHeight * .015,
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
                  radius: totalHeight * .02,
                  backgroundColor: _selectedGender == 'Transgender'
                      ? Color(0xfffffde7)
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: totalHeight * .015,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/icons/transgender.png'),
                  ),
                ))),
      ],
    ));
  }

  _handleValueChanged(num value) {
    if (value != null) {
      //`setState` will notify the framework that the internal state of this object has changed.
      if (value is int) {
        setState(() => _selectedAge = value);
      } else {
        setState(() => _selectedAge = value);
      }
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _selectedAge = value);
        integerNumberPicker.animateInt(value);
      } else {
        setState(() => _selectedAge = value);
        decimalNumberPicker.animateDecimalAndInteger(value);
      }
    }
  }

  Widget ageCard(BuildContext context) {
    return new Center(
      child: new Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double heightSquare = (_selectedHeight * 0.3048) * 2;
    double calculatedBMI = _selectedWeight / heightSquare;
    _bmi = calculatedBMI;
    final List<Color> gradientColor = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Body Mass Data Collection'),
      ),
      body: Center(
          child: new Column(children: <Widget>[
        new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 5),
              height: totalHeight * .3,
              child: LineChart(
                LineChartData(
                    axisTitleData: FlAxisTitleData(
                        show: true,
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Weight(KG)',
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Poppins',
                                fontSize: 12))),
                    clipData: FlClipData.all(),
                    backgroundColor: Colors.black,
                    minY: 0,
                    maxY: 180,
                    minX: 10,
                    maxX: 32,
                    titlesData: LineTitles.getTitleData(),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 3),
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
            Container(
              padding: EdgeInsets.fromLTRB(totalWidth * .1, totalHeight * .00,
                  totalWidth * .1, totalHeight * .00),
              child: Slider(
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
            ),
            Text('Weight(KG)'),
            Container(
                padding: EdgeInsets.fromLTRB(totalWidth * .1, totalHeight * .00,
                    totalWidth * .1, totalHeight * .00),
                child: Slider(
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
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Select Gender'),
                Text('Select Age'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                genderSelection(context),
                ageiconChanger(_selectedAge, _selectedGender),
                Column(
                  children: [
                    new NumberPicker.integer(
                      initialValue: _selectedAge,
                      minValue: 10,
                      maxValue: 100,
                      infiniteLoop: false,
                      onChanged: _handleValueChanged,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: totalHeight * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
                FlatButton(
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
              ],
            )
          ],
        ),
      ])),
    );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 6,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.white, fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';

              case 180:
                return '180';
            }
            return '';
          }),
      bottomTitles: SideTitles(
          reservedSize: 55,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          getTitles: (value) {
            // print(value);
            switch (value.toInt()) {
              case 11:
                return 'Under';
              case 18:
                return 'Normal';
              case 24:
                return 'Over';
              case 30:
                return 'Obesity';
            }
            return '';
          }));
}
