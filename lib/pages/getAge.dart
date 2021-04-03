import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:oni/componentsOfPages/personalizationWidgets/personalizingFunctions.dart';
import 'package:oni/pages/getbmi.dart';
import 'package:rive/rive.dart';
import 'package:oni/pages/getHeight.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GetAgePage extends StatefulWidget {
  GetAgePage({Key key}) : super(key: key);

  @override
  _GetAgePageState createState() => _GetAgePageState();
}

class _GetAgePageState extends State<GetAgePage> {
  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  int _selectedAge = 20;
  String _selectedGender = 'Male';
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

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;
  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
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
          artboard.addController(_controller = SimpleAnimation('idle'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;
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

  int selectedValue;
  showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            itemExtent: 32.0,
            children: const [
              Text('Item01'),
              Text('Item02'),
              Text('Item03'),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.clear, color: Colors.white),
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
                  'Your ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'old',
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
                'To give you a better experience we need to know your age',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text('Select Gender'),
                Text('Select Age'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // genderSelection(context),
                // ageiconChanger(_selectedAge, _selectedGender),
                Column(
                  children: [
                    RaisedButton(
                      onPressed: showPicker,
                      child: Text("Show picker"),
                    ),

                    // Theme(
                    //     data: theme.copyWith(
                    //         accentColor: Colors.orange, // highlted color
                    //         textTheme: theme.textTheme.copyWith(
                    //             //not highlighted styles
                    //             )),
                    //     child: new NumberPicker.integer(
                    //       initialValue: _selectedAge,
                    //       minValue: 10,
                    //       maxValue: 100,
                    //       infiniteLoop: false,
                    //       onChanged: _handleValueChanged,
                    //     )),
                  ],
                ),
              ],
            ),
            // Container(
            //   height: totalHeight / 4,
            //   child: Center(
            //     child: _riveArtboard == null
            //         ? const SizedBox()
            //         : Rive(
            //             artboard: _riveArtboard,
            //             fit: BoxFit.fitHeight,
            //           ),
            //   ),
            // ),
            // SizedBox(
            //   height: totalHeight / 1.8,
            // ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GetBMIPage()));
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
