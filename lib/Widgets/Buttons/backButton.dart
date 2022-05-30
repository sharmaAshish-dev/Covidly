import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class backButton extends StatelessWidget {
  Color borderColor;
  IconData iconData;
  Color containerColor;

  backButton({@required this.borderColor, this.iconData, this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: borderColor.withOpacity(0.6)), color: containerColor != null ? containerColor : null),
      child: Icon(iconData ?? Icons.arrow_back_ios_rounded, color: containerColor != null ? Colors.black : borderColor.withOpacity(0.8)),
    );
  }
}
