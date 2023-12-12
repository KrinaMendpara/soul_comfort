import 'package:flutter/material.dart';

class SelectProfilePic extends StatelessWidget {
  const SelectProfilePic({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String title;
  final String icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
            child: Image.asset(
              icon,
              width: 30,
              height: 30,
            ),
          ),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
