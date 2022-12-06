import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/*
 * Loading animation for when user is waiting to sign in.
 */
class LoadingSheet extends StatelessWidget {
  const LoadingSheet._({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(48),
        ),
      ),
      context: context,
      builder: (_) => const LoadingSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.blueGrey.shade700,
          size: 80,
        ),
      ),
    );
  }
}
