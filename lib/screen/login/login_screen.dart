import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/providers/auth/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  PhoneController phoneController = PhoneController(null);
  String? phoneNumber;

  Future<void> _sendPhoneNumber(BuildContext context) async{
    final authProvider = Provider.of<AuthProviders>(context, listen: false);
    await authProvider.signInWithPhone(
      context,
      phoneController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviders>();
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              localization.enterMobileNumber,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                // height: 3,
              ),
            ),
            Text(
              localization.toSoulComfort,
              style: const TextStyle(
                fontSize: 16,
                // height: 3,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: PhoneFormField(
                controller: phoneController,
                countrySelectorNavigator:
                    const CountrySelectorNavigator.draggableBottomSheet(),
                defaultCountry: IsoCode.IN,
                validator: (value) {
                  if (value!.nsn.length < 10) {
                    return localization.pleaseEnterValidPhoneNumber;
                  } else if (value.nsn.length != 10) {
                    return localization.phoneNumberShouldBeOf10Digit;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value!.international;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    phoneNumber = value!.international;
                  });
                },
                decoration: InputDecoration(
                  hintText: localization.enterPhoneNumber,
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: blackColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: blackColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: blackColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: greenColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: CommonButton(
          onTap: () {
            _sendPhoneNumber(context);
            // context.read<AuthProviders>().checkDeleteUser(phoneNumber!, context);
          },
          widget: authProvider.isLogin
              ? const Indicator(
                  color: whiteColor,
                )
              : Text(
                  localization.sendOTP,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
