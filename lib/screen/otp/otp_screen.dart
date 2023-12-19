import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/providers/auth/auth_provider.dart';
import 'package:soul_comfort/screen/home/home_screen.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/screen/registration/registration_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.verificationId,
    required this.phoneNumber,
    super.key,
  });

  final String verificationId;
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  Timer? timer;
  int second = 59;
  bool enableResend = false;

  PinTheme followingPinTheme = PinTheme(
    height: 40,
    width: 40,
    textStyle: const TextStyle(
      color: Colors.black87,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: Colors.black87,
      ),
    ),
  );

  PinTheme submittedPinTheme = PinTheme(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      // shape: BoxShape.circle,
      color: Colors.white54,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
          // color: greenColor,
          color: blackColor,),
    ),
  );

  Future<void> verifyOTP(BuildContext context, String? otp) async {
    final authProvider = Provider.of<AuthProviders>(context, listen: false);
    await authProvider.verifyOTP(
      context: context,
      verificationId: widget.verificationId,
      userOTP: otp!,
      phoneNumber: widget.phoneNumber,
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (second != 0) {
        setState(() {
          second--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProviders>(context, listen: false);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localization.otpHasBeenSentForVerification,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.phoneNumber,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Pinput(
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                length: 6,
                animationCurve: Curves.bounceIn,
                followingPinTheme: followingPinTheme,
                submittedPinTheme: submittedPinTheme,
                focusedPinTheme: submittedPinTheme,
                onSubmitted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                onCompleted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
              ),
            ),
            CommonButton(
              onTap: () {
                verifyOTP(context, otpCode);
              },
              widget: authProvider.isVerification
                  ? const Indicator(
                      color: whiteColor,
                    )
                  : Text(
                      localization.submit,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
            ),
            TextButton(
              onPressed: second != 0
                  ? null
                  : () {
                      final phoneNumber = widget.phoneNumber;

                      authProvider.signInWithPhone(
                        context,
                        phoneNumber,
                      );
                      setState(() {
                        enableResend = false;
                        second = 59;
                      });
                    },
              child: Text(
                '${localization.sendOTPAgain} (00 : $second)',
                style: const TextStyle(
                  color: greenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
