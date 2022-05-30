import 'dart:async';
import 'dart:convert';

import 'package:covidly/Screens/SearchCountryPage.dart';
import 'package:covidly/Screens/SymptomsPage.dart';
import 'package:covidly/Screens/countryDetailPage.dart';
import 'package:covidly/Screens/covidInfoScreens/infoScreen1.dart';
import 'package:covidly/Screens/covidInfoScreens/infoScreen2.dart';
import 'package:covidly/Widgets/Buttons/tabButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/Widgets/common/CountryCard.dart';
import 'package:covidly/Widgets/errorScreens/Something_went_wrong.dart';
import 'package:covidly/Widgets/loadings/CustomLoadingDialog.dart';
import 'package:covidly/uTils/constAPIUrl.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:intl/intl.dart";
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

int _totalAffectedCases = 0;
int _totalDeadCases = 0;
int _totalRecoveredCases = 0;
int _totalActiveCases = 0;

int _usaCount = 0;
int _indiaCount = 0;
int _brazilCount = 0;
int _franceCount = 0;
int _turkeyCount = 0;
int _russiaCount = 0;

String usaSlug;
String indiaSlug;
String brazilSlug;
String franceSlug;
String turkeySlug;
String russiaSlug;

dynamic globalData;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  bool isDataLoaded = false;
  bool isTab1 = true;
  bool isTab2 = false;
  bool isTab3 = false;

  double currentInfoIndex = 0;

  Future getGlobalCountryData() async {
    var url = apiUrl.baseUrl + "summary";
    var response = await http.get(Uri.parse(url));
    dynamic data = jsonDecode(response.body);

    _totalAffectedCases = data['Global']['TotalConfirmed'];
    _totalDeadCases = data['Global']['TotalDeaths'];
    _totalRecoveredCases = data['Global']['TotalRecovered'];
    _totalActiveCases = _totalAffectedCases - (_totalDeadCases + _totalRecoveredCases);

    isDataLoaded = true;

    return data;
  }

  @override
  void initState() {
    super.initState();
    globalData = getGlobalCountryData();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentInfoIndex = index.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    String txtPercentage;

    Future<void> refresh() async {
      setState(() {
        globalData = getGlobalCountryData();
      });
    }

    Widget homeContent(context, snapshot) {
      double setProgress(int total, {int active, int dead, int recovered}) {
        double percentage = 0.0;

        if (isTab1) {
          percentage = (active / total) * 100;
        } else if (isTab2) {
          percentage = (dead / total) * 100;
        } else if (isTab3) {
          percentage = (recovered / total) * 100;
        }
        txtPercentage = percentage.toStringAsFixed(1) + "%";
        return percentage / 100;
      }

      List<Widget> _infoScreens = [
        infoScreen1(),
        infoScreen2(),
      ];

      return RefreshIndicator(
        onRefresh: refresh,
        child: ScrollConfiguration(
          behavior: NoScrollGlowBehaviour(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Container(
                child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    height: 210,
                    child: Stack(
                      children: [
                        PageView(
                          controller: _pageController,
                          // scrollDirection: Axis.vertical,
                          children: _infoScreens,
                          onPageChanged: _onPageChanged,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicator(
                            dotsCount: _infoScreens.length,
                            position: currentInfoIndex,
                            decorator: DotsDecorator(
                              activeColor: Colors.teal[500],
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                  LightTheme.materialGrey,
                                  LightTheme.materialGrey,
                                ]),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                  BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                ]),
                            child: CircularPercentIndicator(
                              radius: 150.0,
                              lineWidth: 12.0,
                              animateFromLastPercent: true,
                              backgroundColor: Colors.teal[50],
                              animation: true,
                              percent: setProgress(_totalAffectedCases, active: _totalActiveCases, dead: _totalDeadCases, recovered: _totalRecoveredCases),
                              center: Container(
                                width: 126,
                                height: 126,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal[50]),
                                child: Center(
                                  child: Container(
                                    width: 70,
                                    height: 70,
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
                                      child: Text(
                                        txtPercentage ?? "0.0 %",
                                        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.teal[700]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // curve: Curves.linearToEaseOut,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: LightTheme.primaryDarkColor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Affected(),
                              (isTab1
                                  ? ActiveCases()
                                  : isTab2
                                      ? DeadCases()
                                      : isTab3
                                          ? RecoveredCases()
                                          : Container())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isTab1 = true;
                                isTab2 = false;
                                isTab3 = false;
                              });
                            },
                            child: TabButton(tabName: "Active Cases", isSelected: isTab1)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isTab1 = false;
                                isTab2 = true;
                                isTab3 = false;
                              });
                            },
                            child: TabButton(tabName: "Dead", isSelected: isTab2)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isTab1 = false;
                                isTab2 = false;
                                isTab3 = true;
                              });
                            },
                            child: TabButton(tabName: "Recovered", isSelected: isTab3)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Countries",
                          style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.w800, fontSize: appSize.width * 0.06),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchCountryPage())),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                  LightTheme.materialGrey,
                                  LightTheme.materialGrey,
                                ]),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                  BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Search",
                                  style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(CupertinoIcons.search, color: Colors.teal[900]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 250,
                    child: ScrollConfiguration(
                      behavior: NoScrollGlowBehaviour(),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            for (int i = 0; i < snapshot.data['Countries'].length; i++) {
                              String temp = snapshot.data['Countries'][i]['CountryCode'];

                              switch (temp) {
                                case 'US':
                                  _usaCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  usaSlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                                case 'IN':
                                  _indiaCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  indiaSlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                                case 'BR':
                                  _brazilCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  brazilSlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                                case 'FR':
                                  _franceCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  franceSlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                                case 'TR':
                                  _turkeyCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  turkeySlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                                case 'RU':
                                  _russiaCount = snapshot.data['Countries'][i]['TotalConfirmed'];
                                  russiaSlug = snapshot.data['Countries'][i]['Slug'];
                                  break;
                              }
                            }

                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                            countrySlug: usaSlug,
                                            countryName: "USA",
                                            totalCases: _usaCount,
                                            pageColor: LightTheme.primaryColor,
                                            flagPath: 'assets/images/flags/usa_flag.jpg',
                                            fromSearch: false,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Colors.teal[500],
                                    cardName: "USA",
                                    flagImageString: 'assets/images/flags/usa_flag.jpg',
                                    totalCases: formatNumber(_usaCount),
                                  ),
                                ),
                              );
                            }
                            if (index == 1) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                          countrySlug: indiaSlug,
                                          countryName: "India",
                                          totalCases: _indiaCount,
                                          flagPath: 'assets/images/flags/indian_flag.jpg',
                                          fromSearch: false,
                                          pageColor: Color(0xffff8000))));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Color(0xffff8000),
                                    cardName: "India",
                                    flagImageString: 'assets/images/flags/indian_flag.jpg',
                                    totalCases: formatNumber(_indiaCount),
                                  ),
                                ),
                              );
                            }
                            if (index == 2) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                          countrySlug: brazilSlug,
                                          countryName: "Brazil",
                                          totalCases: _brazilCount,
                                          flagPath: 'assets/images/flags/brazilian_flag.jpg',
                                          fromSearch: false,
                                          pageColor: Colors.yellow[700])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Colors.yellow[700],
                                    cardName: "Brazil",
                                    flagImageString: 'assets/images/flags/brazilian_flag.jpg',
                                    totalCases: formatNumber(_brazilCount),
                                  ),
                                ),
                              );
                            }
                            if (index == 3) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                          countrySlug: franceSlug,
                                          countryName: "France",
                                          totalCases: _franceCount,
                                          flagPath: 'assets/images/flags/france_flag.jpg',
                                          fromSearch: false,
                                          pageColor: Colors.blue[500])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Colors.blue[500],
                                    cardName: "France",
                                    flagImageString: 'assets/images/flags/france_flag.jpg',
                                    totalCases: formatNumber(_franceCount),
                                  ),
                                ),
                              );
                            }
                            if (index == 4) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                          countrySlug: turkeySlug,
                                          countryName: "Turkey",
                                          totalCases: _turkeyCount,
                                          flagPath: 'assets/images/flags/turkey_flag.jpg',
                                          fromSearch: false,
                                          pageColor: Colors.red[300])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Colors.red[300],
                                    cardName: "Turkey",
                                    flagImageString: 'assets/images/flags/turkey_flag.jpg',
                                    totalCases: formatNumber(_turkeyCount),
                                  ),
                                ),
                              );
                            }
                            if (index == 5) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CountryDetailPage(
                                          countrySlug: russiaSlug,
                                          countryName: "Russia",
                                          totalCases: _russiaCount,
                                          flagPath: 'assets/images/flags/russian_flag.jpg',
                                          fromSearch: false,
                                          pageColor: Colors.blue[700])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12),
                                  child: CountryCard(
                                    cardBackground: Colors.blue[700],
                                    cardName: "Russia",
                                    flagImageString: 'assets/images/flags/russian_flag.jpg',
                                    totalCases: formatNumber(_russiaCount),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                          itemCount: 6),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LightTheme.materialGrey,
      body: FutureBuilder(
        future: isDataLoaded ? globalData : getGlobalCountryData(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("Unable To Connect"));
              break;
            case ConnectionState.active:
              return Text("Please wait...");
            case ConnectionState.waiting:
              return CustomLoadingDialog();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Stack(
                    children: [
                      SomethingWentWrongScreen(),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.15,
                        left: MediaQuery.of(context).size.width * 0.3,
                        right: MediaQuery.of(context).size.width * 0.3,
                        child: FlatButton(
                          color: LightTheme.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          onPressed: refresh,
                          child: Text(
                            "Try Again".toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return homeContent(context, snapshot);
              }
              break;
          }
        },
      ),
    );
  }
}

