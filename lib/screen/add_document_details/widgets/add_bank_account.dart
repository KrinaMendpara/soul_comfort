import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({
    required this.bankNameController,
    required this.accountTypeController,
    required this.accountNumberController,
    required this.ifscCodeController,
    required this.branchNameController,
    super.key,
  });

  final TextEditingController bankNameController;
  final TextEditingController accountTypeController;
  final TextEditingController accountNumberController;
  final TextEditingController ifscCodeController;
  final TextEditingController branchNameController;

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final accountTypes = <String>[
      localization.savingAccount,
      localization.currentAccount,
      localization.fixedDepositAccount,
    ];
    String? selectedAccountType;
    return Column(
      children: [
        CommonTextFormField(
          controller: widget.bankNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.bankName}*',
          onChanged: (value) {
            widget.bankNameController.text = value!;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: DropdownButtonFormField(
            items: accountTypes.map((String accountType) {
              return DropdownMenuItem<String>(
                value: accountType,
                child: Text(
                  accountType,
                ),
              );
            }).toList(),
            borderRadius: BorderRadius.circular(3),
            value: selectedAccountType,
            onChanged: (value) {
              selectedAccountType = value;
              widget.accountTypeController.text = value!;
              print(widget.accountTypeController.text);
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              label: Text(
                '${localization.accountType}*',
                style: const TextStyle(
                  color: blackColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(
                  color: greenColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            validator: (value) {
              print(value);
              if (value == null) {
                return localization.pleaseSelectAccountType;
              } else {
                return null;
              }
            },
          ),
        ),
        CommonTextFormField(
          controller: widget.accountNumberController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return localization.pleaseEnterSomeNumber;
            } else if (value.isNotEmpty && value.length < 8) {
              return localization.bankAccountNumberShouldBe8Digits;
            }
          },
          text: '${localization.accountNumber}*',
          onChanged: (value) {
            widget.accountNumberController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: widget.ifscCodeController,
          textInputAction: TextInputAction.next,
          text: '${localization.iFSCCode}*',
          validator: (value) {
            if (value!.isEmpty) {
              return localization.pleaseEnterSomeText;
            } else if (value.isNotEmpty && value.length < 10) {
              return localization.ifscCodeShouldBe10Digits;
            }
          },
          onChanged: (value) {
            widget.ifscCodeController.text = value!;
          },
        ),
        CommonTextFormField(
          controller: widget.branchNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.branchName}*',
          onChanged: (value) {
            widget.branchNameController.text = value!;
          },
        ),
      ],
    );
  }
}
