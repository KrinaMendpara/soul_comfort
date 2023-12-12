import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/provident_funds.dart';

class ProvidentFundsDetails extends StatelessWidget {
  const ProvidentFundsDetails({
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
                .collection(localization.providentFunds)
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
                .collection(localization.providentFunds)
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
                    final providentFunds = ProvidentFunds.fromJson(data);
                    return Column(
                      children: [
                        DetailsText(
                          name: localization.ePF,
                          value: providentFunds.epfName!,
                        ),
                        DetailsText(
                          name: localization.pPF,
                          value: providentFunds.ppfName!,
                        ),
                        DetailsText(
                          name: localization.notes,
                          value: providentFunds.notes!,
                        ),
                        DetailsImageList(
                          itemCount: providentFunds.images!.length,
                          image: providentFunds.images![index],
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
