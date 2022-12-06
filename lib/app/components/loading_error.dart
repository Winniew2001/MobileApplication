import 'package:flutter/cupertino.dart';

/*
 * Display an error dialog.
 */
class ErrorDialog extends StatelessWidget {
  final String error;

  const ErrorDialog._(this.error, {Key? key}) : super(key: key);

  static Future<void> show(BuildContext context, String errorMessage) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => ErrorDialog._(errorMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(error),
      actions: [
        CupertinoDialogAction(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
