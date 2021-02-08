import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:ui';

class PersonalizeSettings extends StatefulWidget {
  PersonalizeSettings(
      {Key key,
      this.todoSwitchValue,
      this.stepcountSwitchValue,
      this.fitnessSwitchValue,
      this.weatherSwitchValue})
      : super(key: key);
  bool todoSwitchValue;
  bool stepcountSwitchValue;
  bool fitnessSwitchValue;
  bool weatherSwitchValue;
  @override
  _PersonalizeSettingsState createState() => _PersonalizeSettingsState();
}

class _PersonalizeSettingsState extends State<PersonalizeSettings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, position) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white30, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.transparent,
                  child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Column(
                        children: [
                          Card(
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.all(width * .020),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor: Colors.white10,
                                            child: Icon(
                                              FontAwesome5Solid.cloud_sun,
                                              color: Colors.white,
                                              size: 20,
                                              textDirection: TextDirection.rtl,
                                            )),
                                        Text('  Weather Card',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16)),
                                      ],
                                    ),
                                    CupertinoSwitch(
                                      value: widget.weatherSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.weatherSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          Card(
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.all(width * .020),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.white10,
                                          child: Icon(
                                            FontAwesome5Solid.walking,
                                            color: Colors.white,
                                            size: 20,
                                            textDirection: TextDirection.rtl,
                                          )),
                                      Text('  Steps Count',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16)),
                                    ]),
                                    CupertinoSwitch(
                                      value: widget.stepcountSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.stepcountSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          Card(
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.all(width * .020),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.white10,
                                          child: Icon(
                                            FontAwesome5Solid.th_list,
                                            color: Colors.white,
                                            size: 18,
                                            textDirection: TextDirection.rtl,
                                          )),
                                      Text('   Todo',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16)),
                                    ]),
                                    CupertinoSwitch(
                                      value: widget.todoSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.todoSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          Card(
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.all(width * .020),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white10,
                                        child: Icon(
                                          FontAwesome5Solid.heartbeat,
                                          color: Colors.white,
                                          size: 20,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      Text('   Fitness Card',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ]),
                                    CupertinoSwitch(
                                      value: widget.fitnessSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.fitnessSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      )),
                );
              })),
    );
  }
}
