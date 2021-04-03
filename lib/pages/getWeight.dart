import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:oni/pages/getHeight.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GetWeightPage extends StatefulWidget {
  GetWeightPage({Key key}) : super(key: key);

  @override
  _GetWeightPageState createState() => _GetWeightPageState();
}

class _GetWeightPageState extends State<GetWeightPage> {
  double _selectedWeight = 60;

  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;
  @override
  void initState() {
    super.initState();
    animationFunction(_selectedWeight);
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
  }

  animationFunction(_selectedWeight) {
    var weight;
    if (_selectedWeight <= 35) {
      weight = '30';
    } else if (_selectedWeight >= 35 && _selectedWeight <= 45) {
      weight = '40';
    } else if (_selectedWeight >= 45 && _selectedWeight <= 55) {
      weight = '50';
    } else if (_selectedWeight >= 55 && _selectedWeight <= 65) {
      weight = '60';
    } else if (_selectedWeight >= 65 && _selectedWeight <= 75) {
      weight = '70';
    } else if (_selectedWeight >= 75 && _selectedWeight <= 85) {
      weight = '80';
    } else if (_selectedWeight >= 85 && _selectedWeight <= 95) {
      weight = '90';
    } else if (_selectedWeight >= 95 && _selectedWeight <= 105) {
      weight = '100';
    } else if (_selectedWeight >= 105 && _selectedWeight <= 115) {
      weight = '110';
    } else if (_selectedWeight >= 115 && _selectedWeight <= 125) {
      weight = '120';
    } else if (_selectedWeight >= 125 && _selectedWeight <= 135) {
      weight = '130';
    } else if (_selectedWeight >= 135 && _selectedWeight <= 145) {
      weight = '140';
    } else {
      weight = '150';
    }

    rootBundle.load('assets/animation/compass.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation(weight));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
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
                  'What is your ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Weight?',
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
            SizedBox(
              height: totalHeight / 25,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '${_selectedWeight.round()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
              Text(
                ' Kg',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ]),
            Container(
              height: totalHeight / 4,

              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(
                        artboard: _riveArtboard,
                        fit: BoxFit.fitHeight,
                      ),
              ),
              // FloatingActionButton(
              //   onPressed: _togglePlay,
              //   tooltip: isPlaying ? 'Pause' : 'Play',
              //   child: Icon(
              //     isPlaying ? Icons.pause : Icons.play_arrow,
              //   ),
              // ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(totalWidth * .1, totalHeight * .00,
                    totalWidth * .1, totalHeight * .00),
                child: Slider(
                  value: _selectedWeight,
                  min: 30,
                  max: 150,
                  divisions: 150,
                  label: _selectedWeight.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _selectedWeight = value;
                    });
                    animationFunction(_selectedWeight);
                  },
                )),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetHeightPage()));
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
                        'back',
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
    // return
  }
}
