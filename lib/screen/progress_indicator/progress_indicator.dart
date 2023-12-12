import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';


class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
        color: greenColor,
        strokeCap: StrokeCap.round,
    );
  }
}
