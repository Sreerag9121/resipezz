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
    apiKey: 'AIzaSyBe2ZdwKC--rzxK6PdOb6kovs_i8_-ybeg',
    appId: '1:904843103992:web:29b9030c89879d8606b50d',
    messagingSenderId: '904843103992',
    projectId: 'recipizz-app',
    authDomain: 'recipizz-app.firebaseapp.com',
    storageBucket: 'recipizz-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDT4gwO-7aB739cQqsnkHPaFpfYH215JRU',
    appId: '1:904843103992:android:53e55d709deeb72c06b50d',
    messagingSenderId: '904843103992',
    projectId: 'recipizz-app',
    storageBucket: 'recipizz-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC76JliuVFDraF-H6xqcVXnv3PuaGq9oDc',
    appId: '1:904843103992:ios:417d80174e52470a06b50d',
    messagingSenderId: '904843103992',
    projectId: 'recipizz-app',
    storageBucket: 'recipizz-app.appspot.com',
    iosBundleId: 'com.example.recipizz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC76JliuVFDraF-H6xqcVXnv3PuaGq9oDc',
    appId: '1:904843103992:ios:417d80174e52470a06b50d',
    messagingSenderId: '904843103992',
    projectId: 'recipizz-app',
    storageBucket: 'recipizz-app.appspot.com',
    iosBundleId: 'com.example.recipizz',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBe2ZdwKC--rzxK6PdOb6kovs_i8_-ybeg',
    appId: '1:904843103992:web:c875a95ada7028b506b50d',
    messagingSenderId: '904843103992',
    projectId: 'recipizz-app',
    authDomain: 'recipizz-app.firebaseapp.com',
    storageBucket: 'recipizz-app.appspot.com',
  );
}
