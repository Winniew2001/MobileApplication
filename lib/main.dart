import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/authentication_view.dart';
import 'package:mobile_application/app/authentication/controller/authentication_controller.dart';
import 'package:mobile_application/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);

    Widget getHome() {
      //if (authenticationState.status == AuthenticationStatus.authenticated) {
      //  return const not_sign-in_or_sign-up;
      //} else if (authenticationState.status == AuthenticationStatus.unauthenticated) {
      //  return const AuthenticationView();
      //} else {
      //  // Like this for now at least
      //  return const AuthenticationView();
      //}

      return const AuthenticationView();
    }

    return MaterialApp(
      title: 'Food',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: getHome(),
    );
  }
}
