import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dummy_data.dart';

final swipeStateProvider =
    StateNotifierProvider<SwipeStateNotifier, SwipeState>((ref) {
  return SwipeStateNotifier();
});

class SwipeStateNotifier extends StateNotifier<SwipeState> {
  SwipeStateNotifier() : super(const SwipeStateNeutral());

  void reset() => state = const SwipeStateNeutral();
  void accept(User activeuser) => state = SwipeStateAccept(activeuser);
  void decline(User activeuser) => state = SwipeStateDecline(activeuser);
}

abstract class SwipeState {
  const SwipeState();
  @override
  String toString() {
    return 'SwipeState()';
  }
}

class SwipeStateNeutral extends SwipeState {
  const SwipeStateNeutral();
  @override
  String toString() {
    return 'SwipeStateNeutral()';
  }
}

class SwipeStateAccept extends SwipeState {
  final User activeUser;
  const SwipeStateAccept(this.activeUser);
  @override
  String toString() {
    return 'SwipeStateAccept()';
  }
}

class SwipeStateDecline extends SwipeState {
  final User activeUser;
  const SwipeStateDecline(this.activeUser);
  @override
  String toString() {
    return 'SwipeStateDecline()';
  }
}
