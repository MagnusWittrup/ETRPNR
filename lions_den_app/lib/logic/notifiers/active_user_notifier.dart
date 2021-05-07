import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';

import '../../dummy_data.dart';

final activeUserProvider = ChangeNotifierProvider((ref) => ActiveUserNotifer());

class ActiveUserNotifer extends ChangeNotifier {
  ActiveUserNotifer();
  DummyUser user = DummyUser();

  void reset() {
    user = DummyUser();

    notifyListeners();
  }

  void update(DummyUser data) {
    user = user.copyWith(orig: user, data: data);
    notifyListeners();
  }
}