String formatNumber(int number) {
  return NumberFormat.compact().format(number);
}

class Affected extends StatefulWidget {
  @override
  _AffectedState createState() => _AffectedState();
}

class _AffectedState extends State<Affected> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            LightTheme.materialGrey,
            Colors.red[50],
            Colors.red[100],
          ]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Affected",
                      style: TextStyle(color: Colors.brown[800], fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.arrow_drop_up_rounded, color: Colors.red),
                  ],
                ),
                Text(
                  formatNumber(_totalAffectedCases),
                  style: TextStyle(color: Colors.brown[800], fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ],
            ),
            Image.asset(
              'assets/images/red_line.png',
              width: MediaQuery.of(context).size.width * 0.14,
            )
          ],
        ),
      ),
    );
  }
}

class ActiveCases extends StatefulWidget {
  final int active;

  ActiveCases({this.active});

  @override
  _ActiveCasesState createState() => _ActiveCasesState();
}

class _ActiveCasesState extends State<ActiveCases> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            LightTheme.materialGrey,
            Colors.teal[50],
            Colors.teal[100],
          ]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Active Cases",
                      style: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.arrow_drop_up_rounded, color: Colors.teal[900]),
                  ],
                ),
                Text(
                  formatNumber(_totalActiveCases),
                  style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ],
            ),
            Image.asset(
              'assets/images/green_line.png',
              width: MediaQuery.of(context).size.width * 0.14,
            )
          ],
        ),
      ),
    );
  }
}

