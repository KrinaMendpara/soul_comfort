import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/other_assets.dart';

class OtherAssetsDetails extends StatelessWidget {
  const OtherAssetsDetails({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
                .collection('document')
                .doc(id)
                .collection('Other Assets')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index].data();
                final otherAssets = OtherAssets.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.type,
                      value: otherAssets.name!,
                    ),
                    DetailsText(
                      name: localization.details,
                      value: otherAssets.details!,
                    ),
                    if (otherAssets.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: otherAssets.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: otherAssets.images ?? [],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: blackColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Text('No Other Assets data');
          }
        },
      ),
    );
  }
}
