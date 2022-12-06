import 'package:flutter/material.dart';
import 'package:mobile_application/app/model/form_values.dart';

/*
 * Resizing textfield for long string inputs.
 */
class InstructionForm extends StatefulWidget {
  final FormValues formValues;

  const InstructionForm(
      {Key? key, required this.onUpdate, required this.formValues})
      : super(key: key);

  final ValueChanged<String> onUpdate;

  @override
  InstructionFormState createState() => InstructionFormState();
}

class InstructionFormState extends State<InstructionForm> {
  TextEditingController instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    instructionController.text = widget.formValues.instructions;
    return SizedBox(
      width: 360,
      child: TextField(
        controller: instructionController,
        decoration: const InputDecoration(
          labelText: 'Enter Instructions',
        ),
        maxLines: 10,
        minLines: 1,
        onChanged: (value) {
          widget.onUpdate(value);
        },
      ),
    );
  }
}
