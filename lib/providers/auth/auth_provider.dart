import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/screen/home/home_screen.dart';
import 'package:soul_comfort/screen/otp/otp_screen.dart';
import 'package:soul_comfort/screen/registration/registration_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthProviders extends ChangeNotifier {
  String? _uid;

  String? get uid => _uid;

  String? _userPhoneNumber;
  String? get userPhoneNumber => _userPhoneNumber;

  String? _userEmail;
  String? get userEmail => _userEmail;

  Users? users;

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  bool isLogin = false;
  bool isVerification = false;
  bool isUserDelete = false;

  int? forceResendingToken;

  void isLoading({required bool value}) {
    isLogin = value;
    notifyListeners();
  }

  void verificationLoader({required bool value}) {
    isVerification = value;
    notifyListeners();
  }

  Future<void> signInWithPhone(
    BuildContext context,
    PhoneController controller,
  ) async {
    final phoneNumber = controller.value!.international;
    print('------------------ $phoneNumber');
    if (!(controller.value?.isValid() ?? false)) {
      return;
    }
    try {
      isLoading(value: true);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        forceResendingToken: forceResendingToken,
        codeSent: (verificationID, resendingToken) {
          forceResendingToken = resendingToken;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationID,
                phoneNumber: phoneNumber,
                phoneController: controller,
              ),
            ),
          );
          isLoading(value: false);

          notifyListeners();
        },
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException   ${e.message}');
      isLoading(value: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    } on Exception {
      isLoading(value: false);
      rethrow;
    }
  }

  Future<void> verificationCompleted(
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    print('verification Completed ---------------');
    isLoading(value: false);
    await _firebaseAuth.signInWithCredential(phoneAuthCredential).then((value) {
      print('signInWithCredential value   ----------- $value');
    });
  }

  void verificationFailed(
    FirebaseAuthException error,
  ) {
    isLoading(value: false);
    print('Phone Auth Verification Error ======== ${error.message}');
  }

  void codeAutoRetrievalTimeout(String verificationID) {
    print('verificationID =========== $verificationID');
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required String phoneNumber,
  }) async {
    try {
      verificationLoader(value: true);
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        _userPhoneNumber = user.phoneNumber;
        _userEmail = _firebaseAuth.currentUser!.email;
        // await getUserEmail() .then((value) {
        //   _userEmail = value;
        // });
        await checkDeleteUser().then((value) async {
          if (value == true) {
            verificationLoader(value: false);
            await checkDeleteUser().then((value) async {
              await deleteUserDialog(context);
            });
          } else {
            await checkExistingUser().then(
              (value) async {
                if (value == true) {
                  verificationLoader(value: false);
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                } else {
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
        });

        notifyListeners();
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


  Future<String> getUserEmail() async{
    final snapshot = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('userData')
        .doc(userPhoneNumber)
        .get();
    final email = snapshot.data()!['email'].toString().isNotEmpty ? snapshot.data()!['email'].toString() : '';
    notifyListeners();
    return email;
  }
  Future<void> deleteUserDialog(BuildContext context) async {
    // xAF7C4oBOsYtGlWdpdXpt2lQqUT2
    return showDialog(
      context: context,
      barrierColor: blackColor.withOpacity(0.5),
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 15, 10),
          content: const Text(
            'My Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'This account permanently deleted',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // final emailLaunchUri = Uri(
                //   scheme: 'mailto',
                //   path: 'mendparakrina@gmail.com',
                //     queryParameters: {
                //       'subject': '',
                //       'body': 'uid : $uid, \n E-mail : ${_firebaseAuth.currentUser!.email},  ',
                //     },
                // );
                // launchUrl(emailLaunchUri).toString();
                final email = Uri.encodeComponent('mendparakrina@mail.com');
                final subject = Uri.encodeComponent('Contact to support');
                final body = Uri.encodeComponent('Uid : $uid, \n Email : $userEmail');
                print(subject);
                print(email);
                final mail = Uri.parse('mailto:$email?subject=$subject&body=$body');
                launchUrl(mail);
              },
              child: const Text(
                'Contact support',
              ),
            ),
          ],
        );
      },
    );
  }


  Future<bool> checkDeleteUser() async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('userData')
        .doc(userPhoneNumber)
        .get();
    if (snapshot.data()?['isDeleteUser'] == true) {
      return true;
    } else {
      return false;
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
