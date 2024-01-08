import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddLockerDetails extends StatelessWidget {
  const AddLockerDetails({required this.lockerNameController, required this.lockerAddressController, super.key, required this.pinCodeController});
  final TextEditingController lockerNameController;
  final TextEditingController lockerAddressController;
  final TextEditingController pinCodeController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: lockerNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.lockerName}*',
          onChanged: (value) {
            lockerNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: lockerAddressController,
          textInputAction: TextInputAction.next,
          text: '${localization.lockerAddress}*',
          onChanged: (value) {
            lockerAddressController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: pinCodeController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          text: '${localization.pinCode}*',
          validator: (value){
            if(value!.isEmpty) {
              return localization.pleaseEnterPinCodeNumber;
            } else if(value.length < 6) {
              return localization.pleaseEnterValidPinCodeNumber;
            }
            else if(value.length > 6){
              return localization.pinCodeNumberShouldBeOf6Digit;
            }
          },
        ),
      ],
    );
  }
}
