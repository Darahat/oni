// // bottom draggable nav
// import 'dart:ui';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter_icons/flutter_icons.dart';

// import 'package:oni/provider/google_sign_in.dart';

// import 'package:provider/provider.dart';

// class DraggableScrollableNav extends StatefulWidget {
//   DraggableScrollableNav({Key key}) : super(key: key);

//   _DraggableScrollableNavState createState() => _DraggableScrollableNavState();
// }

// class _DraggableScrollableNavState extends State<DraggableScrollableNav> {
//   // DBHelper dbHelper;
//   void initState() {
//     super.initState();
//   }

//  const Cubic(0.35, 0.91, 0.33, 0.97)
// @override
// Widget build(BuildContext context) {
//   final user = FirebaseAuth.instance.currentUser;
//   return ConvexAppBar(
//     color: Colors.white,
//     backgroundColor: Colors.green,
//     items: [
//       TabItem(icon: Icons.home, title: 'Home'),
//       TabItem(icon: Ionicons.ios_person, title: 'Profile'),
//       TabItem(icon: Icons.mic, title: 'Speack'),
//       TabItem(icon: Icons.message, title: 'Message'),
//       TabItem(icon: Icons.logout, title: 'Logout'),
//     ],
//     initialActiveIndex: 2, //optional, default as 0
//     onTap: (int i) {
//       if (i == 0) {
//         return Navigator.pushNamed(context, '/home');
//       } else if (i == 1) {
//         return Navigator.pushNamed(context, '/personalize');
//       } else if (i == 4) {
//         final provider =
//             Provider.of<GoogleSignInProvider>(context, listen: false);
//         provider.logout();
//       }
//     },
//   );

//   return SingleChildScrollView(
//       controller: scrollController,
//       child: Container(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/icons/up.png',
//                   height: 16,
//                   width: 16,
//                 ),
//                 Text('Slide Up'),
//                 Container(
//                     margin: EdgeInsets.fromLTRB(0.0, 45.0, 0, 0),
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, '/personalize');
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
//                                 child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           'assets/icons/user.png',
//                                           height: 24,
//                                         ),
//                                         Text('Personalize'),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
//                                 child: Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           'assets/icons/plus.png',
//                                           height: 24,
//                                         ),
//                                         Text('Add'),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 final provider =
//                                     Provider.of<GoogleSignInProvider>(
//                                         context,
//                                         listen: false);
//                                 provider.logout();
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
//                                 child: Padding(
//                                     padding: EdgeInsets.all(5),
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           'assets/icons/logout.png',
//                                           height: 24,
//                                         ),
//                                         Text('Logout'),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ))
//               ],
//             ),
//           )
//         ],
//       )));
// },
//   }
// }
