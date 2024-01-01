import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/gen/assets.gen.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/screen/add_document/add_document_screen.dart';
import 'package:soul_comfort/screen/document_details/document_details.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    super.key,
  });

  final String id;
  final String image;
  final String name;
  final String email;

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  
  String getImage(String name) {
    final localization = AppLocalizations.of(context);
    try{
      final map = {
        localization.bankAccount : Assets.images.bank.path,
        localization.property : Assets.images.property.path,
        localization.tradingAccount : Assets.images.tradingIcon.path,
        localization.otherAssets : Assets.images.otherAssets.path,
        localization.providentFunds : Assets.images.providentFunds.path,
        localization.locker : Assets.images.lockerIcon.path,
        localization.insurance : Assets.images.insuranceIcon.path,
        localization.collectible : Assets.images.collectible.path,
        localization.bond : Assets.images.bond.path,
        localization.p2PLanding : Assets.images.p2PLanding.path,
        localization.privetEquity : Assets.images.privateEquity.path,
      };
      return map[name]!;

    }catch(error) {
      print('error ------------------------- $error');
      return name;
    }
  }

  String getTranslation(String name) {
    final localization = AppLocalizations.of(context);
    try{
      final map = {
        'Bank Account' : localization.bankAccount,
        'Property' : localization.property,
        'Trading Account' : localization.tradingAccount,
        'Other Assets' : localization.otherAssets,
        'Provident Funds' : localization.providentFunds,
        'Locker' : localization.locker,
        'Insurance' : localization.insurance,
        'Collectible' : localization.collectible,
        'Bond' : localization.bond,
        'P2P Landing' : localization.p2PLanding,
        'Privet Equity' : localization.privetEquity,
      };
      return map[name]!;
    }catch(error) {
      return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: Column(
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
            stream: FirebaseFirestore.instance
                .collection('document')
                .doc(widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                if (snapshot.data!.data() != null) {
                  final data =
                      snapshot.data!.data()!['collectionList'] as List;
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
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
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DocumentDetails(
                                      id: widget.id,
                                      image: widget.image,
                                      name: widget.name,
                                      email: widget.email,
                                      title: getTranslation('${data[index]}'),
                                      // index: index,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    getImage(getTranslation('${data[index]!}')),
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      getTranslation('${data[index]!}'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('No data');
                }
              }
              else{
                return const SizedBox();
              }
            },
          ),
          const SizedBox(
            height: 90,
          ),
        ],
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
