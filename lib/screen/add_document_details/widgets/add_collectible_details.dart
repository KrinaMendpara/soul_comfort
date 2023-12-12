import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddCollectibleDetails extends StatelessWidget {
  const AddCollectibleDetails({required this.artController, required this.nftController, super.key});
  final TextEditingController artController;
  final TextEditingController nftController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: artController,
          textInputAction: TextInputAction.next,
          text: localization.aRT,
          onChanged: (value) {
            artController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: nftController,
          textInputAction: TextInputAction.next,
          text: localization.nFT,
          onChanged: (value) {
            nftController.text = value!;
          },
        ),
      ],
    );
  }
}
