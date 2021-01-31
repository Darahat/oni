import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<DocumentSnapshot> getData() async* {
  User user = FirebaseAuth.instance.currentUser;
  yield* FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .snapshots();
}
