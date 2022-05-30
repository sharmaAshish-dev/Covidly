import 'dart:core';
import 'dart:ui';

import 'package:covidly/Screens/SelfAssessmentResultPage.dart';
import 'package:covidly/Widgets/Buttons/OutLineButton.dart';
import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/uTils/FadeRoute.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PageController _cardController;
List<bool> positiveAnswer = [];
List<bool> negativeAnswer = [];

class SelfAssessmentPage extends StatefulWidget {
  const SelfAssessmentPage({Key key}) : super(key: key);

  @override
  _SelfAssessmentPageState createState() => _SelfAssessmentPageState();
}

class _SelfAssessmentPageState extends State<SelfAssessmentPage> {
  int currentQuestion = 0;

  List<QuestionCard> questionnaire = [
    QuestionCard(
      currentQuestionNumber: 1,
      question: 'Have you been tested for the coronavirus (awaiting results)? If yes, stay home until results are received',
    ),
    QuestionCard(
      currentQuestionNumber: 2,
      question: 'Have you tested POSITIVE for the coronavirus? If yes, stay home for 14 days after symptoms are gone.',
    ),
    QuestionCard(
      currentQuestionNumber: 3,
      question: 'Have you had prolonged close contact with someone who tested positive for the coronavirus? If Yes, stay home for 14 days and return to work if no symptoms.',
    ),
    QuestionCard(
      currentQuestionNumber: 4,
      question: 'Has a member of your household been tested for the coronavirus (awaiting results)? If Yes, stay home until results are received.',
    ),
    QuestionCard(
      currentQuestionNumber: 5,
      question: 'Has a member of your household been asked by a medical professional to isolate for potential coronavirus? If Yes, stay home pending results.',
    ),
    QuestionCard(
      currentQuestionNumber: 6,
      question: 'Has a household member had prolonged close contact with someone who tested positive for the coronavirus? If Yes, stay home for 14 days and return to work if there are NO symptoms.',
    ),
    QuestionCard(
      currentQuestionNumber: 7,
      question: 'Have you traveled out of the country within the last 14 days? If Yes, stay home for 14 days from your arrival back to the United States. Return to work if there are no symptoms.',
    ),
    QuestionCard(
      currentQuestionNumber: 8,
      question: 'Have you taken a cruise within the last 14 days? If Yes, stay home for 14 days from your arrival back to the United States. Return to work if there are no symptoms.',
    ),
    QuestionCard(
      currentQuestionNumber: 9,
      question: 'Are you experiencing or have you experienced any symptoms in the past 14 days ?',
    ),
    QuestionCard(
      currentQuestionNumber: 10,
      question: 'Are you experiencing or have you experienced Cough (not related to allergies)',
    ),
    QuestionCard(
      currentQuestionNumber: 11,
      question: 'Are you experiencing or have you experienced Shortness of breath',
    ),
    QuestionCard(
      currentQuestionNumber: 12,
      question: 'Are you experiencing or have you experienced Difficulty breathing',
    ),
    QuestionCard(
      currentQuestionNumber: 13,
      question: 'Are you experiencing or have you experienced Fever',
    ),
    QuestionCard(
      currentQuestionNumber: 14,
      question: 'Are you experiencing or have you experienced Chills',
    ),
    QuestionCard(
      currentQuestionNumber: 15,
      question: 'Are you experiencing or have you experienced Repeated shaking with chills',
    ),
    QuestionCard(currentQuestionNumber: 16, question: 'Are you experiencing or have you experienced Muscle pain'),
    QuestionCard(currentQuestionNumber: 17, question: 'Are you experiencing or have you experienced Experiencing any loss of taste or smell'),
    QuestionCard(
      currentQuestionNumber: 18,
      question: 'Are you experiencing or have you experienced Sore throat or headache',
    ),
  ];

  @override
  void initState() {
    _cardController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _cardController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(onTap: () => Navigator.pop(context), child: backButton(borderColor: LightTheme.accentColor)),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Covid-19",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.060, color: LightTheme.greyishBlack),
                          ),
                          Text(
                            "Self Assessment\nTest",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.066, fontWeight: FontWeight.w600, color: LightTheme.black),
                          ),
                        ],
                      ),
                      Image.asset('assets/images/ic_test.png', height: MediaQuery.of(context).size.height * 0.20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Question " + (currentQuestion + 1).toString(),
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.066, color: LightTheme.greyishBlack, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "/" + questionnaire.length.toString(),
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050, color: LightTheme.greyishBlack, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 1,
              ),
              Expanded(
                child: Container(
                  width: appSize.width,
                  child: ScrollConfiguration(
                    behavior: NoScrollGlowBehaviour(),
                    child: PageView(
                      pageSnapping: false,
                      children: questionnaire,
                      controller: _cardController,
                      allowImplicitScrolling: false,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          currentQuestion = currentQuestion + 1;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final int currentQuestionNumber;
  final String question;

  const QuestionCard({Key key, this.question, this.currentQuestionNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
              LightTheme.snowWhite,
              LightTheme.snowWhite,
            ]),
            border: Border.all(color: LightTheme.accentColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
              BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                question,
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.050, color: LightTheme.black, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          positiveAnswer.add(true);
                          if (currentQuestionNumber == 18) {
                            Navigator.pushReplacement(
                                context,
                                FadeRoute(
                                  builder: (context) => SelfAssessmentResultPage(
                                    percentage: calculatePercentage(18, positiveAnswer.length),
                                  ),
                                ));
                          }
                          _cardController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.fastLinearToSlowEaseIn);
                        },
                        child: OutlineBtn(
                          btnText: "Yes",
                          btnColor: Colors.greenAccent[100].withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          negativeAnswer.add(false);
                          if (currentQuestionNumber == 18) {
                            Navigator.pushReplacement(
                                context,
                                FadeRoute(
                                  builder: (context) => SelfAssessmentResultPage(
                                    percentage: calculatePercentage(18, positiveAnswer.length),
                                  ),
                                ));
                          }
                          _cardController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
                        },
                        child: OutlineBtn(
                          btnText: "No",
                          btnColor: Colors.red[100].withOpacity(0.8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculatePercentage(int totalQuestion, int positiveAnswers) {
    return (positiveAnswers / totalQuestion);
  }
}
