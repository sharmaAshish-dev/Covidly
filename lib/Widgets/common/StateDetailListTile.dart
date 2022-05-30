import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StateDetailListTile extends StatelessWidget {
  final String stateName;

  final String confirmedCases;
  final String activeCases;
  final String recoveredCases;
  final String deathCases;
  final String testedCases;
  final String vaccinatedCases;
  final String population;

  final String deltaConfirmedCases;
  final String deltaActiveCases;
  final String deltaRecoveredCases;
  final String deltaDeathCases;
  final String deltaTestedCases;
  final String deltaVaccinatedCases;

  final bool showDeltaConfirmedData;
  final bool showDeltaActiveData;
  final bool showDeltaRecoveredData;
  final bool showDeltaDeathData;
  final bool showDeltaTestedData;
  final bool showDeltaVaccinatedData;

  StateDetailListTile({
    this.stateName,
    this.confirmedCases,
    this.activeCases,
    this.recoveredCases,
    this.deathCases,
    this.testedCases,
    this.vaccinatedCases,
    this.population,
    this.deltaConfirmedCases,
    this.deltaActiveCases,
    this.deltaDeathCases,
    this.deltaRecoveredCases,
    this.deltaTestedCases,
    this.deltaVaccinatedCases,
    @required this.showDeltaConfirmedData,
    @required this.showDeltaActiveData,
    @required this.showDeltaDeathData,
    @required this.showDeltaRecoveredData,
    @required this.showDeltaTestedData,
    @required this.showDeltaVaccinatedData,
  });

  @override
  Widget build(BuildContext context) {
    Color confirmedTextColor = Colors.blue[700];
    Color activeTextColor = Colors.blue[900];
    Color recoveredTextColor = Colors.green[700];
    Color deathTextColor = Colors.red[500];
    Color testedTextColor = Colors.deepPurple;
    Color vaccinatedTextColor = Colors.blue;
    Color populationTextColor = Colors.green[500];

    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
            Color(0xffffffff),
            Color(0xffffffff),
          ]),
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
            BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              stateName ?? "State Name",
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoScrollGlowBehaviour(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          confirmedCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaConfirmedData,
                          child: Row(
                            children: [
                              Text(
                                deltaConfirmedCases ?? "0",
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontWeight: FontWeight.w600, color: confirmedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: confirmedTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Active",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w700, color: activeTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Text(
                          activeCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: activeTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaActiveData,
                          child: Row(
                            children: [
                              Text(
                                deltaActiveCases ?? "0",
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontWeight: FontWeight.w600, color: activeTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: activeTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
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
                          recoveredCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: recoveredTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaRecoveredData,
                          child: Row(
                            children: [
                              Text(
                                deltaRecoveredCases ?? "0",
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
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
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
                          deathCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: deathTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaDeathData,
                          child: Row(
                            children: [
                              Text(
                                deltaDeathCases ?? "0",
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
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tested",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w700, color: testedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Text(
                          testedCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: testedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaTestedData,
                          child: Row(
                            children: [
                              Text(
                                deltaTestedCases ?? "0",
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontWeight: FontWeight.w600, color: testedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: testedTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Vaccinated",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w700, color: vaccinatedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Text(
                          vaccinatedCases ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: vaccinatedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: showDeltaVaccinatedData,
                          child: Row(
                            children: [
                              Text(
                                deltaVaccinatedCases ?? "0",
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontWeight: FontWeight.w600, color: vaccinatedTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: vaccinatedTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Population",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w700, color: populationTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                        Text(
                          population ?? "0",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontWeight: FontWeight.w600, color: populationTextColor, fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumberToDecimal(int number) {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(number).toString();
  }

  String _formatNumberToCompact(int number) {
    return NumberFormat.compact().format(number);
  }
}
