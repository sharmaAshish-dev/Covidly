import 'dart:async';

import 'package:covidly/Screens/LoginPage.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'MainScreen.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  double _bottomOffset = 0;
  double _bottomSheetHeight = 0;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 800);
    return new Timer(duration, () {
      setState(() {
        _bottomOffset = MediaQuery.of(context).size.height * 0.3;
        _bottomSheetHeight = MediaQuery.of(context).size.height - _bottomOffset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: LightTheme.primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Transform.translate(
                  offset: Offset(-50, 20),
                  child: Lottie.asset(
                    'assets/lottie/coronavirus_infection.json',
                    repeat: true,
                    reverse: true,
                    animate: true,
                    width: appSize.width,
                  ),
                ),
              ),
              Lottie.asset(
                'assets/lottie/covid_fighting.json',
                repeat: true,
                reverse: true,
                animate: true,
                width: appSize.width,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              width: appSize.width,
              height: _bottomSheetHeight + 20,
              padding: EdgeInsets.all(32),
              curve: Curves.elasticOut,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _bottomOffset, 0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Track Covid-19 with Covidly",
                    style: TextStyle(fontSize: appSize.width * 0.050, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Covid-19 is an infectious disease caused by a new virus that affects health of humans.",
                    style: TextStyle(
                      fontSize: appSize.width * 0.05,
                      color: LightTheme.greyishBlack,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFB40284A),
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                              LightTheme.primaryColor,
                              LightTheme.primaryDarkColor,
                            ]),
                            boxShadow: [
                              BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                              BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                            ]),
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Started",
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white)
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
