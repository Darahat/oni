import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oni/componentsOfPages/customslider.dart';
import 'package:oni/pages/getAge.dart';
import 'package:rive/rive.dart';

import 'getbmi.dart';

class GetHeightPage extends StatefulWidget {
  // GetHeightPage({Key key}) : super(key: key);
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final selectedWeight;

  GetHeightPage(
      {this.selectedWeight,
      this.sliderHeight = 48,
      this.max = 10,
      this.min = 0,
      this.fullWidth = false});
  @override
  _GetHeightPageState createState() => _GetHeightPageState();
}

class _GetHeightPageState extends State<GetHeightPage> {
  double _selectedHeight = 4.1;
  int sliderMinValue = 4;
  int sliderMaxValue = 7;
  @override
  void initState() {
    super.initState();
    animationFunction(_selectedHeight);
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  animationFunction(_selectedHeight) {
    var height;
    if (_selectedHeight <= 4) {
      height = '4';
    } else if (_selectedHeight >= 4 && _selectedHeight <= 4.3) {
      height = '4.3';
    } else if (_selectedHeight >= 4.3 && _selectedHeight <= 4.5) {
      height = '4.5';
    } else if (_selectedHeight >= 4.5 && _selectedHeight <= 4.8) {
      height = '4.8';
    } else if (_selectedHeight >= 4.8 && _selectedHeight <= 5) {
      height = '5';
    } else if (_selectedHeight >= 5 && _selectedHeight <= 5.3) {
      height = '5.3';
    } else if (_selectedHeight >= 5.3 && _selectedHeight <= 5.5) {
      height = '5.5';
    } else if (_selectedHeight >= 5.5 && _selectedHeight <= 5.8) {
      height = '5.8';
    } else if (_selectedHeight >= 5.8 && _selectedHeight <= 5.6) {
      height = '6';
    } else if (_selectedHeight >= 5.6 && _selectedHeight <= 6.3) {
      height = '6.3';
    } else if (_selectedHeight >= 6.3 && _selectedHeight <= 6.5) {
      height = '6.5';
    } else if (_selectedHeight >= 6.5 && _selectedHeight <= 6.8) {
      height = '6.8';
    } else if (_selectedHeight >= 6.8 && _selectedHeight <= 7) {
      height = '7';
    } else if (_selectedHeight >= 7 && _selectedHeight <= 7.3) {
      height = '7.3';
    } else if (_selectedHeight >= 7.3 && _selectedHeight <= 7.5) {
      height = '7.5';
    } else if (_selectedHeight >= 7.5 && _selectedHeight <= 7.8) {
      height = '7.8';
    } else {
      height = '8';
    }

    rootBundle.load('assets/animation/scale.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation(height));
          setState(() => _riveArtboard = artboard);
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
                  'How ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'tall',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  ' are you?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'To give you a better experience we need to know your height',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '${_selectedHeight.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
              Text(
                ' feet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: totalHeight / 2.8,
                      width: totalWidth / 3,
                      child: Container(
                        child: _riveArtboard == null
                            ? const SizedBox()
                            : Rive(
                                artboard: _riveArtboard,
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ],
                ),
                Container(
                  // color: Colors.red,
                  height: totalHeight / 2.8,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white.withOpacity(1),
                          inactiveTrackColor: Colors.white.withOpacity(.5),

                          trackHeight: 4.0,
                          thumbShape: CustomSliderThumbCircle(
                            thumbRadius: this.widget.sliderHeight * .3,
                            // min: sliderMinValue,
                            // max: sliderMaxValue,
                          ),
                          overlayColor: Colors.white.withOpacity(.4),
                          //valueIndicatorColor: Colors.white,
                          activeTickMarkColor: Colors.white,
                          inactiveTickMarkColor: Colors.red.withOpacity(.7),
                        ),
                        child: Slider(
                          value: _selectedHeight,
                          min: 4,
                          max: 8,
                          divisions: 50,
                          // label: _selectedHeight.toStringAsFixed(1),
                          onChanged: (double value) {
                            setState(() {
                              _selectedHeight = value;
                            });
                            animationFunction(_selectedHeight);
                          },
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: totalHeight / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  padding: EdgeInsets.fromLTRB(
                      totalWidth / 11, 5, totalWidth / 11, 5),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.lightGreen)),
                  splashColor: Colors.green,
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => GetAgePage()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetBMIPage(
                                selectedWeight: widget.selectedWeight,
                                selectedHeight: _selectedHeight)));
                  },
                  child: Icon(
                    Icons.trending_flat,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            )
          ],
        ));
  }
}
