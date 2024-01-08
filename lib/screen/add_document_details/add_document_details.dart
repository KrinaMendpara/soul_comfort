import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/add_details_image.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/common_widgets/select_profilepic.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/gen/assets.gen.dart';
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
import 'package:soul_comfort/screen/open_image/open_image_screen.dart';

class AddDocumentDetails extends StatefulWidget {
  const AddDocumentDetails({
    required this.id,
    required this.titleName,
    required this.image,
    required this.name,
    required this.email,
    required this.index,
    super.key,
  });

  final String id;
  final String titleName;
  final String? image;
  final String name;
  final String email;
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

  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyAddressController = TextEditingController();
  TextEditingController percentageOfOwnerController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  TextEditingController epfController = TextEditingController();
  TextEditingController ppfController = TextEditingController();
  TextEditingController uanController = TextEditingController();

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? images;
  String? dataImage;
  String? url;
  List<String> listImageUrl = [];
  List<File> listImage = [];
  List<String?> collectionNameList = [];

  final ImagePicker picker = ImagePicker();
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  Users? users;
  bool _isLoading = false;

  Future<void> _pickImageFromCamera() async {
    final pickedImageFile = await picker
        .pickImage(
      source: ImageSource.camera,
    )
        .whenComplete(() {
      setState(() {
      });
    });

    images = File(pickedImageFile!.path);
    dataImage = pickedImageFile.path.split('/').last;
    Navigator.pop(context);
    listImage.add(images!);
    final ref = FirebaseStorage.instance
        .ref()
        .child('documentImage')
        .child(widget.id)
        .child(collectionName[widget.index])
        .child(dataImage!);
    await ref.putFile(images!).whenComplete(() {});

    url = await ref.getDownloadURL();
    listImageUrl.add('$url');
    setState(() {
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImageFile = await picker
        .pickImage(
      maxHeight: 400,
      preferredCameraDevice: CameraDevice.front,
      source: ImageSource.gallery,
    );
    images = File(pickedImageFile!.path);
    dataImage = pickedImageFile.path.split('/').last;
    listImage.add(images!);
    Navigator.pop(context);

    final ref = FirebaseStorage.instance
        .ref()
        .child('documentImage')
        .child(widget.id)
        .child(collectionName[widget.index])
        .child(dataImage!);
    await ref.putFile(images!).whenComplete(() {});

    url = await ref.getDownloadURL();

    listImageUrl.add('$url');
    setState(() {
    });
  }

  Future<void> _pickedPdfFile() async {
    final pickedFile = await FilePicker.platform.pickFiles().whenComplete(() {
      setState(() {
      });
    });
    images = File(pickedFile!.files.single.path!);
    dataImage = pickedFile.files.single.path!.split('/').last;
    Navigator.pop(context);
    listImage.add(images!);

    final ref = FirebaseStorage.instance
        .ref()
        .child('documentImage')
        .child(widget.id)
        .child(collectionName[widget.index])
        .child(dataImage!);
    await ref
        .putFile(images!, SettableMetadata(contentType: '.pdf'))
        .whenComplete(() {});

    url = await ref.getDownloadURL();
    listImageUrl.add('$url');
    setState(() {
    });
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
                    icon: Assets.icons.camera.path,
                    onTap: _pickImageFromCamera,
                  ),
                  SelectProfilePic(
                    icon: Assets.icons.gallery.path,
                    title: localization.uploadFromGallery,
                    onTap: _pickImageFromGallery,
                  ),
                  SelectProfilePic(
                    icon: Assets.icons.doc.path,
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
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: greenColor.withOpacity(0.2),
                  child: const Icon(
                    Icons.close,
                    color: blackColor,
                  ),
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
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return bankData.toJson();
  }

  Map<String, dynamic> propertyDetails() {
    final propertyDetails = Property(
      id: id,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
      propertyAddress: propertyAddressController.text,
      propertyName: propertyNameController.text,
      percentageOfOwnership: percentageOfOwnerController.text,
      pinCode: pinCodeController.text,
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
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return tradingDetails.toJson();
  }

  Map<String, dynamic> otherAssetsDetails() {
    final otherAssets = OtherAssets(
      id: id,
      name: nameController.text,
      details: detailsController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return otherAssets.toJson();
  }

  Map<String, dynamic> providentFundsDetails() {
    final providentFunds = ProvidentFunds(
      id: id,
      ppfName: ppfController.text,
      epfName: epfController.text,
      uanName: uanController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return providentFunds.toJson();
  }

  Map<String, dynamic> lockerDetails() {
    final locker = Locker(
      id: id,
      lockerName: lockerNameController.text,
      lockerAddress: lockerAddressController.text,
      pinCode: pinCodeController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return locker.toJson();
  }

  Map<String, dynamic> insuranceDetails() {
    final insurance = Insurance(
      id: id,
      insuranceName: insuranceNameController.text,
      other: otherController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return insurance.toJson();
  }

  Map<String, dynamic> collectibleDetails() {
    final collectible = Collectible(
      id: id,
      nft: nftController.text,
      art: artController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return collectible.toJson();
  }

  Map<String, dynamic> bondDetails() {
    final bond = Bonds(
      id: id,
      bondName: bondNameController.text,
      bondDetails: bondDetailsController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return bond.toJson();
  }

  Map<String, dynamic> p2pLandingDetails() {
    final p2pLanding = P2PLanding(
      id: id,
      p2PLanding: p2pLandingNameController.text,
      others: otherP2PLandingController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return p2pLanding.toJson();
  }

  Map<String, dynamic> privetEquityDetails() {
    final privetEquity = PrivetEquity(
      id: id,
      equityName: equityNameController.text,
      others: otherEquityController.text,
      notes: notesController.text,
      images: listImageUrl.isEmpty ? [] : listImageUrl,
    );
    return privetEquity.toJson();
  }

  Future<void> submitData(Map<String, dynamic> dataToJson) async {
    await FirebaseFirestore.instance
        .collection('document')
        .doc(widget.id)
        .collection(collectionName[widget.index])
        .add(
          dataToJson,
        );

    await FirebaseFirestore.instance
        .collection('document')
        .doc(widget.id)
        .get()
        .then((value) {
      if (value.data() != null) {
        final collectionList = ((value.data()!['collectionList']) as List)
            .map((e) => e.toString())
            .toList();
        setState(() {
          collectionNameList = collectionList;
        });
      }
    });
    if (!collectionNameList.contains(collectionName[widget.index])) {
      collectionNameList.add(collectionName[widget.index]);
    }
    await FirebaseFirestore.instance
        .collection('document')
        .doc(widget.id)
        .set({
      'id': widget.id,
      'collectionList': collectionNameList,
    });
  }

  List<String> collectionName = [
    'Bank Account',
    'Property',
    'Trading Account',
    'Other Assets',
    'Provident Funds',
    'Locker',
    'Insurance',
    'Collectible',
    'Bond',
    'P2P Landing',
    'Privet Equity',
  ];

  late final saveDocumentDetails = <Map<String, dynamic>>[
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

  late final widgetList = <Widget>[
    AddBankAccount(
      bankNameController: bankNameController,
      branchNameController: branchNameController,
      accountTypeController: accountTypeController,
      accountNumberController: accountNumberController,
      ifscCodeController: ifscCodeController,
    ),
    AddPropertyDetails(
      propertyNameController: propertyNameController,
      propertyAddressController: propertyAddressController,
      pinCodeController: pinCodeController,
      percentageOfOwnerController: percentageOfOwnerController,
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
      uanController: uanController,
    ),
    AddLockerDetails(
      lockerNameController: lockerNameController,
      lockerAddressController: lockerAddressController,
      pinCodeController: pinCodeController,
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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    print('${widget.titleName} ${localization.details} ${localization.add}');
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Form(
                key: _formKey,
                child: widgetList[widget.index],
              ),
              CommonTextFormField(
                controller: notesController,
                textInputAction: TextInputAction.done,
                text: localization.notes,
                onChanged: (value) {
                  notesController.text = value!;
                },
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _showModalBottomSheet,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: greenColor),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3, right: 10),
                          child: Icon(CupertinoIcons.cloud_upload, size: 24),
                        ),
                        Text(
                          localization.uploadImages,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Wrap(
                  children: [
                    ...List.generate(
                      listImageUrl.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          // child: _isLoadingImage &&
                          //         listImage.length - 1 == index ? Container(
                          //         height: 60,
                          //         width: 60,
                          //         padding: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           border: Border.all(),
                          //         ),
                          //         child: const Indicator(),
                          //       ) :
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpenImageScreen(
                                    image: listImageUrl[index],
                                    openPDF:
                                        listImageUrl[index].contains('.pdf')
                                            ? true
                                            : false,
                                  ),
                                ),
                              );
                            },
                            child: AddDetailsImage(
                              image: listImageUrl[index],
                              onTap: () {
                                setState(() {
                                  listImageUrl.remove(listImageUrl[index]);
                                  listImage.remove(listImage[index]);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CommonButton(
                  widget: _isLoading
                      ? const Indicator(
                          color: whiteColor,
                        )
                      : Text(
                          localization.save,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await submitData(saveDocumentDetails[widget.index]);
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: blackColor,
                          ),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
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
