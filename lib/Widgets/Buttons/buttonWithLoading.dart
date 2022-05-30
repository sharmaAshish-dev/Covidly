import 'package:flutter/material.dart';

class ButtonWithLoading extends StatefulWidget {
  final String buttonTitle;
  final bool isReset;
  final Color btnColor;

  ButtonWithLoading({this.buttonTitle, @required this.isReset, this.btnColor});

  @override
  _ButtonWithLoadingState createState() => _ButtonWithLoadingState();
}

class _ButtonWithLoadingState extends State<ButtonWithLoading> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> buttonSqueezeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: new Duration(milliseconds: 300), vsync: this);

    buttonSqueezeAnimation = new Tween(
      begin: 320.0,
      end: 60.0,
    ).animate(new CurvedAnimation(parent: _controller, curve: new Interval(0.0, 0.250)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _playAnimation(widget.isReset);
    });
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: buttonSqueezeAnimation.value,
        height: 60.0,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(color: widget.btnColor, borderRadius: new BorderRadius.all(const Radius.circular(30.0))),
        child: buttonSqueezeAnimation.value > 60.0
            ? new Text(
                widget.buttonTitle ?? "Button",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            : new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ));
  }

  Future<Null> _playAnimation(bool isLoading) async {
    try {
      if (isLoading) {
        await _controller.forward();
      } else {
        await _controller.reverse();
      }
    } on TickerCanceled {}
  }
}
