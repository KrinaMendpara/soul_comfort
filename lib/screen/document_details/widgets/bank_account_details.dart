
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/bank_account.dart';

class BankAccountDetails extends StatelessWidget {
  const BankAccountDetails({
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
                .collection('Bank Account')
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
                final data = snapshot.data?.docs[index].data();
                final bankAccount = BankAccount.fromJson(data!);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.bankName,
                      value: bankAccount.bankName!,
                    ),
                    DetailsText(
                      name: localization.accountNumber,
                      value: bankAccount.accountNumber!,
                    ),
                    DetailsText(
                      name: localization.iFSCCode,
                      value: bankAccount.ifscCode!,
                    ),
                    DetailsText(
                      name: localization.accountType,
                      value: bankAccount.accountType!,
                    ),
                    DetailsText(
                      name: localization.branchName,
                      value: bankAccount.branchName!,
                    ),
                    if (bankAccount.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: bankAccount.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: bankAccount.images,
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
            return const Text('No Bank data');
          }
        },
      ),
    );
  }
}
