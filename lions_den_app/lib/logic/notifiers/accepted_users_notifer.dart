import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dummy_data.dart';

final acceptedDummyUserListProvider =
    ChangeNotifierProvider((ref) => AcceptedDummyUserListNotifer());

class AcceptedDummyUserListNotifer extends ChangeNotifier {
  AcceptedDummyUserListNotifer();
  final List<DummyUser> acceptedDummyUsers = [];
  List<DummyUser> tempList = [];

  void add(DummyUser user) {
    if (acceptedDummyUsers.where((element) => element == user).isNotEmpty)
      return;

    acceptedDummyUsers.insert(0, user);

    notifyListeners();
  }

  void reset() {
    debugPrint(tempList.toString());
    acceptedDummyUsers.clear();
    acceptedDummyUsers.addAll(tempList);

    notifyListeners();
  }

  void filter(String searchInput) {
    tempList = acceptedDummyUsers;
    debugPrint(tempList.toString());
    reset();
    acceptedDummyUsers.clear();
    acceptedDummyUsers.addAll(acceptedDummyUsers
        .where((element) =>
            element.fullName.toLowerCase().contains(searchInput.toLowerCase()))
        .toList());

    notifyListeners();
  }
}
