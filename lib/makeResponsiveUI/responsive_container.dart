import 'package:flutter/material.dart';
import 'package:oni/makeResponsiveUI/base_widget.dart';
import 'package:oni/pages/pages.Home.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BaseWidget help to get screen size and resize every component of it according to device sreen size
    return BaseWidget(builder: (context, sizingInformation) {
      return OniHome();
    });
  }
}
