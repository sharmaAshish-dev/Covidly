import 'dart:async';
import 'dart:convert';

import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:covidly/Widgets/common/CountryCard.dart';
import 'package:covidly/Widgets/loadings/CustomLoadingDialog.dart';
import 'package:covidly/Widgets/popups/loadingPopup.dart';
import 'package:covidly/uTils/NoScrollBehaviour.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:covidly/uTils/constAPIUrl.dart';

class CountryDetailPage extends StatefulWidget {
  String countryName;
  String countryCode;
  int totalCases;
  String flagPath;
  Color pageColor;
  String countrySlug;
  bool fromSearch;

  CountryDetailPage({this.countryName, this.totalCases, this.flagPath, this.pageColor, this.countrySlug, this.fromSearch, this.countryCode});

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  bool isDataLoaded = false;
  double _bottomOffset = 0;
  double _bottomSheetHeight = 0;

  Future _getCountryData(String cName) async {
    var url = apiUrl.baseUrl + "total/dayone/country/" + cName;
    var response = await http.get(Uri.parse(url));
    dynamic data = jsonDecode(response.body);

    return data;
  }

  @override
  void initState() {
    startTime();
    _getCountryData(widget.countrySlug);
    super.initState();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 200);
    return new Timer(duration, () {
      setState(() {
        _bottomOffset = MediaQuery.of(context).size.height * 0.25;
        _bottomSheetHeight = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String slug = widget.countrySlug;
    String countryCode = widget.countryCode;
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.pageColor ?? LightTheme.primaryColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: backButton(borderColor: Colors.white),
                ),
              ),
            ),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.fromSearch ? 15 : 0),
                      child: widget.fromSearch
                          ? Image.network(widget.flagPath, width: MediaQuery.of(context).size.width * 0.11)
                          : Image.asset(widget.flagPath ?? 'assets/images/flags/usa_flag.jpg', width: MediaQuery.of(context).size.width * 0.11),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.countryName ?? "Country",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatNumberToDecimal(widget.totalCases) ?? "0000000",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.10),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_upward_rounded, color: Colors.white)
                  ],
                ),
              )
            ]),
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                width: appSize.width,
                height: _bottomSheetHeight,
                padding: EdgeInsets.only(top: 20),
                curve: Curves.elasticOut,
                duration: Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(0, _bottomOffset, 0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                child: ScrollConfiguration(
                  behavior: NoScrollGlowBehaviour(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                          child: Text(
                            "Total Cases",
                            style: TextStyle(color: widget.pageColor, fontWeight: FontWeight.w800, fontSize: appSize.width * 0.06),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: _bottomSheetHeight,
                          child: FutureBuilder(
                            future: _getCountryData(slug),
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Text("Unable to connect");
                                  break;
                                case ConnectionState.active:
                                  return Text("Please Wait...");
                                  break;
                                case ConnectionState.waiting:
                                  return CustomLoadingDialog();
                                  break;
                                case ConnectionState.done:
                                  if (snapshot.hasData) {
                                    return _listData(context, snapshot);
                                  }
                                  break;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _showCountryData(snapshot) {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: (getMaxX(snapshot) * 0.15).ceilToDouble(),
          showTitles: true,
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: getMaxX(snapshot),
      minY: getMinY(snapshot, 'Confirmed'),
      maxY: getMaxY(snapshot, 'Confirmed'),
      lineBarsData: linesBarData(snapshot),
    );
  }

  double getMinY(snapshot, String key) {
    int value = snapshot.data[0][key];
    return value.toDouble();
  }

  double getMaxX(snapshot) {
    int value = snapshot.data.length;
    print(" Max X: $value");
    return value.toDouble();
  }

  double getMaxY(snapshot, String key) {
    int value = snapshot.data[snapshot.data.length - 1][key];
    print(" Max Y: $value");
    return value.toDouble();
  }

  List<LineChartBarData> linesBarData(snapshot) {
    final LineChartBarData confirmedCases = LineChartBarData(
      spots: dataPoints(snapshot, 'Confirmed'),
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData activeCases = LineChartBarData(
      spots: dataPoints(snapshot, 'Active'),
      isCurved: true,
      colors: [
        Color(0xFF1565C0),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData deathsCases = LineChartBarData(
      spots: dataPoints(snapshot, 'Deaths'),
      isCurved: true,
      colors: [
        const Color(0xffff4f59),
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      confirmedCases,
      activeCases,
      deathsCases,
    ];
  }

  List<FlSpot> dataPoints(snapshot, String key) {
    List<FlSpot> points = [];

    for (int i = 0; i < snapshot.data.length; i++) {
      int temp = snapshot.data[i][key];
      if (snapshot.data[i]['Date'] != "2021-03-07T00:00:00Z") {
        points.add(FlSpot(i.toDouble(), temp.toDouble()));
      }
    }
    return points;
  }

  Widget _listData(context, snapshot) {
    Size appSize = MediaQuery.of(context).size;
    return ScrollConfiguration(
      behavior: NoScrollGlowBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20),
              height: _bottomSheetHeight * 0.2,
              child: LineChart(
                _showCountryData(snapshot),
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                      LightTheme.materialGrey,
                      LightTheme.materialGrey,
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                      BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 10,
                          backgroundColor: Color(0xff4af699),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Confirmed Cases",
                              style: TextStyle(fontSize: appSize.width * 0.045, color: LightTheme.greyishBlack, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _formatNumberToDecimal(snapshot.data[snapshot.data.length - 1]['Confirmed']) ?? "Confirmed Cases",
                              style: TextStyle(fontSize: appSize.width * 0.045, fontWeight: FontWeight.w700),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                      LightTheme.materialGrey,
                      LightTheme.materialGrey,
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                      BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 10,
                          backgroundColor: Color(0xFF1565C0),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active Cases",
                              style: TextStyle(fontSize: appSize.width * 0.045, color: LightTheme.greyishBlack, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _formatNumberToDecimal(snapshot.data[snapshot.data.length - 1]['Active']) ?? "Active Cases",
                              style: TextStyle(fontSize: appSize.width * 0.045, fontWeight: FontWeight.w700),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                      LightTheme.materialGrey,
                      LightTheme.materialGrey,
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                      BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 10,
                          backgroundColor: Color(0xffff4f59),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Death Cases",
                              style: TextStyle(fontSize: appSize.width * 0.045, color: LightTheme.greyishBlack, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _formatNumberToDecimal(snapshot.data[snapshot.data.length - 1]['Deaths']) ?? "Deaths",
                              style: TextStyle(fontSize: appSize.width * 0.045, fontWeight: FontWeight.w700),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumberToDecimal(int number) {
    var formatter = NumberFormat('#,##,000');
    return formatter.format(number).toString();
  }
}
