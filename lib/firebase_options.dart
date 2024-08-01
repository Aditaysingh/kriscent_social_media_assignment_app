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
    apiKey: 'AIzaSyALFTtWFte7-ObjoQNIlxsUaVlWgHThS88',
    appId: '1:928731675529:web:675726b27ba2019b317f58',
    messagingSenderId: '928731675529',
    projectId: 'kriscent-social-media-1a379',
    authDomain: 'kriscent-social-media-1a379.firebaseapp.com',
    storageBucket: 'kriscent-social-media-1a379.appspot.com',
    measurementId: 'G-Y03Q7TM8BB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAixoqCKPpVe3csIz-HEHJJn1OPlDGfnD0',
    appId: '1:928731675529:android:fbf9a6bb0c1ab69f317f58',
    messagingSenderId: '928731675529',
    projectId: 'kriscent-social-media-1a379',
    storageBucket: 'kriscent-social-media-1a379.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCG-VwLrzxhyG0IvWToFCpfWZjJCStYByY',
    appId: '1:928731675529:ios:f24bc3e0b4726cd0317f58',
    messagingSenderId: '928731675529',
    projectId: 'kriscent-social-media-1a379',
    storageBucket: 'kriscent-social-media-1a379.appspot.com',
    iosBundleId: 'com.example.kriscentSocailMedia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCG-VwLrzxhyG0IvWToFCpfWZjJCStYByY',
    appId: '1:928731675529:ios:f24bc3e0b4726cd0317f58',
    messagingSenderId: '928731675529',
    projectId: 'kriscent-social-media-1a379',
    storageBucket: 'kriscent-social-media-1a379.appspot.com',
    iosBundleId: 'com.example.kriscentSocailMedia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyALFTtWFte7-ObjoQNIlxsUaVlWgHThS88',
    appId: '1:928731675529:web:2f2e63a1f1d22145317f58',
    messagingSenderId: '928731675529',
    projectId: 'kriscent-social-media-1a379',
    authDomain: 'kriscent-social-media-1a379.firebaseapp.com',
    storageBucket: 'kriscent-social-media-1a379.appspot.com',
    measurementId: 'G-BDE6XEKCXS',
  );

}