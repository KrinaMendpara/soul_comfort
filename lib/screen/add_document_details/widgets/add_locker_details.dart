import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddLockerDetails extends StatelessWidget {
  const AddLockerDetails({required this.lockerNameController, required this.lockerAddressController, super.key});
  final TextEditingController lockerNameController;
  final TextEditingController lockerAddressController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: lockerNameController,
          textInputAction: TextInputAction.next,
          text: localization.lockerName,
          onChanged: (value) {
            lockerNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: lockerAddressController,
          textInputAction: TextInputAction.next,
          text: localization.lockerAddress,
          onChanged: (value) {
            lockerAddressController.text = value!;
          },
        ),
      ],
    );
  }
}
