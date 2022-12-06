import 'package:flutter/material.dart';

/*
 * Slide fade animation for switching between sign up and sign in pages.
 */
class SlideFadeSwitcher extends StatelessWidget {
  final Widget child;

  const SlideFadeSwitcher({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: ((child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(animation);
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(
              0.5,
              1.0,
            ),
          ),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      }),
      child: child,
    );
  }
}
