import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_rent/firebase_options.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
