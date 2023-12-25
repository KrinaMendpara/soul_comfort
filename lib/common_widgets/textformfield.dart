import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/generated/l10n.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    required this.textInputAction,
    required this.text,
    this.controller,
    this.icon,
    this.showCursor = true,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final String text;
  final IconData? icon;
  final bool showCursor;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        showCursor: showCursor,
        readOnly: readOnly,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSaved: onSaved,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ?? ((readOnly == false) ? (value) {
          if (value == null || value.isEmpty) {
            return localization.pleaseEnterSomeText;
          } else {
            return null; // Validation passed
          }
        } : null),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          enabled: enabled,
          isDense: true,
          label: Text(
            text,
            style: const TextStyle(
              color: blackColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: blackColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: blackColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: blackColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: greenColor),
          ),
          suffixIcon:icon !=null?Icon(icon):null,
        ),
      ),
    );
  }
}
