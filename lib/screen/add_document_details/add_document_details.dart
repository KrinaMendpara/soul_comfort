import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/add_details_image.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/common_widgets/select_profilepic.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/bank_account.dart';
import 'package:soul_comfort/model/bond.dart';
import 'package:soul_comfort/model/collectible.dart';
import 'package:soul_comfort/model/insurance.dart';
import 'package:soul_comfort/model/locker.dart';
import 'package:soul_comfort/model/other_assets.dart';
import 'package:soul_comfort/model/p2p_landing.dart';
import 'package:soul_comfort/model/privet_equity.dart';
import 'package:soul_comfort/model/property.dart';
import 'package:soul_comfort/model/provident_funds.dart';
import 'package:soul_comfort/model/trading_account.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_bank_account.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_bond_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_collectible_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_insurance_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_locker_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_other_assets_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_p2p_landing_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_privet_equity_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_property_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_provident_funds_details.dart';
import 'package:soul_comfort/screen/add_document_details/widgets/add_trading_account_details.dart';

class AddDocumentDetails extends StatefulWidget {
  const AddDocumentDetails({
    required this.id,
    required this.titleName,
    required this.image,
    required this.name,
    required this.email,
    required this.index,
    required this.firstProfile,
    super.key,
  });

  final String id;
  final String titleName;
  final String image;
  final String name;
  final String email;
  final bool firstProfile;
  final int index;

  @override
  State<AddDocumentDetails> createState() => _AddDocumentDetailsState();
}

