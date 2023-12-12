import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/screen/open_image/open_image_screen.dart';

class AddDetailsImage extends StatelessWidget {
  const AddDetailsImage({
    required this.image,
    this.onTap,
    super.key,
  });

  final String? image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenImageScreen(
                    image: image!,
                    openPDF: (image!.contains('.jpg') == false) ? true : false,
                  ),
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: (image!.contains('.jpg') == false) ? Border.all(
                  color: blackColor,
                ) : null,
                color: greenColor.withOpacity(0.1),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (image!.contains('.jpg') == false)
                      ? const AssetImage(
                          'assets/images/Pdf.jpg',
                        ) as ImageProvider
                      : NetworkImage(
                          image!,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: -9,
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                'assets/icons/cancel.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
