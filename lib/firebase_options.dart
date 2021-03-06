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
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyClCUoH7g2c09xiQ09CMqINlQmF1P7-rkc',
    appId: '1:932649317088:web:38010e1b868b750b91d685',
    messagingSenderId: '932649317088',
    projectId: 'notapp-multi',
    authDomain: 'notapp-multi.firebaseapp.com',
    storageBucket: 'notapp-multi.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7S-k6CWDLhIRcVolsnxnVjuvG6lBKRJQ',
    appId: '1:932649317088:android:04975f5aadacf41e91d685',
    messagingSenderId: '932649317088',
    projectId: 'notapp-multi',
    storageBucket: 'notapp-multi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCv9Zm4OMk3pElwHa1_PQ-zgXf6ZEJ4DHs',
    appId: '1:932649317088:ios:a92edd7b3d6da4a391d685',
    messagingSenderId: '932649317088',
    projectId: 'notapp-multi',
    storageBucket: 'notapp-multi.appspot.com',
    iosClientId:
        '932649317088-rootvalcjdel9knehi4bu8l20ip3lo5v.apps.googleusercontent.com',
    iosBundleId: 'com.karyasa.notapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCv9Zm4OMk3pElwHa1_PQ-zgXf6ZEJ4DHs',
    appId: '1:932649317088:ios:74b2d228384580a591d685',
    messagingSenderId: '932649317088',
    projectId: 'notapp-multi',
    storageBucket: 'notapp-multi.appspot.com',
    iosClientId:
        '932649317088-lt7r1v9io98pndhmf7v27svkrhrlrik6.apps.googleusercontent.com',
    iosBundleId: 'com.karyasa.notes',
  );
}
