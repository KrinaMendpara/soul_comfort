import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/bond.dart';

class BondDetails extends StatelessWidget {
  const BondDetails({
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
                .collection('Bond')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index].data();
                final bonds = Bonds.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.bondName,
                      value: bonds.bondName,
                    ),
                    DetailsText(
                      name: localization.bondDetails,
                      value: bonds.bondDetails,
                    ),
                    if (bonds.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: bonds.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: bonds.images ?? [],
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
            return const Text('No Bond data');
          }
        },
      ),
    );
  }
}
