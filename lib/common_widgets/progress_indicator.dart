import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';


class Indicator extends StatelessWidget {
  const Indicator({this.color, super.key});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        color: color ?? greenColor,
        strokeCap: StrokeCap.round,
    );
  }
}
