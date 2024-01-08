import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddProvidentFundsDetails extends StatelessWidget {
  const AddProvidentFundsDetails({
    required this.epfController,
    required this.ppfController,
    required this.uanController,
    super.key,
  });

  final TextEditingController epfController;
  final TextEditingController uanController;
  final TextEditingController ppfController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: epfController,
          textInputAction: TextInputAction.next,
          text: localization.ePF,
          onChanged: (value) {
            epfController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: ppfController,
          textInputAction: TextInputAction.next,
          text: localization.pPF,
          onChanged: (value) {
            ppfController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: uanController,
          textInputAction: TextInputAction.next,
          text: localization.uAN,
          onChanged: (value) {
            uanController.text = value!;
          },
        ),
      ],
    );
  }
}
