import 'package:flutter/material.dart';
import 'package:oni/ui/base_widget.dart';
import 'package:oni/pages/pages.Home.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      // return
      return OniHome();
    });
  }
}
