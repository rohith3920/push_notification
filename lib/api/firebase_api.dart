import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/main.dart';

class FirebaseApi {
  // create an instance of firebase Messaging

  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications

  Future<void> initNotifications() async {
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    // fetch the fcm token for this device

    final fcmToken = await _firebaseMessaging.getToken();
    // print the token (normally you would send this to your server)

    print('the token of the fcm $fcmToken');
  }

  // function to handle received messages

  void handleMessage(RemoteMessage? message) {
    // if the message is null, do nothing

    if (message == null) return;

    // navigate to new screen when messqage is received and user taps notification

    navigatorKey.currentState?.pushNamed(
      '/notification_page',
      arguments: message,
    );
  }

  // function to initialize foreground and background settings

  Future initPushNotification() async {
    // handle notification if the app was terminated and now opened

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // attach event listeners for when a notification opens the app

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
