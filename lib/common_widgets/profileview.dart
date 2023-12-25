import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';

class CommonProfileView extends StatelessWidget {
  const CommonProfileView({
    required this.userImage,
    required this.userName,
    required this.userEmail,
    this.height = 66,
    this.width = 66,
    super.key,
  });

  final String userImage;
  final String userName;
  final String userEmail;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (userImage.contains('jpg'))
                        ? NetworkImage(
                            userImage,
                          )
                        : const AssetImage(
                            'assets/images/profile_picture.jpg',
                          ) as ImageProvider,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
                Text(
                  userEmail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(
          color: blackColor,
          thickness: 1,
        ),
      ],
    );
  }
}
