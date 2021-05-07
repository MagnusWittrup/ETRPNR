import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dummy_data.dart';

final swipeStateProvider =
    StateNotifierProvider<SwipeStateNotifier, SwipeState>((ref) {
  return SwipeStateNotifier();
});

class SwipeStateNotifier extends StateNotifier<SwipeState> {
  SwipeStateNotifier() : super(const SwipeStateNeutral());

  void reset() => state = const SwipeStateNeutral();
  void accept(DummyUser activeuser) => state = SwipeStateAccept(activeuser);
  void decline(DummyUser activeuser) => state = SwipeStateDecline(activeuser);
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
  final DummyUser activeDummyUser;
  const SwipeStateAccept(this.activeDummyUser);
  @override
  String toString() {
    return 'SwipeStateAccept()';
  }
}

class SwipeStateDecline extends SwipeState {
  final DummyUser activeDummyUser;
  const SwipeStateDecline(this.activeDummyUser);
  @override
  String toString() {
    return 'SwipeStateDecline()';
  }
}
