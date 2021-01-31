import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:oni/FirebaseData/getFirebaseData.dart';

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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getData(),
        builder: (context, snapshot) {
          return new Container(
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [Text(snapshot.data['bmi'])],
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
