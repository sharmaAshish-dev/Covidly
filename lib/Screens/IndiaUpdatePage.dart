import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:covidly/Screens/SearchCountryPage.dart';
import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/Widgets/common/StateDetailListTile.dart';
import 'package:covidly/Widgets/errorScreens/Something_went_wrong.dart';
import 'package:covidly/Widgets/loadings/CustomLoadingDialog.dart';
import 'package:covidly/uTils/FadeRoute.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<String> stateCodes = [
  'AN',
  'AP',
  'AR',
  'AS',
  'BR',
  'CH',
  'CT',
  'DL',
  'DN',
  'GA',
  'GJ',
  'HP',
  'HR',
  'JH',
  'JK',
  'KA',
  'KL',
  'LA',
  'LD',
  'MH',
  'ML',
  'MN',
  'MP',
  'MZ',
  'NL',
  'OR',
  'PB',
  'PY',
  'RJ',
  'SK',
  'TG',
  'TN',
  'TR',
  'UP',
  'UT',
  'WB'
];

dynamic indianStatesData;

class IndiaUpdatePage extends StatefulWidget {
  @override
  _IndiaUpdatePageState createState() => _IndiaUpdatePageState();
}

class _IndiaUpdatePageState extends State<IndiaUpdatePage> with AutomaticKeepAliveClientMixin {
  bool isDataLoaded = false;

  // bool showHomeStateDelta = false;

  Color confirmedTextColor = Colors.blue[700];
  Color activeTextColor = Colors.blue[900];
  Color recoveredTextColor = Colors.green[700];
  Color deathTextColor = Colors.red[500];

  int totalConfirmedCases;
  int totalRecoveredCases;
  int totalDeathCases;

  int deltaConfirmedCases;
  int deltaRecoveredCases;
  int deltaDeathCases;

  Future getIndianStateData() async {
    var url = "https://data.covid19india.org/v4/min/data.min.json";
    var response = await http.get(Uri.parse(url));
    dynamic data = jsonDecode(response.body);

    for (int i = 0; i < data.length; i++) {
      stateCodes.add(data[i]);
    }

    isDataLoaded = true;

    return data;
  }

