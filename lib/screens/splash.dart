import 'dart:async';
import 'package:flutter/material.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () async {
      await Navigator.of(context).pushNamedAndRemoveUntil(Routes.start, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color:Colors.amber,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('QUIZ', style: TextStyle(color: Colors.black, fontSize: 28),)
            ],
          )
      ),
    );
  }
}