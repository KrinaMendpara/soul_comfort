import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/gen/assets.gen.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/providers/auth/auth_provider.dart';
import 'package:soul_comfort/screen/login/login_screen.dart';

void deleteUserAccount({
  required BuildContext context,
  required String imageUrl,
  required String userName,
  required String userEmail,
  // required bool isDeleteUsers,
}) {
  showModalBottomSheet<void>(
    backgroundColor: whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DeleteAccount(
        imageUrl: imageUrl,
        userName: userName,
        userEmail: userEmail,
        // isDeleteUser: isDeleteUsers,
      );
    },
  );
}

String generateRandomString(int length) {
  final random = Random();
  const characters =
      r'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';
  var result = '';
  for (var i = 0; i < length; i++) {
    result += characters[random.nextInt(characters.length)];
  }
  if (kDebugMode) {
    print(result);
  }
  return result;
}

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({
    required this.userName,
    required this.userEmail,
    required this.imageUrl,
    // this.isDeleteUser = false,
    super.key,
  });

  final String imageUrl;
  final String userName;
  final String userEmail;
  // final bool isDeleteUser;

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final formKey = GlobalKey<FormState>();
  final String captcha = generateRandomString(8);
  final TextEditingController captchaController = TextEditingController();
  bool isDelete = false;
  bool isColorChange = true;

  @override
  void dispose() {
    captchaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 15,
          top: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 3,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                localization.deleteAccount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                localization.areYouSureYouWantToDeleteAccount,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 24,
                    child: (widget.imageUrl.isEmpty )
                        ? Padding(
                            padding: const EdgeInsets.all(8),
                            child:
                                Image.asset(Assets.images.profilePicture.path),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        widget.userEmail,
                        style: const TextStyle(
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (isDelete == true)
              Row(
                children: [
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                      // color: greenColor.withOpacity(0.3),
                    ),
                    child: Text(
                      captcha,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 8) {
                            if (value == captcha) {
                              return null;
                            } else {
                              return localization.itIsANotSame;
                            }
                          } else {
                            return localization.itIsABigLength;
                          }
                        },
                        onChanged: (value) {
                          if (value == captcha) {
                            setState(() {
                              isColorChange = false;
                            });
                          } else {
                            setState(() {
                              isColorChange = true;
                            });
                          }
                        },
                        controller: captchaController,
                        textAlign: TextAlign.center,
                        cursorColor: blackColor,
                        decoration: InputDecoration(
                          hintText: localization.enterCaptcha,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: blackColor,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(
                              width: 2,
                              // color: greenColor,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: blackColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: isDelete == false
                      ? Colors.red
                      : isColorChange == true
                          ? Colors.grey.shade300
                          // ? greenColor.withOpacity(0.8)
                          : Colors.red,
                ),
                child: Text(
                  localization.delete,
                  style: TextStyle(
                    color: isDelete == false
                        ? Colors.white
                        : isColorChange == true
                            ? Colors.black
                            : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isDelete = true;
                  });
                  if (captchaController.text.isNotEmpty) {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthProviders>().checkDeleteUser();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (context) => const LogInScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  localization.cancel,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    setState(() {
                      isDelete = false;
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
