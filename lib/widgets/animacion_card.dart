import 'package:flutter/material.dart';

class AnimacionCard extends StatelessWidget {
  final Widget child;
  final int index;

  const AnimacionCard({super.key, required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 100),
      builder: (context, value, widget) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: widget,
          ),
        );
      },
      child: child,
    );
  }
}
