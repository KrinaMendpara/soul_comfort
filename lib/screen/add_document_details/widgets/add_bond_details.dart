import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddBondDetails extends StatelessWidget {
  const AddBondDetails({required this.bondNameController, required this.bondDetailsController, super.key});
  final TextEditingController bondNameController;
  final TextEditingController bondDetailsController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return  Column(
      children: [
        CommonTextFormField(
          controller: bondNameController,
          textInputAction: TextInputAction.next,
          text: localization.bondName,
          onChanged: (value) {
            bondNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: bondDetailsController,
          textInputAction: TextInputAction.next,
          text: localization.bondDetails,
          onChanged: (value) {
            bondDetailsController.text = value!;
          },
        ),
      ],
    );
  }
}
