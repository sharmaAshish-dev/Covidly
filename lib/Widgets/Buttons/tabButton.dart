import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String tabName;
  final bool isSelected;

  TabButton({this.tabName, @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.teal[50] : LightTheme.materialGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        tabName ?? "tab",
        style: TextStyle(
          color: isSelected ? Colors.teal[800] : Colors.teal[200],
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
