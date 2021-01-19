import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:oni/provider/google_sign_in.dart';

import 'package:provider/provider.dart';

class DraggableScrollableNav extends StatefulWidget {
  DraggableScrollableNav({Key key}) : super(key: key);

  _DraggableScrollableNavState createState() => _DraggableScrollableNavState();
}

class _DraggableScrollableNavState extends State<DraggableScrollableNav> {
  // DBHelper dbHelper;
  void initState() {
    super.initState();
  }

  Route _createAnimatedRoute(page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: Stepper(type: StepperType.horizontal, steps: [
        Step(
            title: Text("What is your relegion"),
            content: Column(
              children: [Text('data')],
            )),
        Step(
            title: Text("What is your Proffession"),
            content: Column(
              children: [Text('data')],
            )),
        Step(
            title: Text("What is your relegion"),
            content: Column(
              children: [Text('data')],
            ))
      ]),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

//  const Cubic(0.35, 0.91, 0.33, 0.97)
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SizedBox.expand(
        child: DraggableScrollableSheet(
      initialChildSize: 0.07,
      minChildSize: 0.07,
      maxChildSize: 0.3,
      builder: (context, scrollController) {
        return SingleChildScrollView(
            controller: scrollController,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/up.png',
                        height: 16,
                        width: 16,
                      ),
                      Text('Slide Up'),
                      Container(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0, 0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //                     Navigator.of(context)
                                      // .push(_createAnimatedRoute(new Personalize()));},
                                      Navigator.pushNamed(
                                          context, '/personalize');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/icons/user.png',
                                                height: 24,
                                              ),
                                              Text('Personalize'),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //                     Navigator.of(context)
                                      // .push(_createAnimatedRoute(new Personalize()));},
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/icons/plus.png',
                                                height: 24,
                                              ),
                                              Text('Add'),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final provider =
                                          Provider.of<GoogleSignInProvider>(
                                              context,
                                              listen: false);
                                      provider.logout();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/icons/logout.png',
                                                height: 24,
                                              ),
                                              Text('Logout'),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     InkWell(
                              //       child: Card(
                              //         child: Padding(
                              //           padding: EdgeInsets.all(10),
                              //           child: Text('Log Out'),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            )));
      },
    ));
  }
}
