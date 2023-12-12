import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddTradingAccountDetails extends StatelessWidget {
  const AddTradingAccountDetails({required this.stockController, required this.mutualFundsController, super.key});
  final TextEditingController stockController;
  final TextEditingController mutualFundsController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);
    return Column(
      children: [
        CommonTextFormField(
          controller: stockController,
          textInputAction: TextInputAction.next,
          text: localization.stock,
          onChanged: (value) {
            stockController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: mutualFundsController,
          textInputAction: TextInputAction.next,
          text: localization.mutualFunds,
          onChanged: (value) {
            mutualFundsController.text = value!;
          },
        ),
      ],
    );
  }
}
