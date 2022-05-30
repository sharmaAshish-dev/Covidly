import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingPopup extends StatelessWidget {
  final bool isVisible;

  LoadingPopup({@required this.isVisible});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Visibility(
      visible: isVisible,
      child: Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), SizedBox(width: 50), Text("Please wait...", style: TextStyle(fontFamily: "OpenSans", color: Color(0xFF5B6978)))]),
          ),
        ),
      ),
    );
  }
}
