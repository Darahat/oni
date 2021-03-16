import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            SizedBox(
              height: totalHeight / 1.8,
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
