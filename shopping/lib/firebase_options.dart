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
    apiKey: 'AIzaSyASVeqVA9kgiBYrVWUfvxBZHtLHbFfmrh8',
    appId: '1:65513740720:web:0a4030bb89f3faa9d29e75',
    messagingSenderId: '65513740720',
    projectId: 'shopping-c2ce8',
    authDomain: 'shopping-c2ce8.firebaseapp.com',
    storageBucket: 'shopping-c2ce8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBGSHfAcCsY2OEJ-5LimZAtSr1GDWXkdk',
    appId: '1:65513740720:android:a9d454a96db1276fd29e75',
    messagingSenderId: '65513740720',
    projectId: 'shopping-c2ce8',
    storageBucket: 'shopping-c2ce8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuihLpouPY-SbxjaIzZ4R4YLpyBocIJeI',
    appId: '1:65513740720:ios:648c3b1a5bdb654ed29e75',
    messagingSenderId: '65513740720',
    projectId: 'shopping-c2ce8',
    storageBucket: 'shopping-c2ce8.appspot.com',
    iosBundleId: 'com.example.shopping',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuihLpouPY-SbxjaIzZ4R4YLpyBocIJeI',
    appId: '1:65513740720:ios:648c3b1a5bdb654ed29e75',
    messagingSenderId: '65513740720',
    projectId: 'shopping-c2ce8',
    storageBucket: 'shopping-c2ce8.appspot.com',
    iosBundleId: 'com.example.shopping',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASVeqVA9kgiBYrVWUfvxBZHtLHbFfmrh8',
    appId: '1:65513740720:web:dcd2bc2131552f02d29e75',
    messagingSenderId: '65513740720',
    projectId: 'shopping-c2ce8',
    authDomain: 'shopping-c2ce8.firebaseapp.com',
    storageBucket: 'shopping-c2ce8.appspot.com',
  );
}
