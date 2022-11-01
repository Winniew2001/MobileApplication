import 'package:flutter/material.dart';
import 'package:mobile_application/app/sign_in/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food',
      theme: ThemeData(
          primarySwatch: Colors.purple
      ),
      home: SignInPage(),
    );
  }
}
