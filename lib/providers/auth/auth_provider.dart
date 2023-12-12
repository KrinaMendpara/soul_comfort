
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/screen/otp/otp_screen.dart';

class AuthProviders extends ChangeNotifier{

  String? _uid;

  String? get uid => _uid;


  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                  phoneNumber : phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
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
    await _firebaseAuth.signInWithCredential(phoneAuthCredential);
  }

  void verificationFailed(FirebaseAuthException error,) {
    print('Phone Auth Verification Error ======== ${error.message}');
  }

  void codeAutoRetrievalTimeout(String verificationId) {}

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required Function onSuccess,
  }) async {
    notifyListeners();
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
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
    final snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

}