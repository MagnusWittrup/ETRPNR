import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/swipe_notifier.dart';
import 'package:lions_den_app/logic/notifiers/users_notifer.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../dummy_data.dart';

class DraggableCard extends StatefulWidget {
  final User user;
  final Widget child;
  const DraggableCard({
    @required this.child,
    @required this.user,
  });

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with AnimationMixin {
  AnimationController _controller;

  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment> _alignmentAnimation;

  Animation<double> translateX;

  void _runAnimationNeutral(Offset pixelsPerSecond, Size size) {
    _alignmentAnimation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    // evaluating velocity
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 100,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  Future<void> _runAnimationTranslate(Size size, bool isAccepting) async {
    translateX = 0.0
        .tweenTo(isAccepting ? size.width : -size.width)
        .animatedBy(controller);

    await controller.play(duration: Duration(milliseconds: 150)).then((value) {
      if (isAccepting) {
        context.read(userListProvider.notifier).accept(widget.user);
      }
      context.read(userListProvider.notifier).remove(widget.user);
      controller.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _alignmentAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        final threshhold = size.width * 0.35;
        setState(() {
          if (details.globalPosition.dx < size.width / 2 - threshhold) {
            context.read(swipeStateProvider.notifier).decline(widget.user);
          } else if (details.globalPosition.dx > size.width / 2 + threshhold) {
            context.read(swipeStateProvider.notifier).accept(widget.user);
          } else {
            context.read(swipeStateProvider.notifier).reset();
          }

          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 4.5),
            details.delta.dy / (size.height / 4.5),
          );
        });
      },
      onPanEnd: (details) {
        final swipeState = context.read(swipeStateProvider);

        if (swipeState is! SwipeStateNeutral) {
          if (swipeState is SwipeStateAccept) {
            if (widget.user.hasAcceptedMe) {
              debugPrint('ITS A MATCH!');
            }

            _runAnimationTranslate(size, true);
          } else {
            _runAnimationTranslate(size, false);
          }
          // context.read(userListProvider.notifier).remove(widget.user);
        } else {
          _runAnimationNeutral(details.velocity.pixelsPerSecond, size);
        }
      },
      child: Transform(
        transform: Matrix4.translationValues(translateX?.value ?? 0, 0, 0),
        child: Align(
          alignment: _dragAlignment,
          child: widget.child,
        ),
      ),
    );
  }
}
