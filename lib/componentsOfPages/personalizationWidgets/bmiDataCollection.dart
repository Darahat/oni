import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizingFunctions.dart';
import 'package:flutter/services.dart';
import 'package:oni/pages/getWeight.dart';
import 'package:rive/rive.dart';

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

  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.
  String isPlaying = "Still";
//  @override
//   void initState() {
//     super.initState();
//     // getCurrentUserData();
//     rootBundle.load('assets/images/jogging.riv').then(
//       (data) async {
//         final file = RiveFile();

//         // Load the RiveFile from the binary data.
//         if (file.import(data)) {
//           // The artboard is the root of the animation and gets drawn in the
//           // Rive widget.
//           final artboard = file.mainArtboard;
//           // Add a controller to play back a known animation on the main/default
//           // artboard.We store a reference to it so we can toggle playback.
//           artboard.addController(_controller = SimpleAnimation('idle'));
//           setState(() => _riveArtboard = artboard);
//         }
//       },
//     );
//   }
  Artboard _riveArtboard;
  Artboard _riveArtboardforbackbutton;
  RiveAnimationController _controller;
  RiveAnimationController _controller2;
  @override
  void initState() {
    super.initState();
    // rootBundle.load('assets/images/jogging.riv').then(
    //   (data) async {
    //     final file = RiveFile();

    //     // Load the RiveFile from the binary data.
    //     if (file.import(data)) {
    //       // The artboard is the root of the animation and gets drawn in the
    //       // Rive widget.
    //       final artboard = file.mainArtboard;
    //       // Add a controller to play back a known animation on the main/default
    //       // artboard.We store a reference to it so we can toggle playback.
    //       artboard.addController(_controller = SimpleAnimation('Still'));
    //       setState(() => _riveArtboard = artboard);
    //     }
    //   },
    // );
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    animation(isPlaying);
    nextButton();
  }

  animation(isPlaying) {
    rootBundle.load('assets/animation/jogging.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation(isPlaying));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  nextButton() {
    print("hello buddy from next button");
    rootBundle.load('assets/animation/nextbutton.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('nextbutton'));
          setState(() => _riveArtboardforbackbutton = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: totalHeight / 10,
          ),
          Container(
            height: totalHeight / 2.5,
            width: totalWidth,
            child: _riveArtboard == null
                ? const SizedBox()
                : Rive(
                    artboard: _riveArtboard,
                  ),
          ),
          SizedBox(
            height: totalHeight / 20,
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(totalWidth / 20, 10, totalWidth / 20, 10),
            child: Text(
              "Your Progress",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(totalWidth / 20, 0, totalWidth / 20, 0),
            child: Text(
              "Calorie counting with the intent of losing weight, on its simplest levels.It's real",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                isPlaying = 'Move';
              });
              animation(isPlaying);
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetWeightPage()));
              });
            },
            backgroundColor: Colors.green,
            child: Container(
              height: 50.0,
              width: 50.0,
              child: _riveArtboardforbackbutton == null
                  ? const SizedBox()
                  : Rive(
                      artboard: _riveArtboardforbackbutton,
                    ),
            ))

        // SizedBox(
        //   onPressed: null,
        //   child: nextButton(),
        // )
        // FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       isPlaying = 'Move';
        //     });
        //     animation(isPlaying);
        //   },
        //   // tooltip: isPlaying ? 'Pause' : 'Play',
        //   child: Icon(
        //     Icons.play_arrow,
        //   ),
        // ),
        );
  }
}
// children: <Widget>[
//   Container(
//     padding: EdgeInsets.all(10),
//     margin: EdgeInsets.only(top: 5),
//     height: totalHeight * .3,
//     child: LineChart(
//       LineChartData(
//           axisTitleData: FlAxisTitleData(
//               show: true,
//               leftTitle: AxisTitle(
//                   showTitle: true,
//                   titleText: 'Weight(KG)',
//                   textAlign: TextAlign.center,
//                   textStyle: TextStyle(
//                       color: Colors.white54,
//                       fontFamily: 'Poppins',
//                       fontSize: 12))),
//           clipData: FlClipData.all(),
//           backgroundColor: Colors.black,
//           minY: 0,
//           maxY: 180,
//           minX: 10,
//           maxX: 32,
//           titlesData: LineTitles.getTitleData(),
//           borderData: FlBorderData(
//             show: true,
//             border:
//                 Border.all(color: const Color(0xff37434d), width: 3),
//           ),
//           gridData: FlGridData(
//             show: true,
//             getDrawingHorizontalLine: (value) {
//               return FlLine(
//                 color: const Color(0xff37434d),
//               );
//             },
//           ),
//           lineBarsData: [
//             LineChartBarData(
//                 spots: [
//                   FlSpot(10, 0),
//                   FlSpot(calculatedBMI, _selectedWeight)
//                 ],
//                 isCurved: true,
//                 barWidth: 2,
//                 colors: gradientColor,
//                 belowBarData: BarAreaData(
//                   show: true,
//                   colors: gradientColor
//                       .map((color) => color.withOpacity(.3))
//                       .toList(),
//                 ))
//           ]),
//     ),
//   ),
//   Text('Height(Foot)'),
//   Container(
//     padding: EdgeInsets.fromLTRB(totalWidth * .1, totalHeight * .00,
//         totalWidth * .1, totalHeight * .00),
//     child: Slider(
//       value: _selectedHeight,
//       min: 3,
//       max: 10,
//       divisions: 70,
//       label: _selectedHeight.toStringAsFixed(1),
//       onChanged: (double value) {
//         setState(() {
//           _selectedHeight = value;
//         });
//       },
//     ),
//   ),
//   Text('Weight(KG)'),
//   Container(
//       padding: EdgeInsets.fromLTRB(totalWidth * .1, totalHeight * .00,
//           totalWidth * .1, totalHeight * .00),
//       child: Slider(
//         value: _selectedWeight,
//         min: 30,
//         max: 150,
//         divisions: 100,
//         label: _selectedWeight.round().toString(),
//         onChanged: (double value) {
//           setState(() {
//             _selectedWeight = value;
//           });
//         },
//       )),
//   Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Text('Select Gender'),
//       Text('Select Age'),
//     ],
//   ),
//   Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       genderSelection(context),
//       ageiconChanger(_selectedAge, _selectedGender),
//       Column(
//         children: [
//           new NumberPicker.integer(
//             initialValue: _selectedAge,
//             minValue: 10,
//             maxValue: 100,
//             infiniteLoop: false,
//             onChanged: _handleValueChanged,
//           ),
//         ],
//       ),
//     ],
//   ),
//   SizedBox(
//     height: totalHeight * .03,
//   ),
//   Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       TextButton(
//         onPressed: () => Navigator.pop(context),
//         child: Text('Close'),
//       ),
//       FlatButton(
//         color: Colors.white,
//         onPressed: () {
//           saveData();
//           Navigator.pop(context);
//         },
//         child: Center(
//           child: Text(
//             "Save",
//             style: TextStyle(
//               fontSize: 16,
//               fontFamily: 'Roboto',
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     ],
//   )
// ],
//         ),
//       ])),
//     );
//   }
// }

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
