import 'package:flutter/material.dart';

/*
 * Widget to create space between other widgets.
 */
class SmallSizedBox extends StatelessWidget {
  const SmallSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 10
    );
  }
}
