import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    required this.onTap,
    this.name,
    this.widget,
    super.key,
  });

  final String? name;
  final Widget? widget;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: widget ??
              Text(
                name!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}
