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
    apiKey: 'AIzaSyCb5Y4X5GY4y9gqsrBsMxEJcR08yCsGIQI',
    appId: '1:594079741566:web:0f9b01550cb213d5570a2f',
    messagingSenderId: '594079741566',
    projectId: 'chronos-todo',
    authDomain: 'chronos-todo.firebaseapp.com',
    storageBucket: 'chronos-todo.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb5Y4X5GY4y9gqsrBsMxEJcR08yCsGIQI',
    appId: '1:594079741566:web:0f9b01550cb213d5570a2f',
    messagingSenderId: '594079741566',
    projectId: 'chronos-todo',
  );
}
