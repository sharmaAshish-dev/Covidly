import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  PrimaryButton({this.btnText, this.btnColor});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.btnColor ?? Color(0xFFB40284A),
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
            LightTheme.primaryColor,
            LightTheme.primaryDarkColor,
          ]),
          boxShadow: [
            BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
            BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
          ]),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
