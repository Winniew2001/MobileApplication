import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/authentication_page.dart';
import 'package:mobile_application/app/authentication/controller/authentication_controller.dart';
import 'package:mobile_application/app/pages/all_recipes_page.dart';
import 'package:mobile_application/app/pages/new_recipe_page.dart';
import 'package:mobile_application/app/pages/select_recipe_image.dart';
import 'package:mobile_application/app/storage/firebase_storage/storage_view.dart';
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
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        //return NewRecipePage(pageTitle: "NEW RECIPE");
        print(authenticationState.user.id);
        return AllRecipesPage();
      } else if (authenticationState.status == AuthenticationStatus.unauthenticated) {
        print(authenticationState.user.id);
        return AuthenticationPage();
      } else {
        // Like this for now at least
        return AuthenticationPage();
      }
    }

    return MaterialApp(
      title: 'Food',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: getHome(),
    );
  }
}
