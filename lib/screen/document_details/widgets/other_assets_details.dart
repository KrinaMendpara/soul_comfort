import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/other_assets.dart';

class OtherAssetsDetails extends StatelessWidget {
  const OtherAssetsDetails({
    required this.firstProfile,
    required this.id,
    super.key,
  });

  final String id;
  final bool firstProfile;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    final currentUser = FirebaseAuth.instance.currentUser!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: StreamBuilder(
        stream: (firstProfile == true)
            ? FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .collection('userData')
                .doc(currentUser.phoneNumber)
                .collection('document')
                .doc('document')
                .collection(localization.otherAssets)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .collection('userData')
                .doc(currentUser.phoneNumber)
                .collection('other Profile')
                .doc(id)
                .collection('document')
                .doc('document')
                .collection(localization.otherAssets)
                .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
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
                        DetailsImageList(
                          itemCount: otherAssets.images!.length,
                          image: otherAssets.images![index],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
