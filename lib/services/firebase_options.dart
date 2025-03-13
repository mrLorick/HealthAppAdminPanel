import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default FirebaseOptions for Firebase initialization
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return android;
      case TargetPlatform.iOS:
        // return ios;
      default:
        throw UnsupportedError('This platform is not supported.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAq-A1q6-O5KMXd_X2wNrp7biiXDmFP0L8",
    authDomain: "healthappdrjindal.firebaseapp.com",
    projectId: "healthappdrjindal",
    storageBucket: "healthappdrjindal.firebasestorage.app",
    messagingSenderId: "948640398580",
    appId: "1:948640398580:web:e848e52e3da58d30af72a1",
    measurementId: "G-GLPN0HSK60"
  );
}
