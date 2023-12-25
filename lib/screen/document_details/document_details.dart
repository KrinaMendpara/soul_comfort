import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/property.dart';
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

class DocumentDetails extends StatefulWidget {
  const DocumentDetails({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.title,
    // required this.index,
    super.key,
  });

  final String id;
  final String image;
  final String name;
  final String email;
  final String title;

  @override
  State<DocumentDetails> createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  String? titleName;
  Widget? data;

  Widget? details() {
    // final localization = AppLocalizations.of(context);
    switch (widget.title) {
      case 'Bank Account':
        data = BankAccountDetails(id: widget.id);
      case 'Property':
        data = PropertyDetails(id: widget.id);
      case 'Trading Account':
        data = TradingAccountDetails(id: widget.id);
      case 'Other Assets':
        data = OtherAssetsDetails(id: widget.id);
      case 'Provident Funds':
        data = ProvidentFundsDetails(id: widget.id);
      case 'Locker':
        data = LockerDetails(id: widget.id);
      case 'Insurance':
        data = InsuranceDetails(id: widget.id);
      case 'Collectible':
        data = CollectibleDetails(id: widget.id);
      case 'Bond':
        data = BondDetails(id: widget.id);
      case 'P2P Landing':
        data = P2PLandingDetails(id: widget.id);
      case 'Privet Equity':
        data = PrivetEquityDetails(id: widget.id);
      default:
        data = BankAccountDetails(id: widget.id);
        break;
    }
    setState(() {});
    return data;
  }

  @override
  void initState() {
    details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          '${widget.title} ${localization.details}',
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
              userImage: widget.image,
              userName: widget.name,
              userEmail: widget.email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${widget.title} ${localization.details}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: details()!,
          ),
        ],
      ),
    );
  }
}