  @override
  void initState() {
    super.initState();
    indianStatesData = getIndianStateData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size appSize = MediaQuery.of(context).size;

    Future<void> reloadScreen() async {
      setState(() {
        indianStatesData = getIndianStateData();
      });
    }

    Widget _contentArea(context, snapshot) {
      return RefreshIndicator(
        onRefresh: reloadScreen,
        child: ScrollConfiguration(
          behavior: NoScrollGlowBehaviour(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(FadeRoute(builder: (context) => SearchCountryPage())),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: LightTheme.lightGrey),
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Search Country",
                                          style: TextStyle(color: Colors.black, fontSize: appSize.width * 0.040, fontWeight: FontWeight.w300),
                                        )),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Stack(children: [
                            Opacity(child: Image.asset('assets/images/map.png', width: appSize.width, color: Colors.black), opacity: 0.12),
                            ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), child: Image.asset('assets/images/map.png', width: appSize.width)))
                          ]),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Text(
                                "Total Cases in India",
                                style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.w800, fontSize: appSize.width * 0.055),
                              ),
                              SizedBox(width: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset("assets/images/flags/indian_flag.jpg", width: MediaQuery.of(context).size.width * 0.11),
                              )
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10),
                          //   child: Text("Last updated on : " + formatISODate(snapshot.data['TT']['meta']['last_updated'])),
                          // ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                  BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Confirmed",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w700, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      _formatNumberToDecimal(snapshot.data['TT']['total']['confirmed']) ?? "0",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w700, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          _formatNumberToDecimal(snapshot.data['TT']['delta']['confirmed']) ?? "0",
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontWeight: FontWeight.w700, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                        ),
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: deathTextColor,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Recovered",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w700, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      _formatNumberToDecimal(snapshot.data['TT']['total']['recovered']) ?? "0",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w600, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          _formatNumberToDecimal(snapshot.data['TT']['delta']['recovered']) ?? "0",
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontWeight: FontWeight.w600, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                        ),
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: recoveredTextColor,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Deceased",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w700, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      _formatNumberToDecimal(snapshot.data['TT']['total']['deceased']) ?? "0",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontWeight: FontWeight.w600, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          _formatNumberToDecimal(snapshot.data['TT']['delta']['deceased']) ?? "0",
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontWeight: FontWeight.w600, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                        ),
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: deathTextColor,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  "Uttar Pradesh",
                                  style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.w800, fontSize: appSize.width * 0.06),
                                ),
                                SizedBox(width: 10),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                        BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Confirmed",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w700, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _formatNumberToDecimal(snapshot.data['UP']['total']['confirmed']) ?? "0",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w700, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                // (snapshot.data['UP']['delta']['confirmed']).toString() == 'null' ?  :
                                                "0",
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(fontWeight: FontWeight.w700, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Icon(
                                                    Icons.arrow_right_alt_rounded,
                                                    color: deathTextColor,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Recovered",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w700, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _formatNumberToDecimal(snapshot.data['UP']['total']['recovered']) ?? "0",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w600, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                // _formatNumberToDecimal(snapshot.data['UP']['delta']['recovered']) ??
                                                "0",
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(fontWeight: FontWeight.w600, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Icon(
                                                    Icons.arrow_right_alt_rounded,
                                                    color: recoveredTextColor,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Deceased",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w700, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _formatNumberToDecimal(snapshot.data['UP']['total']['deceased']) ?? "0",
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(fontWeight: FontWeight.w600, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                // _formatNumberToDecimal((snapshot.data['UP']['delta']['deceased'])) ??
                                                "0",
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(fontWeight: FontWeight.w600, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Icon(
                                                    Icons.arrow_right_alt_rounded,
                                                    color: deathTextColor,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "All States",
                            style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.w800, fontSize: appSize.width * 0.055),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 500,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length - 1,
                          itemBuilder: (context, index) {
                            String currentStateCode = stateCodes[index];
                            bool hasDeltaData = snapshot.data[currentStateCode]['delta'] != null;

                            bool hasDeltaConfirmedData = hasDeltaData ? ((snapshot.data[currentStateCode]['delta']['confirmed'] != null) ? true : false) : false;
                            bool hasDeltaRecoveredData = hasDeltaData ? ((snapshot.data[currentStateCode]['delta']['recovered'] != null) ? true : false) : false;
                            bool hasDeltaDeathData = hasDeltaData ? ((snapshot.data[currentStateCode]['delta']['deceased'] != null) ? true : false) : false;
                            bool hasDeltaTestedData = false;
                            bool hasDeltaVaccinatedData = false;
                            bool hasDeltaActiveData = (hasDeltaConfirmedData && hasDeltaRecoveredData && hasDeltaDeathData) ? true : false;

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: StateDetailListTile(
                                stateName: getStateName(stateCode: currentStateCode),
                                confirmedCases: _formatNumberToDecimal(snapshot.data[currentStateCode]['total']['confirmed']),
                                activeCases: _formatNumberToDecimal(snapshot.data[currentStateCode]['total']['confirmed'] -
                                    (snapshot.data[currentStateCode]['total']['recovered'] + snapshot.data[currentStateCode]['total']['deceased'])),
                                recoveredCases: _formatNumberToDecimal(snapshot.data[currentStateCode]['total']['recovered']),
                                deathCases: _formatNumberToDecimal(snapshot.data[currentStateCode]['total']['deceased']),
                                testedCases: _formatNumberToCompact(snapshot.data[currentStateCode]['total']['tested']),
                                vaccinatedCases: _formatNumberToCompact(snapshot.data[currentStateCode]['total']['vaccinated']),
                                population: _formatNumberToCompact(snapshot.data[currentStateCode]['meta']['population']),

                                deltaConfirmedCases: hasDeltaConfirmedData ? _formatNumberToDecimal(snapshot.data[currentStateCode]['delta']['confirmed']) : null,
                                deltaRecoveredCases: hasDeltaRecoveredData ? _formatNumberToDecimal(snapshot.data[currentStateCode]['delta']['recovered']) : null,
                                deltaDeathCases: hasDeltaDeathData ? _formatNumberToDecimal(snapshot.data[currentStateCode]['delta']['deceased']) : null,
                                deltaActiveCases: hasDeltaActiveData
                                    ? _formatNumberToDecimal((snapshot.data[currentStateCode]['delta']['confirmed'] -
                                        (snapshot.data[currentStateCode]['delta']['recovered'] + snapshot.data[currentStateCode]['delta']['deceased'])))
                                    : null,
                                // deltaTestedCases: _formatNumberToCompact(snapshot.data[currentState]['delta7']['tested']),
                                // deltaVaccinatedCases: _formatNumberToCompact(snapshot.data[currentState]['delta7']['vaccinated']),

                                showDeltaConfirmedData: hasDeltaConfirmedData,
                                showDeltaActiveData: false,
                                showDeltaDeathData: hasDeltaDeathData,
                                showDeltaRecoveredData: hasDeltaRecoveredData,
                                showDeltaTestedData: hasDeltaTestedData,
                                showDeltaVaccinatedData: hasDeltaVaccinatedData,
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getIndianStateData(),
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
                            onPressed: reloadScreen,
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
                  return _contentArea(context, snapshot);
                }
                break;
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;

  String getStateName({String stateCode}) {
    switch (stateCode) {
      case 'AN':
        return 'Andaman\nand\nNicobar\nIsland';
        break;
      case 'AP':
        return 'Andhra\nPradesh';
        break;
      case 'AR':
        return 'Arunachal\nPradesh';
        break;
      case 'AS':
        return 'Assam';
        break;
      case 'BR':
        return 'Bihar';
        break;
      case 'CH':
        return 'Chandigarh';
        break;
      case 'CT':
        return 'Chattisgarh';
        break;
      case 'DN':
        return 'Dadra And\nNagar\nHaveli';
        break;
      case 'DL':
        return 'Delhi';
        break;
      case 'GA':
        return 'Goa';
        break;
      case 'GJ':
        return 'Gujarat';
        break;
      case 'HR':
        return 'Haryana';
        break;
      case 'HP':
        return 'Himachal\nPradesh';
        break;
      case 'JK':
        return 'Jammu\nand\nKashmir';
        break;
      case 'JH':
        return 'Jharkhand';
        break;
      case 'KA':
        return 'Karnataka';
        break;
      case 'KL':
        return 'Kerala';
        break;
      case 'LA':
        return 'Ladakh';
        break;
      case 'LD':
        return 'Lakshadweep\nIslands';
        break;
      case 'MP':
        return 'Madhya\nPradesh';
        break;
      case 'MH':
        return 'Maharashtra';
        break;
      case 'MN':
        return 'Manipur';
        break;
      case 'ML':
        return 'Meghalaya';
        break;
      case 'MZ':
        return 'Mizoram';
        break;
      case 'NL':
        return 'Nagaland';
        break;
      case 'OR':
        return 'Odisha';
        break;
      case 'PY':
        return 'Pondicherry';
        break;
      case 'PB':
        return 'Punjab';
        break;
      case 'RJ':
        return 'Rajasthan';
        break;
      case 'SK':
        return 'Sikkim';
        break;
      case 'TN':
        return 'Tamil\nNadu';
        break;
      case 'TG':
        return 'Telangana';
        break;
      case 'TR':
        return 'Tripura';
        break;
      case 'UP':
        return 'Uttar\nPradesh';
        break;
      case 'UT':
        return 'Uttarakhand';
        break;
      case 'WB':
        return 'West\nBengal';
        break;
    }
    return '';
  }

  String _formatNumberToCompact(int number) {
    if (number == null) {
      return "N/A";
    }
    return NumberFormat.compact().format(number);
  }

  String _formatNumberToDecimal(int number) {
    if (number == null) {
      return "N/A";
    }
    var formatter = NumberFormat('#,##,000');
    return formatter.format(number).toString();
  }

  String formatISODate(String isoDate) {
    if (isoDate == null) {
      return "N/A";
    }

    isoDate = isoDate.split("+")[0];

    DateTime updateTime = DateTime.parse(isoDate);
    return DateFormat('dd-MMM-yyyy').add_jm().format(updateTime);
  }
}
