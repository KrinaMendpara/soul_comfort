import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/trading_account.dart';

class TradingAccountDetails extends StatelessWidget {
  const TradingAccountDetails({
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
                .collection('trading account')
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
                .collection('trading account')
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
                final tradingAccount = TradingAccount.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.stock,
                      value: tradingAccount.stock!,
                    ),
                    DetailsText(
                      name: localization.mutualFunds,
                      value: tradingAccount.mutualFunds!,
                    ),
                    if (tradingAccount.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: tradingAccount.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: tradingAccount.images ?? [],
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
            return const Text('No Trading Account data');
          }
        },
      ),
    );
  }
}
