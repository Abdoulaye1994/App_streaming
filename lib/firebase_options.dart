
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyCtyWtq2ucH6YhtJ8v_VlDgcMVByYOHfPw',
    appId: '1:715410378946:web:561959e4d43904afe3ab5b',
    messagingSenderId: '715410378946',
    projectId: 'fistebase',
    authDomain: 'fistebase.firebaseapp.com',
    storageBucket: 'fistebase.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAZO-seomXTtF35o0o1p26pHcOB3IXD-8',
    appId: '1:715410378946:android:6e7899841d27b0a7e3ab5b',
    messagingSenderId: '715410378946',
    projectId: 'fistebase',
    storageBucket: 'fistebase.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWaxkrmnMW6dA3BzaoAehxdW8MxekQFp4',
    appId: '1:715410378946:ios:115f2ec741f1baf0e3ab5b',
    messagingSenderId: '715410378946',
    projectId: 'fistebase',
    storageBucket: 'fistebase.firebasestorage.app',
    iosBundleId: 'com.example.streamingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWaxkrmnMW6dA3BzaoAehxdW8MxekQFp4',
    appId: '1:715410378946:ios:115f2ec741f1baf0e3ab5b',
    messagingSenderId: '715410378946',
    projectId: 'fistebase',
    storageBucket: 'fistebase.firebasestorage.app',
    iosBundleId: 'com.example.streamingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCtyWtq2ucH6YhtJ8v_VlDgcMVByYOHfPw',
    appId: '1:715410378946:web:6e78fa82e5ab5804e3ab5b',
    messagingSenderId: '715410378946',
    projectId: 'fistebase',
    authDomain: 'fistebase.firebaseapp.com',
    storageBucket: 'fistebase.firebasestorage.app',
  );
}
