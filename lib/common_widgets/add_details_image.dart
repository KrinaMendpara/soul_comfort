
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/gen/assets.gen.dart';

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
          if (image!.contains('.jpg'))
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: greenColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: image!,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      color: greenColor,
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: blackColor,
                ),
                color: greenColor.withOpacity(0.1),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    Assets.images.pdf.path,
                  ),
                ),
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
