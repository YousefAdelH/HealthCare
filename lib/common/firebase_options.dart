// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANiAXLDuZDnk_IVGq8npfmZSWGQ9Xsm88',
    appId: '1:369573824652:web:a937af09a57063a31293a9',
    messagingSenderId: '369573824652',
    projectId: 'dental-79d1b',
    authDomain: 'dental-79d1b.firebaseapp.com',
    storageBucket: 'dental-79d1b.appspot.com',
    measurementId: 'G-5BZ7FGD4K0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD97s2BeRilF-F0jPJAFVH_K_XdYFOetqk',
    appId: '1:369573824652:android:321bcc76141589871293a9',
    messagingSenderId: '369573824652',
    projectId: 'dental-79d1b',
    storageBucket: 'dental-79d1b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfeXXSAgvMfDhfp7tQPt6huAj1YJ66YYg',
    appId: '1:369573824652:ios:88cb1eb938d096661293a9',
    messagingSenderId: '369573824652',
    projectId: 'dental-79d1b',
    storageBucket: 'dental-79d1b.appspot.com',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfeXXSAgvMfDhfp7tQPt6huAj1YJ66YYg',
    appId: '1:369573824652:ios:88cb1eb938d096661293a9',
    messagingSenderId: '369573824652',
    projectId: 'dental-79d1b',
    storageBucket: 'dental-79d1b.appspot.com',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyANiAXLDuZDnk_IVGq8npfmZSWGQ9Xsm88',
    appId: '1:369573824652:web:758f6d8382465e1b1293a9',
    messagingSenderId: '369573824652',
    projectId: 'dental-79d1b',
    authDomain: 'dental-79d1b.firebaseapp.com',
    storageBucket: 'dental-79d1b.appspot.com',
    measurementId: 'G-RPE4PVP83F',
  );
}