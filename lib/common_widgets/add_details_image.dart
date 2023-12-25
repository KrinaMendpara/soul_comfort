
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

  final File? image;
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
                    image: image!.path,
                    openPDF: image!.path.contains('.jpg') ? false : true,
                  ),
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: image!.path.contains('.jpg') ? null :  Border.all(
                  color: blackColor,
                ),
                color: greenColor.withOpacity(0.1),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image!.path.contains('.jpg')
                      ? FileImage(
                    image!,
                  ): const AssetImage(
                          'assets/images/Pdf.jpg',
                        ) as ImageProvider,
                ),
              ),
              // child: isLoadingImage ? Indicator() : ((image!.contains('.jpg'))
              //     ? Image.network(
              //   image!,
              //   fit: BoxFit.fill,
              // ) : Image.asset(
              //   'assets/images/Pdf.jpg',
              //   fit: BoxFit.fill,
              // )),
            ),
          ),
          Positioned(
            right: 5,
            top: -6,
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                'assets/icons/remove_icon.png',
                height: 15,
                width: 15,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
