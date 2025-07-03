import 'package:firebase_messaging/firebase_messaging.dart';

class FireStoreNotificationManager {
  static Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission();
    //background message
    FirebaseMessaging.onMessageOpenedApp.listen(_onsentmessage);
    //foreground message
    FirebaseMessaging.onMessage.listen(_onsentmessage);
    //terminated
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }

  static void _onsentmessage(RemoteMessage message) {
    print(message.data);
    print(message.notification?.title);
    print(message.notification?.body);
  }

  static Future<String?> getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FcmToken: $token");
    return token;
  }

  static void onReFreshFcmToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((String newToken){
      print("OnRefreshFcmtoken: $newToken");
    });
  }
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print('Got a new Message');
}