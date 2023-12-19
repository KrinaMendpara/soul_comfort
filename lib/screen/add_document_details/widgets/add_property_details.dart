import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddPropertyDetails extends StatelessWidget {
  const AddPropertyDetails(
      {required this.propertyNameController,
      required this.propertyAddressController,
      super.key,});

  final TextEditingController propertyNameController;
  final TextEditingController propertyAddressController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: propertyNameController,
          textInputAction: TextInputAction.next,
          text: localization.propertyName,
          onChanged: (value) {
            propertyNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: propertyAddressController,
          textInputAction: TextInputAction.next,
          text: localization.propertyAddress,
          onChanged: (value) {
            propertyAddressController.text = value!;
          },
        ),
      ],
    );
  }
}
