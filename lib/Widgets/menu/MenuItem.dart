import 'dart:ui';

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const MenuItem({Key key, this.icon, this.title, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: isSelected ? Colors.red[50] : Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.black87,
              size: isSelected ? 25 : 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.w300, fontSize: 18, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
