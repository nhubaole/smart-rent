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

  Future<String> signUpUserWithPhoneNumber(String phoneNumber) async {
    String res = 'Some error occurred';
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+84${phoneNumber.substring(1)}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          res = 'Verification completed';
        },
        verificationFailed: (FirebaseAuthException e) {
          res = e.message.toString();
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '000000';
          print(smsCode);

          try {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: smsCode);

            await _auth.signInWithCredential(credential);
            res = 'Sign-in successful';
          } catch (error) {
            res = 'Sign-in failed: ${error.toString()}';
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          res = verificationId;
        },
      );
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: otp, smsCode: otp));
    return credentials.user != null ? true : false;
  }
}
