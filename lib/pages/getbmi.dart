import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/bmiDataCollection.dart';
import 'package:rive/rive.dart';
import 'package:oni/pages/getHeight.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';

class GetBMIPage extends StatefulWidget {
  GetBMIPage({Key key, this.selectedWeight, this.selectedHeight})
      : super(key: key);
  final double selectedWeight;
  final double selectedHeight;
  @override
  _GetBMIPageState createState() => _GetBMIPageState();
}

class _GetBMIPageState extends State<GetBMIPage> {
  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;
  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
  }

  double calculatedBMI;
  final List<Color> gradientColor = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    var feetTometer = (widget.selectedHeight * 0.3048);
    calculatedBMI = widget.selectedWeight / (feetTometer * feetTometer);
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: totalHeight / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What is your $feetTometer  $calculatedBMI',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'BMI?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'To give you a better experience we need to know your Weight',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
            // SizedBox(
            //   height: totalHeight / 1.8,
            // ),
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
                            FlSpot(calculatedBMI, widget.selectedWeight)
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
//
//
//
//
//
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     FlatButton(
            //       padding: EdgeInsets.fromLTRB(
            //           totalWidth / 11, 5, totalWidth / 11, 5),
            //       color: Colors.green,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25.0),
            //           side: BorderSide(color: Colors.lightGreen)),
            //       splashColor: Colors.green,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => GetHeightPage()));
            //       },
            //       child: Icon(
            //         Icons.trending_flat,
            //         color: Colors.white,
            //         size: 40,
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
            //       child: TextButton(
            //           onPressed: () {},
            //           child: Text(
            //             'Skip',
            //             style: TextStyle(
            //                 fontFamily: 'Poppins',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold),
            //           )),
            //     )
            //   ],
            // )
          ],
        ));

    // return Container(
    //     height: totalHeight / 2,
    //     child: Column(
    //       children: [
    //         // Center(
    //         //   child: _riveArtboard == null
    //         //       ? const SizedBox()
    //         //       : Rive(
    //         //           artboard: _riveArtboard,
    //         //           fit: BoxFit.fitHeight,
    //         //         ),
    //         // ),
    //         // FloatingActionButton(
    //         //   onPressed: _togglePlay,
    //         //   tooltip: isPlaying ? 'Pause' : 'Play',
    //         //   child: Icon(
    //         //     isPlaying ? Icons.pause : Icons.play_arrow,
    //         //   ),
    //         // ),
    //       ],
    //     ));
  }
}
