import 'dart:async';

import 'package:covidly/uTils/FadeRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'file:///D:/Programming/Flutter/covidly/lib/Screens/walkThroughPage.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100.0),
          child: Lottie.asset(
            'assets/lottie/covid_loading.json',
            repeat: false,
            reverse: false,
            animate: true,
          ),
        ),
      ),
    );
  }

  startTime() async {
    var duration = new Duration(milliseconds: 3500);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        // context, FadeRoute(builder: (context) => LoginPage()));
        context,
        FadeRoute(builder: (context) => WalkThrough()));
  }
}
