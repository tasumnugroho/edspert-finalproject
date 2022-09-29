import 'dart:async';
import 'package:edspert_finalproject/constants/r.dart';
import 'package:edspert_finalproject/view/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      // Navigator.of(context)
      // .push(MaterialPageRoute(builder: (context) => LoginPage()));
      Navigator.of(context).pushNamed(LoginPage.route);
    });

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(R.assets.icSplash),
      ),
    );
  }
}
