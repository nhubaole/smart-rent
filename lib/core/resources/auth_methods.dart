import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/signup/views/sign_up.dart';

class AuthMethods extends GetxController {
  static AuthMethods get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var vertificationId = ''.obs;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignUpScreen())
        : Get.offAll(() => const HomeScreen());
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
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const SignUpScreen());
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

  Future<void> logout() async => await _auth.signOut();
}
