import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextEditingController inputController;
  final bool isTextHidden;
  final bool showToggleBtn;
  final int maxLength;

  InputWithIcon({this.icon, this.hint, this.inputType, @required this.inputController, this.isTextHidden, this.showToggleBtn, this.maxLength});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    bool showText = widget.isTextHidden;

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFBC7C7C7), width: 2), borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              obscureText: showText,
              controller: widget.inputController,
              keyboardType: widget.inputType,
              decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 14), border: InputBorder.none, hintText: widget.hint),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showText = !showText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Visibility(visible: widget.showToggleBtn ?? false, child: showText ? Icon(CupertinoIcons.eye) : Icon(CupertinoIcons.eye_slash)),
            ),
          )
        ],
      ),
    );
  }
}
