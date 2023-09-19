import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_rent/core/model/account/user.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  // Future<String> signUpUserWithPhoneNumber(String phoneNumber) async {
  //   try {
  //     UserCredential user = await _auth.signInWithPhoneNumber(phoneNumber);
  //   } catch (error) {}
  // }
}
