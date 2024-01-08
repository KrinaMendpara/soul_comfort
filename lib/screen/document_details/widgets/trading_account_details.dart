import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/trading_account.dart';

class TradingAccountDetails extends StatelessWidget {
  const TradingAccountDetails({
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
                .collection('Trading Account')
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
                final tradingAccount = TradingAccount.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.stock,
                      value: tradingAccount.stock,
                    ),
                    DetailsText(
                      name: localization.mutualFunds,
                      value: tradingAccount.mutualFunds,
                    ),
                    if (tradingAccount.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: tradingAccount.notes!,
                      )
                    else
                      const SizedBox(),
                    // if(tradingAccount.images.length)
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
