import 'package:flutter/material.dart';
import 'package:mobile_application/app/sign_in/sign_in_button.dart';
import 'package:mobile_application/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          gapSize(),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
          ),
          gapSize(),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: const Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          gapSize(),
          SignInButton(
            text: 'Sign in with Email',
            color: const Color(0xFF008175),
            textColor: Colors.white,
            onPressed: () {},
          ),
          gapSize(),
          const Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          gapSize(),
          SignInButton(
            text: 'Sign in anonymously',
            color: const Color(0xFFDCE775),
            textColor: Colors.black87,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  SizedBox gapSize() {
    return const SizedBox(height: 8.0);
  }
}
