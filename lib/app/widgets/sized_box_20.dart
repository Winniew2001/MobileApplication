import 'package:flutter/material.dart';

/*
 * Widget to create space between other widgets.
 */
class MediumSizedBox extends StatelessWidget {
  const MediumSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20
    );
  }
}
