import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dummy_data.dart';

final acceptedUserListProvider =
    ChangeNotifierProvider((ref) => AcceptedUserListNotifer());

class AcceptedUserListNotifer extends ChangeNotifier {
  AcceptedUserListNotifer();
  final List<User> acceptedUsers = [];
  List<User> tempList = [];

  void add(User user) {
    if (acceptedUsers.where((element) => element == user).isNotEmpty) return;

    acceptedUsers.insert(0, user);

    notifyListeners();
  }

  void reset() {
    debugPrint(tempList.toString());
    acceptedUsers.clear();
    acceptedUsers.addAll(tempList);

    notifyListeners();
  }

  void filter(String searchInput) {
    tempList = acceptedUsers;
    debugPrint(tempList.toString());
    reset();
    acceptedUsers.clear();
    acceptedUsers.addAll(acceptedUsers
        .where((element) =>
            element.fullName.toLowerCase().contains(searchInput.toLowerCase()))
        .toList());

    notifyListeners();
  }
}
