import 'package:firebase_messaging/firebase_messaging.dart';

class PushService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  init() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('----------------');
      print(token);
      print('----------------');
    });
  }
}
