import 'dart:ui';

import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class CovidPreventionPage extends StatefulWidget {
  @override
  _CovidPreventionPageState createState() => _CovidPreventionPageState();
}

class _CovidPreventionPageState extends State<CovidPreventionPage> {
  PageController _pageController = PageController();
  double currentIndex = 0.0;

  List<Widget> _preventionTips = [
    preventionTip1(),
    preventionTip2(),
    preventionTip3(),
    preventionTip4(),
    preventionTip5(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index.toDouble();
    });
  }

  void _changePage() {
    setState(() {
      _pageController.jumpTo(currentIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: LightTheme.snowWhite,
      body: Container(
        padding: EdgeInsets.only(top: 50, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(onTap: () => Navigator.of(context).pop(), child: backButton(borderColor: LightTheme.accentColor)),
                  SizedBox(height: 10),
                  Text(
                    "Covid-19",
                    style: TextStyle(fontSize: appSize.width * 0.05, color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Prevention Tips",
                    style: TextStyle(fontSize: appSize.width * 0.06, color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoScrollGlowBehaviour(),
                child: PageView(
                  onPageChanged: _onPageChanged,
                  controller: _pageController,
                  children: _preventionTips,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DotsIndicator(
                dotsCount: _preventionTips.length,
                position: currentIndex,
                decorator: DotsDecorator(
                  activeColor: LightTheme.accentColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(38.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class preventionTip1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular((appSize.width * 0.75) / 2),
              child: Lottie.asset(
                'assets/lottie/wash_hands.json',
                repeat: true,
                reverse: true,
                animate: true,
                width: appSize.width * 0.75,
              ),
            ),
            Column(
              children: [
                Text(
                  "01",
                  style: TextStyle(fontSize: appSize.width * 0.15, color: LightTheme.accentColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  "Wash your hands",
                  style: TextStyle(fontSize: appSize.width * 0.07, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Clean your hands often. Use soup and water, or alcohol-based hand rub.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: appSize.width * 0.04, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class preventionTip2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Transform.scale(
              scale: 1.5,
              child: Lottie.asset(
                'assets/lottie/wear_mask.json',
                repeat: true,
                reverse: true,
                animate: true,
                width: appSize.width * 0.75,
              ),
            ),
            Column(
              children: [
                Text(
                  "02",
                  style: TextStyle(fontSize: appSize.width * 0.15, color: LightTheme.accentColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Wear Mask",
                  style: TextStyle(fontSize: appSize.width * 0.07, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Cover mouth and nose with mask & no gaps between your face and the mask.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: appSize.width * 0.04, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class preventionTip3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Transform.scale(
              origin: Offset(30, 0),
              scale: 2,
              child: Lottie.asset(
                'assets/lottie/face_touch.json',
                repeat: true,
                reverse: true,
                animate: true,
                width: appSize.width * 0.8,
              ),
            ),
            Column(
              children: [
                Text(
                  "03",
                  style: TextStyle(fontSize: appSize.width * 0.15, color: LightTheme.accentColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Avoid touching your face",
                  style: TextStyle(fontSize: appSize.width * 0.07, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Avoid touching your nose, eyes and mouth with unclean hands.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: appSize.width * 0.04, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class preventionTip4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/social_distancing.json',
              repeat: true,
              reverse: true,
              animate: true,
              width: appSize.width,
            ),
            Column(
              children: [
                Text(
                  "04",
                  style: TextStyle(fontSize: appSize.width * 0.15, color: LightTheme.accentColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Keep Social Distancing",
                  style: TextStyle(fontSize: appSize.width * 0.07, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "stay at least 6 feet space between yourself and other people to reduce the spread of coronavirus",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: appSize.width * 0.04, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class preventionTip5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Lottie.asset(
              'assets/lottie/stay_home.json',
              repeat: true,
              reverse: true,
              animate: true,
              width: appSize.width,
            ),
            Column(
              children: [
                Text(
                  "05",
                  style: TextStyle(fontSize: appSize.width * 0.15, color: LightTheme.accentColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Stay At Home",
                  style: TextStyle(fontSize: appSize.width * 0.07, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Try staying at home and avoid going to public places, unless necessary.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: appSize.width * 0.04, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
