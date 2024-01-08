import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/providers/auth/auth_provider.dart';
import 'package:soul_comfort/screen/home/home_screen.dart';
import 'package:soul_comfort/screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    timer();
    super.initState();
  }
  // Future<void> checkConnection() async{
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //
  //     print('ConnectivityResult.mobile');
  //   }
  //   else if (connectivityResult == ConnectivityResult.wifi) {
  //     print('ConnectivityResult.wifi');
  //     AlertDialog(
  //       actions: [
  //         Image.asset('assets/icons/wifi_offline.png',
  //           height : 40,
  //           width : 40,
  //           fit: BoxFit.fill,
  //         ),
  //         const Text('Check Your Internet Connection'),
  //         const Text('Check Your Internet Connection'),
  //       ],
  //     );
  //   }
  //   else if(connectivityResult == ConnectivityResult.ethernet) {
  //     print('ConnectivityResult.ethernet');
  //   }
  //   else if(connectivityResult == ConnectivityResult.none) {
  //     print('ConnectivityResult.none');
  //     // AlertDialog(
  //     //   actions: [
  //     //     Image.asset('assets/icons/wifi_offline.png',
  //     //       height : 40,
  //     //       width : 40,
  //     //       fit: BoxFit.fill,
  //     //     ),
  //     //     const Text('Check Your Internet Connection'),
  //     //     const Text('Check Your Internet Connection'),
  //     //   ],
  //     // );
  //   }
  // }

  void timer() {
    Timer(const Duration(seconds: 2), () async {
      final currentUser = FirebaseAuth.instance.currentUser;
      await context.read<AuthProviders>().checkDeleteUser().then((value) async {
        if(value == false) {
          if(currentUser != null) {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => const HomeScreen(),
              ),
                  (route) => false,
            );
          } else {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => const LogInScreen(),
              ),
                  (route) => false,
            );
          }
        }
      });
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
