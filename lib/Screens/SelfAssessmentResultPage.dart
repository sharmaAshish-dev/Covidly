import 'package:covidly/Screens/CovidPreventionPage.dart';
import 'package:covidly/Widgets/Buttons/OutLineButton.dart';
import 'package:covidly/Widgets/Buttons/PrimaryButton.dart';
import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'SelfAssessmentPage.dart';

class SelfAssessmentResultPage extends StatefulWidget {
  final double percentage;

  const SelfAssessmentResultPage({Key key, this.percentage}) : super(key: key);

  @override
  _SelfAssessmentResultPageState createState() => _SelfAssessmentResultPageState();
}

class _SelfAssessmentResultPageState extends State<SelfAssessmentResultPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.teal[50],
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(onTap: () => Navigator.of(context).pop(), child: backButton(borderColor: Colors.blue[500])),
                ),
              ),
              Text(
                "Your Score",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.066, color: LightTheme.greyishBlack, fontWeight: FontWeight.bold),
              ),
              CircularPercentIndicator(
                radius: appSize.width * 0.6,
                lineWidth: 15.0,
                animateFromLastPercent: true,
                backgroundColor: Colors.teal[50],
                animation: true,
                percent: widget.percentage ?? 0.3,
                center: Container(
                  width: appSize.width * 0.523,
                  height: appSize.width * 0.523,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal[50]),
                  child: Center(
                    child: Container(
                      width: appSize.width * 0.3,
                      height: appSize.width * 0.3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                            LightTheme.materialGrey,
                            LightTheme.materialGrey,
                          ]),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                            BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                          ]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (widget.percentage * 100).toStringAsFixed(0).toString() ?? "0.0 %",
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Colors.teal[700]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, left: 4),
                              child: Text(
                                "%",
                                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.teal[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // curve: Curves.linearToEaseOut,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: LightTheme.primaryDarkColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  GetRiskText((widget.percentage * 100).toStringAsFixed(0).toString()),
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.046, color: LightTheme.greyishBlack, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfAssessmentPage(),
                          )),
                      child: PrimaryButton(
                        btnText: "Retake Assessment",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                    child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CovidPreventionPage(),
                            )),
                        child: OutlineBtn(
                          btnText: "View prevention tips",
                        )),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  String GetRiskText(String per) {
    int percentage = int.tryParse(per);

    if (percentage <= 20) {
      print(percentage);
      return 'Your risk of covid 19 is Low';
    } else if (percentage >= 40 && percentage <= 60) {
      print(percentage);
      return 'You may have been exposed to covid 19';
    } else if (percentage > 60 && percentage <= 100) {
      print(percentage);
      return "You have been exposed to covid 19.";
    }

    print(percentage);
    return "No risk";
  }
}
