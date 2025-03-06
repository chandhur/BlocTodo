import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

class PushNotificationMsgService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
  await messaging.requestPermission();
  // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage); // Set handler first
  // String? token = await messaging.getToken();
  // print("Token: $token"); // Correctly print the token
}

// Move outside the class
 static Future<void> handleBackgroundMessage(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  await Firebase.initializeApp();
  print(message.notification?.title ?? "null");
}


}