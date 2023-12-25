import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/screen/otp/otp_screen.dart';
import 'package:soul_comfort/screen/registration/registration_screen.dart';

class AuthProviders extends ChangeNotifier {
  String? _uid;

  String? get uid => _uid;

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  bool isLogin = false;
  bool isVerification = false;

  void isLoading({required bool value}) {
    isLogin = value;
    notifyListeners();
  }

  void verificationLoader({required bool value}) {
    isVerification = value;
    notifyListeners();
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      isLoading(value: true);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        timeout: const Duration(seconds: 100),
        codeSent: (verificationId, forceResendingToken) {
          isLoading(value: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      isLoading(value: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }

  Future<void> verificationCompleted(
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    isLoading(value: false);
    await _firebaseAuth
        .signInWithCredential(phoneAuthCredential)
        .whenComplete(() {});
  }

  void verificationFailed(
    FirebaseAuthException error,
  ) {
    isLoading(value: false);
    print('Phone Auth Verification Error ======== ${error.message}');
  }

  void codeAutoRetrievalTimeout(String verificationId) {}

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required String phoneNumber,
  }) async {
    notifyListeners();
    try {
      verificationLoader(value: true);
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        await checkExistingUser().then(
          (value) async {
            if (value == false) {
              verificationLoader(value: false);

            //   await Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       builder: (ctx) => const HomeScreen(),
            //     ),
            //     (route) => false,
            //   );
            // } else {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set({
                'id': uid,
                'phoneNumber': phoneNumber,
              }).then(
                (value) {
                  verificationLoader(value: false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const RegistrationScreen(),
                    ),
                    (route) => false,
                  );
                },
              );
            }
          },
        );
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      verificationLoader(value: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    final snapshot =
        await _firebaseFirestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}
