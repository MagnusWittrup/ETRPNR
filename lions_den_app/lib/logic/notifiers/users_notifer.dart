import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';

import '../../dummy_data.dart';

final userListProvider = ChangeNotifierProvider((ref) => UserListNotifer(ref));

class UserListNotifer extends ChangeNotifier {
  final ProviderReference ref;
  UserListNotifer(this.ref);
  final users = DummyData().dummyUsers;

  void reset() {
    users.clear();
    users.addAll(DummyData().dummyUsers);

    notifyListeners();
  }

  void accept(User user) {
    final foundUser = users.firstWhere((element) => element == user);
    foundUser.isAcceptedByMe = true;
    if (foundUser.isAcceptedByMe && foundUser.hasAcceptedMe) {
      ref.read(acceptedUserListProvider.notifier).add(user);
    }
    notifyListeners();
  }

  void remove(User user) {
    users.remove(user);

    notifyListeners();
  }
}

abstract class UserListState {}

class UserListUsers extends UserListState {
  final User user;
  UserListUsers(this.user);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserListUsers && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
