import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/screen/document_details/widgets/bank_account_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/bond_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/collectible_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/insurance_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/locker_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/other_assets_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/p2p_landing_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/privet_equity_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/property_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/provident_funds_details.dart';
import 'package:soul_comfort/screen/document_details/widgets/trading_account_details.dart';

class DocumentDetails extends StatelessWidget {
  const DocumentDetails({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.firstProfile,
    required this.title,
    required this.index,
    super.key,
  });

  final String id;
  final String image;
  final String name;
  final bool firstProfile;
  final String email;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    final detailsWidget = <Widget>[
      BankAccountDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      PropertyDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      TradingAccountDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      OtherAssetsDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      ProvidentFundsDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      LockerDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      InsuranceDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      CollectibleDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      BondDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      P2PLandingDetails(
        id: id,
        firstProfile: firstProfile,
      ),
      PrivetEquityDetails(
        id: id,
        firstProfile: firstProfile,
      ),
    ];

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          '$title ${localization.details}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CommonProfileView(
              userImage: image,
              userName: name,
              userEmail: email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '$title ${localization.details}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: detailsWidget[index],
          ),
        ],
      ),
    );
  }
}