class _AddDocumentDetailsState extends State<AddDocumentDetails> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  TextEditingController stockController = TextEditingController();
  TextEditingController mutualFundsController = TextEditingController();

  TextEditingController residentNameController = TextEditingController();
  TextEditingController residentAddressController = TextEditingController();

  TextEditingController epfController = TextEditingController();
  TextEditingController ppfController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  TextEditingController lockerNameController = TextEditingController();
  TextEditingController lockerAddressController = TextEditingController();

  TextEditingController insuranceNameController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  TextEditingController bondNameController = TextEditingController();
  TextEditingController bondDetailsController = TextEditingController();

  TextEditingController artController = TextEditingController();
  TextEditingController nftController = TextEditingController();

  TextEditingController equityNameController = TextEditingController();
  TextEditingController otherEquityController = TextEditingController();

  TextEditingController p2pLandingNameController = TextEditingController();
  TextEditingController otherP2PLandingController = TextEditingController();

  String? images;
  String? dataImage;
  var url;
  List<String> listImage = [];

  final ImagePicker picker = ImagePicker();
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  final currentUser = FirebaseAuth.instance.currentUser!;
  Users? users;

  Future<void> _pickImageFromCamera() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50
    );
    Navigator.pop(context);

    images = pickedImageFile!.path;
    dataImage = pickedImageFile.path.split('/').last;

    final ref = (widget.firstProfile == true)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser.uid)
            .child('documentImage')
            .child(widget.titleName)
            .child(dataImage!)
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser.uid)
            .child('Other_Profile_Image')
            .child('documentImage')
            .child(widget.titleName)
            .child(dataImage!);
    await ref.putFile(File(images!));

    url = await ref.getDownloadURL();
    listImage.add(url.toString());

    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    Navigator.pop(context);

    images = pickedImageFile!.path;
    dataImage = pickedImageFile.path.split('/').last;
    final ref = (widget.firstProfile == true)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser.uid)
            .child('documentImage')
            .child(widget.titleName)
            .child(dataImage!)
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser.uid)
            .child('Other_Profile_Image')
            .child('documentImage')
            .child(widget.titleName)
            .child(dataImage!);
    await ref.putFile(File(images!));

    url = await ref.getDownloadURL();
    listImage.add(url.toString());

    // await UploadImageStorage.documentImageStorage(
    //     dataImage!, widget.firstProfile, widget.titleName,);

    setState(() {});
  }

  Future<void> _pickedPdfFile() async {
    final pickedFile = await FilePicker.platform.pickFiles();

    setState(() {
      images = pickedFile!.files.first.path;
    });
    dataImage = pickedFile!.files.first.path!.split('/').last;
    Navigator.pop(context);

    try {
      final ref = (widget.firstProfile)
          ? FirebaseStorage.instance
              .ref()
              .child('User_Image')
              .child(currentUser.uid)
              .child('documentImage')
              .child(widget.titleName)
              .child(dataImage!)
          : FirebaseStorage.instance
              .ref()
              .child('User_Image')
              .child(currentUser.uid)
              .child('Other_Profile_Image')
              .child('documentImage')
              .child(widget.titleName)
              .child(dataImage!);
      await ref.putFile(File(images!), SettableMetadata(contentType: 'pdf'));

      url = await ref.getDownloadURL();
      listImage.add(url.toString());
      return url;
    } catch (e) {
      return;
    }
  }

  Future<void> _showModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        final localization = AppLocalizations.of(context);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 260,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    localization.chooseOption,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectProfilePic(
                    title: localization.camera,
                    icon: 'assets/icons/camera.png',
                    onTap: _pickImageFromCamera,
                  ),
                  SelectProfilePic(
                    icon: 'assets/icons/gallery.png',
                    title: localization.uploadFromGallery,
                    onTap: _pickImageFromGallery,
                  ),
                  SelectProfilePic(
                    icon: 'assets/icons/doc.png',
                    title: localization.document,
                    onTap: _pickedPdfFile,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/icons/cancel.png',
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> bankDetails() {
    final bankData = BankAccount(
      id: id,
      bankName: bankNameController.text,
      accountNumber: accountNumberController.text,
      accountType: accountTypeController.text,
      branchName: branchNameController.text,
      ifscCode: ifscCodeController.text,
      notes: notesController.text,
      images: listImage,
    );
    return bankData.toJson();
  }

  Map<String, dynamic> propertyDetails() {
    final propertyDetails = Property(
      id: id,
      images: listImage,
      residentAddress: residentAddressController.text,
      residentName: residentNameController.text,
      notes: notesController.text,
    );
    return propertyDetails.toJson();
  }

  Map<String, dynamic> tradingDetails() {
    final tradingDetails = TradingAccount(
      id: id,
      stock: stockController.text,
      mutualFunds: mutualFundsController.text,
      notes: notesController.text,
      images: listImage,
    );
    return tradingDetails.toJson();
  }

  Map<String, dynamic> otherAssetsDetails() {
    final otherAssets = OtherAssets(
      id: id,
      name: nameController.text,
      details: detailsController.text,
      notes: notesController.text,
      images: listImage,
    );
    return otherAssets.toJson();
  }

  Map<String, dynamic> providentFundsDetails() {
    final providentFunds = ProvidentFunds(
      id: id,
      ppfName: ppfController.text,
      epfName: epfController.text,
      notes: notesController.text,
      images: listImage,
    );
    return providentFunds.toJson();
  }

  Map<String, dynamic> lockerDetails() {
    final locker = Locker(
      id: id,
      lockerName: lockerNameController.text,
      lockerAddress: lockerAddressController.text,
      notes: notesController.text,
      images: listImage,
    );
    return locker.toJson();
  }

  Map<String, dynamic> insuranceDetails() {
    final insurance = Insurance(
      id: id,
      insuranceName: insuranceNameController.text,
      other: otherController.text,
      notes: notesController.text,
      images: listImage,
    );
    return insurance.toJson();
  }

  Map<String, dynamic> collectibleDetails() {
    final collectible = Collectible(
      id: id,
      nft: nftController.text,
      art: artController.text,
      notes: notesController.text,
      images: listImage,
    );
    return collectible.toJson();
  }

  Map<String, dynamic> bondDetails() {
    final bond = Bonds(
      id: id,
      bondName: bondNameController.text,
      bondDetails: bondDetailsController.text,
      notes: notesController.text,
      images: listImage,
    );
    return bond.toJson();
  }

  Map<String, dynamic> p2pLandingDetails() {
    final p2pLanding = P2PLanding(
      id: id,
      p2PLanding: p2pLandingNameController.text,
      others: otherP2PLandingController.text,
      notes: notesController.text,
      images: listImage,
    );
    return p2pLanding.toJson();
  }

  Map<String, dynamic> privetEquityDetails() {
    final privetEquity = PrivetEquity(
      id: id,
      equityName: equityNameController.text,
      others: otherEquityController.text,
      notes: notesController.text,
      images: listImage,
    );
    return privetEquity.toJson();
  }

  Future<void> submitData(Map<String, dynamic> dataToJson) async {

    (widget.firstProfile == true)
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('userData')
            .doc(currentUser.phoneNumber)
            .collection('document')
            .doc('document')
            .collection(widget.titleName)
            .add(
              dataToJson,
            )
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('userData')
            .doc(currentUser.phoneNumber)
            .collection('other Profile')
            .doc(widget.id)
            .collection('document')
            .doc('document')
            .collection(widget.titleName)
            .add(
              dataToJson,
            );
  }

  @override
  Widget build(BuildContext context) {
    final saveDocumentDetails = <Map<String, dynamic>>[
      bankDetails(),
      propertyDetails(),
      tradingDetails(),
      otherAssetsDetails(),
      providentFundsDetails(),
      lockerDetails(),
      insuranceDetails(),
      collectibleDetails(),
      bondDetails(),
      p2pLandingDetails(),
      privetEquityDetails(),
    ];

    final widgetList = <Widget>[
      AddBankAccount(
        bankNameController: bankNameController,
        branchNameController: branchNameController,
        accountTypeController: accountTypeController,
        accountNumberController: accountNumberController,
        ifscCodeController: ifscCodeController,
      ),
      AddPropertyDetails(
        residentNameController: residentNameController,
        residentAddressController: residentAddressController,
      ),
      AddTradingAccountDetails(
        stockController: stockController,
        mutualFundsController: mutualFundsController,
      ),
      AddOtherAssetsDetails(
        nameController: nameController,
        detailsController: detailsController,
      ),
      AddProvidentFundsDetails(
        epfController: epfController,
        ppfController: ppfController,
      ),
      AddLockerDetails(
        lockerNameController: lockerNameController,
        lockerAddressController: lockerAddressController,
      ),
      AddInsuranceDetails(
        insuranceNameController: insuranceNameController,
        otherController: otherController,
      ),
      AddCollectibleDetails(
        artController: artController,
        nftController: nftController,
      ),
      AddBondDetails(
        bondNameController: bondNameController,
        bondDetailsController: bondDetailsController,
      ),
      AddP2PLandingDetails(
        p2pLandingNameController: p2pLandingNameController,
        otherP2PLandingController: otherP2PLandingController,
      ),
      AddPrivetEquityDetails(
        equityNameController: equityNameController,
        otherEquityController: otherEquityController,
      ),
    ];

    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          '${widget.titleName} ${localization.add}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            0,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonProfileView(
                userImage: widget.image,
                userName: widget.name,
                userEmail: widget.email,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '${widget.titleName} ${localization.details} ${localization.add}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              widgetList[widget.index],
              CommonTextFormField(
                controller: notesController,
                textInputAction: TextInputAction.done,
                text: localization.notes,
                onChanged: (value) {
                  notesController.text = value!;
                },
              ),
              GestureDetector(
                onTap: _showModalBottomSheet,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/image.png',
                      width: 15,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        localization.image,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(
                  children: [
                    ...List.generate(
                      listImage.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AddDetailsImage(
                          image: listImage[index],
                          onTap: () {
                            setState(() {
                              listImage.remove(listImage[index]);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CommonButton(
                  name: localization.save,
                  onTap: () {
                    print(saveDocumentDetails[widget.index]);
                    print(saveDocumentDetails[widget.index].keys);
                    print(saveDocumentDetails[widget.index].values);
                    print(saveDocumentDetails[widget.index].entries.length);
                    print(saveDocumentDetails[widget.index].keys.length);
                    print('--------------------');
                    submitData(saveDocumentDetails[widget.index]).then((value) {
                      Navigator.pop(context);
                    });
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}