import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/firebase_options.dart';
import 'package:firebase_notification/services/bloc/common_bloc_provider.dart';
import 'package:firebase_notification/services/pushNotificationMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/product/toDoBloc/toDoScreen.dart';
import 'package:get_storage/get_storage.dart';

// its main function
void main() async {
  //its start the project
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationMsgService.init();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  await GetStorage.init();  // local store data
  runApp(const FirebaseApp());
}

// its start the class its statefulWidget
class FirebaseApp extends StatefulWidget {
  const FirebaseApp({super.key});

  @override
  State<FirebaseApp> createState() => MyAppState();
}

class MyAppState extends State<FirebaseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Firebase App",
        home: MultiBlocProvider(
        providers: CommonBloc.blocProvider, 
        child: const ToDoScreen()));
  }
}
