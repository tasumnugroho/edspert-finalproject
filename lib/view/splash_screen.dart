import 'dart:async';
import 'package:edspert_finalproject/constants/r.dart';
import 'package:edspert_finalproject/models/network_response.dart';
import 'package:edspert_finalproject/repository/auth_api.dart';
import 'package:edspert_finalproject/helpers/user_email.dart';
import 'package:edspert_finalproject/models/user_by_email.dart';
import 'package:edspert_finalproject/repository/auth_api.dart';
import 'package:edspert_finalproject/view/login_page.dart';
import 'package:edspert_finalproject/view/main/latihan_soal/home_page.dart';
import 'package:edspert_finalproject/view/main_page.dart';
import 'package:edspert_finalproject/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail;

      if (user != null) {
        final dataUser = await AuthApi().getUserByEmail();
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
          if (data.status == 1) {
            Navigator.of(context).pushNamed(MainPage.route);
          } else {
            Navigator.of(context).pushNamed(RegisterPage.route);
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
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
