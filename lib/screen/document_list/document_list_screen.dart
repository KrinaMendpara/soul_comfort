import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/screen/add_document/add_document_screen.dart';
import 'package:soul_comfort/screen/document_details/document_details.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.firstProfile,
    super.key,
  });

  final String id;
  final String image;
  final String name;
  final bool firstProfile;
  final String email;

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    final documentName = <String>[
      localization.bankAccount,
      localization.property,
      localization.tradingAccount,
      localization.otherAssets,
      localization.providentFunds,
      localization.locker,
      localization.insurance,
      localization.collectible,
      localization.bond,
      localization.p2PLanding,
      localization.privetEquity,
    ];

    final documentImage = <String>[
      'assets/images/bank.png',
      'assets/images/property.png',
      'assets/images/Trading_icon.png',
      'assets/images/other assets.webp',
      'assets/images/Provident Funds 2.png',
      'assets/images/Locker_icon.png',
      'assets/images/Insurance_icon.png',
      'assets/images/Collectible.png',
      'assets/images/Bond.webp',
      'assets/images/P2P Landing 2.png',
      'assets/images/Private Equity 1.png',
    ];
    final currentUser = FirebaseAuth.instance.currentUser!;

    final id = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('userData')
        .doc(currentUser.phoneNumber)
        .collection('other Profile')
        .doc()
        .id;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonProfileView(
                userImage: widget.image,
                userName: widget.name,
                userEmail: widget.email,
              ),
            ),
            StreamBuilder(
              stream: (widget.firstProfile == true)
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser.uid)
                      .collection('userData')
                      .doc(currentUser.phoneNumber)
                      .collection('document')
                      .doc('document')
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
                      .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);
                print(snapshot.data);
                print(snapshot.data!.id.length);
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10,),
                        itemCount: documentName.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (ctx, index) {
                          print(snapshot.data!.reference
                              .collection(documentName[index]),);
                          print(snapshot.data!.reference
                              .collection(documentName[index])
                              .doc(),);
                          final data = snapshot.data!.reference
                              .collection(documentName[index])
                              .doc();

                          print('------------------------');
                          print(data.snapshots());
                          print(data.snapshots().length);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Container(
                              // height: 150,
                              // width: 150,
                              padding: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: cloudyGreyColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: blackColor.withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentDetails(
                                        id: widget.id,
                                        image: widget.image,
                                        name: widget.name,
                                        email: widget.email,
                                        title: documentName[index],
                                        index: index,
                                        firstProfile: widget.firstProfile,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      documentImage[index],
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        documentName[index],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: CommonButton(
          name: '+ ${localization.addDocument}',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDocumentScreen(
                  id: widget.id,
                  image: widget.image,
                  email: widget.email,
                  name: widget.name,
                  firstProfile: widget.firstProfile,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
