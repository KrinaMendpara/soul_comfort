import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/privet_equity.dart';

class PrivetEquityDetails extends StatelessWidget {
  const PrivetEquityDetails({
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
                .collection('Privet Equity')
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
                final privetEquity = PrivetEquity.fromJson(data);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.privetEquityName,
                      value: privetEquity.equityName!,
                    ),
                    DetailsText(
                      name: localization.other,
                      value: privetEquity.others!,
                    ),
                    if (privetEquity.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: privetEquity.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: privetEquity.images ?? [],
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
            return const Text('No Privet Equity data');
          }
        },
      ),
    );
  }
}
