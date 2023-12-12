import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddBankAccount extends StatelessWidget {
  const AddBankAccount(
      {required this.bankNameController,
      required this.accountTypeController,
      required this.accountNumberController,
      required this.ifscCodeController,
      required this.branchNameController,
      super.key,});

  final TextEditingController bankNameController;
  final TextEditingController accountTypeController;
  final TextEditingController accountNumberController;
  final TextEditingController ifscCodeController;
  final TextEditingController branchNameController;

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    return Column(
      children: [
        CommonTextFormField(
          controller: bankNameController,
          textInputAction: TextInputAction.next,
          text: localization.bankName,
          onChanged: (value) {
            bankNameController.text = value!;
          },
          onSaved: (value) {
            bankNameController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: accountTypeController,
          textInputAction: TextInputAction.next,
          text: localization.accountName,
          onChanged: (value) {
            accountTypeController.text = value!;
          },
          onSaved: (value) {
            accountTypeController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: accountNumberController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          text: localization.accountNumber,
          onChanged: (value) {
            accountNumberController.text = value!;
          },
          onSaved: (value) {
            accountNumberController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: ifscCodeController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          text: localization.iFSCCode,
          onChanged: (value) {
            ifscCodeController.text = value!;
          },
          onSaved: (value) {
            ifscCodeController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: branchNameController,
          textInputAction: TextInputAction.next,
          text: localization.branchName,
          onChanged: (value) {
            branchNameController.text = value!;
          },
          onSaved: (value) {
            branchNameController.text = value!;
          },
        ),
      ],
    );
  }
}
