import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Lottie.asset(
            'assets/lottie/covid_loading.json',
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ),
      ),
    );
  }
}