class DeadCases extends StatefulWidget {
  @override
  _DeadCasesState createState() => _DeadCasesState();
}

class _DeadCasesState extends State<DeadCases> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            LightTheme.materialGrey,
            Colors.red[50],
            Colors.red[100],
          ]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Deaths",
                      style: TextStyle(color: Colors.brown[800], fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.arrow_drop_up_rounded, color: Colors.red),
                  ],
                ),
                Text(
                  formatNumber(_totalDeadCases),
                  style: TextStyle(color: Colors.brown[800], fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ],
            ),
            // Image.asset('assets/images/red_line.png', width: MediaQuery.of(context).size.width * 0.14,)
          ],
        ),
      ),
    );
  }
}

class RecoveredCases extends StatefulWidget {
  @override
  _RecoveredCasesState createState() => _RecoveredCasesState();
}

class _RecoveredCasesState extends State<RecoveredCases> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            LightTheme.materialGrey,
            Colors.teal[50],
            Colors.teal[100],
          ]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Recovered",
                      style: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.arrow_drop_up_rounded, color: Colors.teal[900]),
                  ],
                ),
                Text(
                  formatNumber(_totalRecoveredCases),
                  style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ],
            ),
            Image.asset(
              'assets/images/green_line.png',
              width: MediaQuery.of(context).size.width * 0.14,
            )
          ],
        ),
      ),
    );
  }
}
