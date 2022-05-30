import 'package:flutter/material.dart';

class OutlineBtn extends StatefulWidget {
  final String btnText;
  final Color btnColor;

  const OutlineBtn({this.btnText, this.btnColor});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.btnColor, border: widget.btnColor == null ? Border.all(color: Color(0xFFB40284A), width: 2) : null, borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(14),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}
