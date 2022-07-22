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
        return ios;
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
    apiKey: 'AIzaSyDjgQMsSPFRcMk8ndABAbwWtIQsR8q0dB0',
    appId: '1:471985790683:web:affd0fdd62fa9a4b31f6fe',
    messagingSenderId: '471985790683',
    projectId: 'mylist-6aa8e',
    authDomain: 'mylist-6aa8e.firebaseapp.com',
    storageBucket: 'mylist-6aa8e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPIBIz3R-UEzDBClqGjjdZ3ywLnGcU_ro',
    appId: '1:471985790683:android:30ef2f71c55234ab31f6fe',
    messagingSenderId: '471985790683',
    projectId: 'mylist-6aa8e',
    storageBucket: 'mylist-6aa8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqKAGKUry_unvhYx_649UIAae0ha4YM7k',
    appId: '1:471985790683:ios:d3e4beabe919e38231f6fe',
    messagingSenderId: '471985790683',
    projectId: 'mylist-6aa8e',
    storageBucket: 'mylist-6aa8e.appspot.com',
    iosClientId: '471985790683-fjvvad27sffshdelodkvhkk5issibsrv.apps.googleusercontent.com',
    iosBundleId: 'com.example.listmobile',
  );
}
