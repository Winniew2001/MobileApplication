import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/authentication/forgot_password/forgot_password_view.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (_) => ForgotPasswordView(),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password",
            style: TextStyle(
              color: Color(0xFF6574FF),
            ),
          ),
        ),
      ),
    );
  }
}
