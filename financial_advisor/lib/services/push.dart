import 'package:firebase_messaging/firebase_messaging.dart';

class PushService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  init() {
    _firebaseMessaging.requestNotificationPermissions();
    printToken();
  }

  printToken(){
    _firebaseMessaging.getToken().then((token) {
      print('----------------');
      print(token);
      print('----------------');
    });
  }
}
