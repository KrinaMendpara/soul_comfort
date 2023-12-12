import 'package:flutter/material.dart';

class DetailsImageList extends StatelessWidget {
  const DetailsImageList({required this.image, required this.itemCount, super.key});

  final String image;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          // width: MediaQuery.of(context).size.width - 30,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                image,
              ),
            ),
          ),
        );
      },
    );
  }
}
