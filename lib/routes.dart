import 'package:appfox_test/screens/quiz.dart';
import 'package:appfox_test/screens/result.dart';
import 'package:appfox_test/screens/splash.dart';
import 'package:appfox_test/screens/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes{
  Routes._();

  static const String splash = '/splash';
  static const String result = '/result';
  static const String start = '/start';
  static const String quiz = '/quiz';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    start: (BuildContext context) => StartScreen(),
    //result: (BuildContext context) => ResultScreen(),
    //quiz: (BuildContext context) => QuizScreen()
  };

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings == null) return null;
    if (settings.name == '/') return null;

    Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      quiz: (context) => QuizScreen(argument: settings.arguments),
      result: (context) => ResultScreen(argument: settings.arguments),
    };

    WidgetBuilder builder = routes[settings.name];
    return MaterialPageRoute(builder: (ctx) => builder(ctx));
  }
}