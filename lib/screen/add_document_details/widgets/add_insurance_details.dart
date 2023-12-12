import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddInsuranceDetails extends StatelessWidget {
  const AddInsuranceDetails({required this.insuranceNameController, required this.otherController, super.key});
  final TextEditingController insuranceNameController;
  final TextEditingController otherController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: insuranceNameController,
          textInputAction: TextInputAction.next,
          text: localization.insuranceName,
          onChanged: (value) {
            insuranceNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: otherController,
          textInputAction: TextInputAction.next,
          text: localization.other,
          onChanged: (value) {
            otherController.text = value!;
          },
        ),
      ],
    );
  }
}
