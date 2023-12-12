import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddPropertyDetails extends StatelessWidget {
  const AddPropertyDetails(
      {required this.residentNameController,
      required this.residentAddressController,
      super.key,});

  final TextEditingController residentNameController;
  final TextEditingController residentAddressController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: residentNameController,
          textInputAction: TextInputAction.next,
          text: localization.residentName,
          onChanged: (value) {
            residentNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: residentAddressController,
          textInputAction: TextInputAction.next,
          text: localization.residentAddress,
          onChanged: (value) {
            residentAddressController.text = value!;
          },
        ),
      ],
    );
  }
}
