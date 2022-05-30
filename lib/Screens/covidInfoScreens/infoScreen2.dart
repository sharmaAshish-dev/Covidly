import 'package:covidly/Screens/CovidPreventionPage.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/material.dart';

class infoScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CovidPreventionPage())),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        width: appSize.width,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
                    LightTheme.accentColor,
                    LightTheme.accentColor,
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
                    BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/stay_home.png',
                  width: appSize.width * 0.46,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "5 Preventions tips for covid-19",
                          maxLines: 2,
                          style: TextStyle(fontSize: appSize.width * 0.046, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Read More",
                          maxLines: 2,
                          style: TextStyle(
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 3,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontSize: appSize.width * 0.045,
                              fontWeight: FontWeight.w600,
                              // color: Color(0xff348a7b)
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
