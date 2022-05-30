import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  bool isClicked;

  SearchButton({this.isClicked});

  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: widget.isClicked ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)) : Icon(CupertinoIcons.search, color: Colors.white),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(begin: Alignment(-1.0, -4.0), end: Alignment(1.0, 4.0), colors: [
            Colors.red[400],
            Colors.red[600],
          ]),
          boxShadow: [
            BoxShadow(color: Color(0xFFd9d9d9), offset: Offset(4.0, 5.0), blurRadius: 14.0, spreadRadius: 1.0),
            BoxShadow(color: Color(0xFFffffff), offset: Offset(-3.0, -5.0), blurRadius: 14.0, spreadRadius: 1.0),
          ]),
      padding: EdgeInsets.all(14),
    );
  }
}
