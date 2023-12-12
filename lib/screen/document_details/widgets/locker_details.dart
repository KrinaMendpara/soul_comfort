import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/locker.dart';

class LockerDetails extends StatelessWidget {
  const LockerDetails({
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
                .collection(localization.locker)
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
                .collection(localization.locker)
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
                    final locker = Locker.fromJson(data);
                    return Column(
                      children: [
                        DetailsText(
                          name: localization.name,
                          value: locker.lockerName!,
                        ),
                        DetailsText(
                          name: localization.address,
                          value: locker.lockerAddress!,
                        ),
                        DetailsText(
                          name: localization.notes,
                          value: locker.notes!,
                        ),
                        DetailsImageList(
                          itemCount: locker.images!.length,
                          image: locker.images![index],
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
