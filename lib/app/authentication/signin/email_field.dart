import 'package:flutter/material.dart';

import '../../components/text_input_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      hintText: "Email",
      onChanged: (_) {},
    );
  }
}
