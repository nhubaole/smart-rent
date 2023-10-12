import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/rootView/views/root_screen.dart';

import '../model/account/Account.dart';

class AuthMethods extends GetxController {
  static AuthMethods get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Variables
  late final Rx<User?> firebaseUser;
  var vertificationId = ''.obs;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  // If we are setting initial screen from here
  // then in the main.dart => App() add CircularProgressIndicator()

  _setInitialScreen(User? user) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const RootScreen());
  }

  //FUNC

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+84 ${phoneNo.substring(1)}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.vertificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.vertificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: vertificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const RootScreen())
          : Get.to(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = e.message;
      return ex;
    } catch (_) {
      const ex = 'SignUpWithEmailAndPasswordFailure();';
      return ex;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = e.message;
      return ex;
    } catch (_) {
      const ex = 'LogInWithEmailAndPasswordFailure();';
      return ex;
    }
    return null;
  }

  Future<Account> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await _firestore
        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
        .doc(currentUser.uid)
        .get();
    return Account.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> logout() async => await _auth.signOut();
}
