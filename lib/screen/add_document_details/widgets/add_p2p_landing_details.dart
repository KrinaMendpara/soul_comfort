import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddP2PLandingDetails extends StatelessWidget {
  const AddP2PLandingDetails(
      {required this.p2pLandingNameController,
      required this.otherP2PLandingController,
      super.key,});

  final TextEditingController p2pLandingNameController;
  final TextEditingController otherP2PLandingController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);
    return Column(
      children: [
        CommonTextFormField(
          controller: p2pLandingNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.p2PLanding}*',
          onChanged: (value) {
            p2pLandingNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: otherP2PLandingController,
          textInputAction: TextInputAction.next,
          text: localization.other,
          onChanged: (value) {
            otherP2PLandingController.text = value!;
          },
        ),
      ],
    );
  }
}
