import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddOtherAssetsDetails extends StatelessWidget {
  const AddOtherAssetsDetails(
      {required this.nameController,
      required this.detailsController,
      super.key,});

  final TextEditingController nameController;
  final TextEditingController detailsController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: nameController,
          textInputAction: TextInputAction.next,
          text: '${localization.name}*',
          onChanged: (value) {
            nameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: detailsController,
          textInputAction: TextInputAction.next,
          text: '${localization.name}*',
          onChanged: (value) {
            detailsController.text = value!;
          },
        ),
      ],
    );
  }
}
