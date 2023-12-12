import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/bank_account.dart';

class BankAccountDetails extends StatelessWidget {
  const BankAccountDetails({
    required this.id,
    required this.firstProfile,
    super.key,
  });

  final bool firstProfile;
  final String id;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final currentUser = FirebaseAuth.instance.currentUser!;
    print('-==-=-=-=-=-=-==-=-=-=-=-=-=-=--');
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
                .collection(localization.bankAccount)
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
                .collection(localization.bankAccount)
                .snapshots(),
        builder: (context, snapshot) {
          print('data--------------');
          print(snapshot);
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data?.docs[index].data();
                    final bankAccountModel = BankAccount.fromJson(data!);
                    print(snapshot.data!.docs.length);
                    print('---------------------');
                    return Column(
                      children: [
                        DetailsText(
                          name: localization.bankName,
                          value: bankAccountModel.bankName!,
                        ),
                        DetailsText(
                          name: localization.accountNumber,
                          value: bankAccountModel.accountNumber!,
                        ),
                        DetailsText(
                          name: localization.accountName,
                          value: bankAccountModel.accountType!,
                        ),
                        DetailsText(
                          name: localization.iFSCCode,
                          value: bankAccountModel.ifscCode!,
                        ),
                        DetailsText(
                          name: localization.branchName,
                          value: bankAccountModel.branchName!,
                        ),
                        DetailsText(
                          name: localization.notes,
                          value: bankAccountModel.notes!,
                        ),
                        DetailsImageList(
                          itemCount: bankAccountModel.images!.length,
                          image: bankAccountModel.images![index],
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
