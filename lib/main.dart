import 'package:counter_app_using_getx/firebase_options.dart';
import 'package:counter_app_using_getx/firestore_notification_manager.dart';
import 'package:counter_app_using_getx/live_score_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireStoreNotificationManager.initialize();
  await FireStoreNotificationManager.getFcmToken();
  FireStoreNotificationManager.onReFreshFcmToken();
  runApp(LiveScoreApp());
}
class LiveScoreApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LiveScoreScreen(),
    );
  }

}

