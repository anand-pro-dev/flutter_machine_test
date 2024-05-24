// #1b9fb7

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColor {
  final primaryColor = const Color(0xFF1b9fb7);

  final theme = SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.dark,
  ));
}
