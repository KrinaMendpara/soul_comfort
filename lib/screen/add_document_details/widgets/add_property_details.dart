import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';

class AddPropertyDetails extends StatefulWidget {
  const AddPropertyDetails({
    required this.propertyNameController,
    required this.propertyAddressController,
    required this.percentageOfOwnerController,
    required this.pinCodeController,
    super.key,
  });

  final TextEditingController propertyNameController;
  final TextEditingController propertyAddressController;
  final TextEditingController percentageOfOwnerController;
  final TextEditingController pinCodeController;

  @override
  State<AddPropertyDetails> createState() => _AddPropertyDetailsState();
}

class _AddPropertyDetailsState extends State<AddPropertyDetails> {
  var _groupValue = 0;
  bool partialOwner = false;

  @override
  void initState() {
    widget.percentageOfOwnerController.text = '100 %';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      children: [
        CommonTextFormField(
          controller: widget.propertyNameController,
          textInputAction: TextInputAction.next,
          text: '${localization.propertyName}*',
        ),
        CommonTextFormField(
          controller: widget.propertyAddressController,
          textInputAction: TextInputAction.next,
          text: '${localization.propertyAddress}*',
        ),
        CommonTextFormField(
          controller: widget.pinCodeController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          text: '${localization.pinCode}*',
          validator: (value) {
            if (value!.isEmpty) {
              return localization.pleaseEnterPinCodeNumber;
            } else if (value.length < 6) {
              return localization.pleaseEnterValidPinCodeNumber;
            } else if (value.length > 6) {
              return localization.pinCodeNumberShouldBeOf6Digit;
            }
          },

        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                value: 0,
                groupValue: _groupValue,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  localization.fullOwner,
                ),
                onChanged: (value) {
                  setState(() {
                    _groupValue = value!;
                    partialOwner = false;
                    widget.percentageOfOwnerController.text = '100 %';
                  });
                },
                activeColor: greenColor,
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: 1,
                groupValue: _groupValue,
                title: Text(
                  localization.halfOwner,
                ),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value!;
                    partialOwner = false;
                    widget.percentageOfOwnerController.text = '50 %';
                  });
                },
                activeColor: greenColor,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                value: 2,
                groupValue: _groupValue,
                title: Text(
                  localization.partialOwner,
                ),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value!;
                    partialOwner = true;
                  });
                },
                activeColor: greenColor,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            if (partialOwner)
              Expanded(
                child: CommonTextFormField(
                  controller: widget.percentageOfOwnerController,
                  text: localization.percentage,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      widget.percentageOfOwnerController.text = value!;
                    });
                  },
                  onSaved: (value) {
                    widget.percentageOfOwnerController.text = '$value %';
                  },
                  validator: (value) {
                    if (value!.isEmpty) return localization.pleaseEnterPercentage;
                  },
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ],
    );
  }
}
