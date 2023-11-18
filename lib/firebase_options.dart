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
    apiKey: 'AIzaSyBGMDv_i4L6tKKJFGBLa7Rzb1Oa3Q7pi6I',
    appId: '1:556178804571:web:7376bf9e5aa7dfd38a547e',
    messagingSenderId: '556178804571',
    projectId: 'manunited-wallpaper-4ff2a',
    authDomain: 'manunited-wallpaper-4ff2a.firebaseapp.com',
    storageBucket: 'manunited-wallpaper-4ff2a.appspot.com',
    measurementId: 'G-HS78EXE17Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOgLT1MNEPx0RhSFcR7f-dDtE17APU6CQ',
    appId: '1:556178804571:android:b0e7bf0f0a7666dd8a547e',
    messagingSenderId: '556178804571',
    projectId: 'manunited-wallpaper-4ff2a',
    storageBucket: 'manunited-wallpaper-4ff2a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIW89Z7rJziGR8vxKLlF-g4JqpnJIPw2A',
    appId: '1:556178804571:ios:b865870732eca3318a547e',
    messagingSenderId: '556178804571',
    projectId: 'manunited-wallpaper-4ff2a',
    storageBucket: 'manunited-wallpaper-4ff2a.appspot.com',
    iosBundleId: 'com.example.manunitedWallpaper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIW89Z7rJziGR8vxKLlF-g4JqpnJIPw2A',
    appId: '1:556178804571:ios:2aee6b4ce417822e8a547e',
    messagingSenderId: '556178804571',
    projectId: 'manunited-wallpaper-4ff2a',
    storageBucket: 'manunited-wallpaper-4ff2a.appspot.com',
    iosBundleId: 'com.example.manunitedWallpaper.RunnerTests',
  );
}