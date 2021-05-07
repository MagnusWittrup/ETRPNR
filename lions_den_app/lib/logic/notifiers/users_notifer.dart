import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';

import '../../dummy_data.dart';

final userListProvider =
    ChangeNotifierProvider((ref) => DummyUserListNotifer(ref));

class DummyUserListNotifer extends ChangeNotifier {
  final ProviderReference ref;
  DummyUserListNotifer(this.ref);
  final users = DummyData().dummyUsers;

  void reset() {
    users.clear();
    users.addAll(DummyData().dummyUsers);

    notifyListeners();
  }

  void accept(DummyUser user) {
    final foundDummyUser = users.firstWhere((element) => element == user);
    foundDummyUser.isAcceptedByMe = true;
    if (foundDummyUser.isAcceptedByMe && foundDummyUser.hasAcceptedMe) {
      ref.read(acceptedDummyUserListProvider.notifier).add(user);
    }
    notifyListeners();
  }

  void remove(DummyUser user) {
    users.remove(user);

    notifyListeners();
  }
}

abstract class DummyUserListState {}

class DummyUserListDummyUsers extends DummyUserListState {
  final DummyUser user;
  DummyUserListDummyUsers(this.user);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DummyUserListDummyUsers && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
