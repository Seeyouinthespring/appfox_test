import 'package:appfox_test/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'AppFoxTest',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: Routes.routes,
      initialRoute: Routes.splash,
    );
  }
}