import 'package:flutter/material.dart';

/*
 * Widget for displaying that there are no current recipes saved.
 */
class EmptyWarning extends StatelessWidget {
  final String warningText;
  const EmptyWarning({Key? key, required this.warningText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        const Icon(
          Icons.warning,
          color: Colors.grey,
          size: 50,
        ),
        Text(
          warningText,
          style: const TextStyle(
              color: Colors.grey
          ),
        ),
      ],
    );
  }
}
