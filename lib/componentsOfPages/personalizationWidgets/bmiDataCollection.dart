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
  int _selectedAge = 14;
  double _selectedWeight = 56.0;

  double _selectedHeight = 4.0;
  String _selectedGender = 'Male';
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

  Widget genderSelection(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Gender'),
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
        // Card(
        //     child: Container(
        //         padding: EdgeInsets.all(5),
        //         child:
        //             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        //           Text(
        //             "Body Mass Index(BMI)",
        //             style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
        //           ),
        //         ]))),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                genderSelection(context),
                ageiconChanger(_selectedAge, _selectedGender),
                Column(
                  children: [
                    Text('Select Age'),
                    new NumberPicker.integer(
                      initialValue: _selectedAge,
                      minValue: 10,
                      maxValue: 100,
                      onChanged: (newValue) => setState(
                        () => _selectedAge = newValue,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: totalHeight * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
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
            print(value);
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
