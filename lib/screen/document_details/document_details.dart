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
    required this.title,
    super.key,
  });

  final String id;
  final String? image;
  final String name;
  final String email;
  final String title;

   Widget? getDetails(BuildContext context) {
    final localization = AppLocalizations.of(context);
    try{
      final map = {
        localization.bankAccount : BankAccountDetails(id: id),
        localization.property : PropertyDetails(id : id),
        localization.tradingAccount : TradingAccountDetails(id: id),
        localization.otherAssets : OtherAssetsDetails(id: id),
        localization.providentFunds : ProvidentFundsDetails(id: id),
        localization.locker : LockerDetails(id: id),
        localization.insurance : InsuranceDetails(id: id),
        localization.collectible : CollectibleDetails(id: id),
        localization.bond : BondDetails(id: id),
        localization.p2PLanding : P2PLandingDetails(id: id),
        localization.privetEquity : PrivetEquityDetails(id: id),
      };
      return map[title]!;
    }catch(error) {
      print('Get Details Widget Error ------------------------- $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    print('$title ${localization.details}');
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
            child: getDetails(context)!,
          ),
        ],
      ),
    );
  }
}
