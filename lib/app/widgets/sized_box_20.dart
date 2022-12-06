import 'package:flutter/material.dart';

/*
 * Widget to create space between other widgets.
 */
class MediumSizedBox extends StatelessWidget {
  const MediumSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adding const breaks the app
    // ignore: prefer_const_constructors
    return SizedBox(
        height: 20
    );
  }
}
