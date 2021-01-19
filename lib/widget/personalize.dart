import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oni/ui/base_widget.dart';

class Personalize extends StatefulWidget {
  Personalize({Key key}) : super(key: key);

  @override
  _PersonalizeState createState() => new _PersonalizeState();
}

class _PersonalizeState extends State<Personalize> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Personalize Oni'),
        ),
        body: SafeArea(
            child: Column(
          children: [Text('Personalize me')],
        )),
      );
    });
  }
}
