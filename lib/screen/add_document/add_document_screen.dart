
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/screen/add_document_details/add_document_details.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({
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
  final String email;
  final bool firstProfile;

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {

  @override
  Widget build(BuildContext context) {
    final localization  = AppLocalizations.of(context);

    final documentList = <String>[
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


    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          localization.addDocument,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
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
          Expanded(
            child: ListView.builder(
              itemCount: documentList.length,
              itemBuilder: (context, index) {
                return Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: greenColor.withOpacity(0.1),
                        child: Image.asset(
                          'assets/icons/document.png',
                          height: 16,
                          width: 14,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            documentList[index],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: greenColor.withOpacity(0.1),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: greenColor,
                            ),
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddDocumentDetails(
                                    id: widget.id,
                                    titleName: documentList[index],
                                    image: widget.image,
                                    name: widget.name,
                                    email: widget.email,
                                    index: index,
                                    firstProfile: widget.firstProfile,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
