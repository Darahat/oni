import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oni/FirebaseData/getFirebaseData.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/bmiDataCollection.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizationDataEntry.dart';
import 'package:oni/makeResponsiveUI/base_widget.dart';

class BodyStrucInfo extends StatefulWidget {
  BodyStrucInfo({Key key}) : super(key: key);

  @override
  _BodyStrucInfoState createState() => _BodyStrucInfoState();
}

// class User {
//   int age;
//   String bmi;
//   String gender;
//   int height;
//   bool relegiousnotification;
//   String religion;
//   int weight;
//   User.fromMap(Map<String, dynamic> data) {
//     age = data['age'];
//     bmi = data['bmi'];
//     gender = data['gender'];
//     height = data['height'];
//     relegiousnotification = data['relegiousnotification'];
//     religion = data['religion'];
//     weight = data['weight'];
//   }
// }

class _BodyStrucInfoState extends State<BodyStrucInfo> {
  final List<Color> gradientColor = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool isLoading = true;
  var jsonData;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BaseWidget(builder: (context, sizingInformation) {
      return StreamBuilder(
          stream: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Container(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BMIDataCollection()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.ios_speedometer,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                    Text(
                                      ' Weight',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  '${snapshot.data['weight'].toString()} kg',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  ' Height',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  ' ${snapshot.data['height']} foot',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chartLine,
                                      // color: Color(0xff02d39a),
                                      color: Colors.lime,
                                      size: 15,
                                    ),
                                    Text(
                                      '  BMI',
                                      style: TextStyle(
                                          color: Colors.lime,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  '   ${snapshot.data['bmi']} kg/m²',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Colors.lime),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              return CircularProgressIndicator();
            }
          });
    });
  }
}
