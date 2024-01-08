import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddPrivetEquityDetails extends StatelessWidget {
  const AddPrivetEquityDetails(
      {required this.equityNameController,
      required this.otherEquityController,
      super.key,});

  final TextEditingController equityNameController;
  final TextEditingController otherEquityController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: equityNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.equityName}*',
          onChanged: (value) {
            equityNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: otherEquityController,
          textInputAction: TextInputAction.next,
          text: localization.other,
          onChanged: (value) {
            otherEquityController.text = value!;
          },
        ),
      ],
    );
  }
}
