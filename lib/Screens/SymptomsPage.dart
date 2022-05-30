import 'dart:ui';

import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: EdgeInsets.only(left: 20),
        child: ScrollConfiguration(
          behavior: NoScrollGlowBehaviour(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(onTap: () => Navigator.of(context).pop(), child: backButton(borderColor: Colors.blue[500])),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Covid-19",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.078, color: LightTheme.greyishBlack),
                          ),
                          Text(
                            "Symptoms",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.096, fontWeight: FontWeight.w600, color: LightTheme.black),
                          ),
                          Text(
                            "These symptoms may appear 2-14 days \nafter exposure.",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.028, fontWeight: FontWeight.w400, color: LightTheme.greyishBlack),
                          ),
                        ],
                      ),
                      Stack(children: [
                        Opacity(child: Image.asset('assets/images/doctor.png', height: MediaQuery.of(context).size.height * 0.26, color: Colors.black), opacity: 0.28),
                        ClipRect(
                            child:
                                BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), child: Image.asset('assets/images/doctor.png', height: MediaQuery.of(context).size.height * 0.26)))
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                Colors.blue.shade200,
                                Colors.blue.shade300,
                                Colors.blue[700],
                                Colors.blue[900],
                              ]),
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              boxShadow: [
                                BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset('assets/images/infected.png', height: 180),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Information",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.06),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Covid-19 infected people will develop mild to moderate illness and can recover without hospitalization.",
                                      style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.034),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () => _launchURL(
                                          "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/question-and-answers-hub/q-a-detail/coronavirus-disease-covid-19#:~:text=symptoms"),
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                        child: Text(
                                          'Learn More',
                                          style: TextStyle(
                                            color: Colors.white,
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
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Most common symptoms:",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056, color: LightTheme.black),
                      ),
                      Container(
                        height: 245,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                // ignore: missing_return
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(
                                        symptomName: "Fever",
                                        symptomImagePath: 'assets/images/symptoms/fever.png',
                                      ),
                                    );
                                  }

                                  if (index == 1) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(symptomName: "Dry cough", symptomImagePath: 'assets/images/symptoms/cough.png'),
                                    );
                                  }

                                  if (index == 2) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(symptomName: "Tiredness", symptomImagePath: 'assets/images/symptoms/tiredness.png'),
                                    );
                                  }
                                },
                                itemCount: 3),
                          ),
                        ),
                      ),
                      Text(
                        "Less common symptoms:",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056, color: LightTheme.black),
                      ),
                      Container(
                        height: 245,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                SymptomCard(symptomName: 'Body Pain', symptomImagePath: 'assets/images/symptoms/pain.png'),
                                SizedBox(width: 20),
                                SymptomCard(
                                  symptomName: 'Sore throat',
                                  symptomImagePath: 'assets/images/symptoms/sore_throat.png',
                                ),
                                SizedBox(width: 20),
                                SymptomCard(symptomName: 'Diarrhoea', symptomImagePath: 'assets/images/symptoms/stomach_pain.png'),
                                SizedBox(width: 20),
                                SymptomCard(symptomName: 'Headache', symptomImagePath: 'assets/images/symptoms/headache.png'),
                                SizedBox(width: 20),
                                SymptomCard(
                                  symptomName: 'No Smell',
                                  symptomImagePath: 'assets/images/symptoms/loss_smell.png',
                                ),
                                SizedBox(width: 20),
                                SymptomCard(
                                  symptomName: 'Skin rash',
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Serious symptoms:",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056, color: LightTheme.black),
                      ),
                      Container(
                        height: 245,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                // ignore: missing_return
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(
                                        symptomName: "Short Breath",
                                        symptomImagePath: 'assets/images/symptoms/short_breathes.png',
                                      ),
                                    );
                                  }

                                  if (index == 1) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(symptomName: "Chest Pain", symptomImagePath: 'assets/images/symptoms/chest_pain.png'),
                                    );
                                  }

                                  if (index == 2) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SymptomCard(symptomName: "No Speech", symptomImagePath: 'assets/images/symptoms/no_speech.png'),
                                    );
                                  }
                                },
                                itemCount: 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  String symptomName;
  String symptomImagePath;

  SymptomCard({this.symptomName, this.symptomImagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
              Color(0xffffffff),
              Color(0xffffffff),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
              BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                symptomName ?? "Symptom",
                style: TextStyle(fontSize: 20, color: LightTheme.greyishBlack),
              ),
            ),
            Image.asset(symptomImagePath ?? 'assets/images/symptoms/fever.png', height: 140)
          ],
        ),
      ),
    );
  }
}
