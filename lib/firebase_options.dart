// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC_T0bP2ecY9urRRDt5m4fXtu088NVCp7k',
    appId: '1:760797851051:web:411f20e084b24da971f6ee',
    messagingSenderId: '760797851051',
    projectId: 'food-truck-c9344',
    authDomain: 'food-truck-c9344.firebaseapp.com',
    storageBucket: 'food-truck-c9344.appspot.com',
    measurementId: 'G-4QVK2FH9L8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW4DbFlv-EYrzVpg4nJgDk9952OITDx9s',
    appId: '1:760797851051:android:2a3a06420a53da8571f6ee',
    messagingSenderId: '760797851051',
    projectId: 'food-truck-c9344',
    storageBucket: 'food-truck-c9344.appspot.com',
  );
}
