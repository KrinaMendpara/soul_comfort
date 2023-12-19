import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/screen/login/login_screen.dart';

class SoulComfort extends StatefulWidget {
  const SoulComfort({super.key});

  @override
  State<SoulComfort> createState() => _SoulComfortState();
}

class _SoulComfortState extends State<SoulComfort> {
  @override
  void initState() {
    timer();
    super.initState();
  }

  timer() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const LogInScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          localization.soulComfort,
          style: const TextStyle(
            fontSize: 30,
            color: greenColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
