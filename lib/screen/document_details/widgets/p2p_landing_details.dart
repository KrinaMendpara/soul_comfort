import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/p2p_landing.dart';

class P2PLandingDetails extends StatelessWidget {
  const P2PLandingDetails({
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
                .collection(localization.p2PLanding)
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
                .collection(localization.p2PLanding)
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
                        DetailsText(
                          name: localization.notes,
                          value: p2pLanding.notes!,
                        ),
                        DetailsImageList(
                          itemCount: p2pLanding.images!.length,
                          image: p2pLanding.images![index],
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
