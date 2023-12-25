import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/p2p_landing.dart';

class P2PLandingDetails extends StatelessWidget {
  const P2PLandingDetails({
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
                .collection('P2P Landing')
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
                final p2pLanding = P2PLanding.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.name,
                      value: p2pLanding.p2PLanding!,
                    ),
                    DetailsText(
                      name: localization.other,
                      value: p2pLanding.others!,
                    ),
                    if (p2pLanding.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: p2pLanding.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: p2pLanding.images ?? [],
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
            return const Text('No P2P Landing data');
          }
        },
      ),
    );
  }
}
