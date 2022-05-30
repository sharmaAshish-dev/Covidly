import 'package:covidly/Screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covidly App",
      theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
        Theme.of(context).textTheme,
      )),
      debugShowCheckedModeBanner: false,
      home: Scaffold(resizeToAvoidBottomInset: false, body: splashScreen()
          // body: MainScreen()
          // body: LineChartSample1()
          ),
    );
  }
}
