import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/insurance.dart';

class InsuranceDetails extends StatelessWidget {
  const InsuranceDetails({
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
                .collection('insurance')
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
                .collection('insurance')
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
                final insurance = Insurance.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.insuranceName,
                      value: insurance.insuranceName!,
                    ),
                    DetailsText(
                      name: localization.other,
                      value: insurance.other!,
                    ),
                    if (insurance.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: insurance.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: insurance.images ?? [],
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
            return const Text('No Insurance data');
          }
        },
      ),
    );
  }
}
