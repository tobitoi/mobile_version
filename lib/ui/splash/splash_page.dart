import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/icons/ic_launcher.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    ));
  }
}
