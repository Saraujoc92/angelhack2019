import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_advisor/services/auth.dart';
import 'package:financial_advisor/services/push.dart';

class ProfileService {
  final Firestore _fireStore = Firestore.instance;

  Future<DocumentReference> _profile() async {
    var user = await Auth.user;
    return _fireStore.collection('Users').document(user.uid);
  }

  Future<DocumentSnapshot> get profile async {
    var profile = await _profile();
    return profile.get();
  }

  init() {
    _profile().then(
      (profile) => profile.setData({
        'income': null,
        'alerts': false,
        'alertpercent': 0.5,
        'payments': []
      }),
    );
  }

  reset() {
    init();
  }

  set income(double income) {
    _profile().then(
      (profile) => profile.updateData({'income': income.toStringAsFixed(0)}),
    );
  }

  set alerts(bool alerts) {
    _profile().then(
      (profile) => profile.updateData({'alerts': alerts}),
    );
  }

  set alertPercentage(double percent) {
    _profile().then(
      (profile) => profile.updateData({'alertpercent': percent}),
    );
  }

  set payments(List<double> payments) {
    _profile().then(
      (profile) => profile.updateData({'payments': payments}),
    );
  }
}
