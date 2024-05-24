import 'dart:async';

import 'package:firebase_mxpert/firebase/onbading_screen.dart';
import 'package:firebase_mxpert/screens/home_page.dart';
import 'package:firebase_mxpert/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../store/fire_store.dart';

class SplashServices {
  void isLogin(context) {
    //
    //
    final auth = FirebaseAuth.instance;
    //
    final user = auth.currentUser;
    //
    if (user != null) {
      //
      // Timer(
      //   Duration(seconds: 3),
      //   () => Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomePage(
      //         title: "Home",
      //       ),
      //     ),
      //   ),
      // );

      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              title: 'Home',
            ),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(),
          ),
        ),
      );
    }
  }
}
