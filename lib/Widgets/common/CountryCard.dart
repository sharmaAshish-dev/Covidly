import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  String cardName;
  Color cardBackground;
  String totalCases;
  String flagImageString;

  CountryCard({this.cardName, this.cardBackground, this.totalCases, this.flagImageString});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFFFFFFF), width: 1), borderRadius: BorderRadius.circular(25), color: cardBackground),
      child: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(flagImageString ?? 'assets/images/flags/usa_flag.jpg', width: MediaQuery.of(context).size.width * 0.085, height: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cardName ?? "Country",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.045),
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                totalCases.toString() ?? "Total",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Transform.rotate(angle: -45, child: Icon(Icons.arrow_forward_rounded, color: Colors.white))
            ],
          ),
        )
      ]),
    );
  }
}
