import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class GetHeightPage extends StatefulWidget {
  GetHeightPage({Key key}) : super(key: key);

  @override
  _GetHeightPageState createState() => _GetHeightPageState();
}

class _GetHeightPageState extends State<GetHeightPage> {
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
    rootBundle.load('assets/images/jogging.riv').then(
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
    return Container(
        height: totalHeight / 2,
        child: Column(
          children: [
            Center(
              child: _riveArtboard == null
                  ? const SizedBox()
                  : Rive(
                      artboard: _riveArtboard,
                      fit: BoxFit.fitHeight,
                    ),
            ),
            FloatingActionButton(
              onPressed: _togglePlay,
              tooltip: isPlaying ? 'Pause' : 'Play',
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ));
  }
}
