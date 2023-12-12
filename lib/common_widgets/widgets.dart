import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';

class GlobalWidgets {

  AppBar getAppBar({required String title}) {
    return AppBar(
      backgroundColor: whiteColor,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
