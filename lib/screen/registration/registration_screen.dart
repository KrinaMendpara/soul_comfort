import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/select_profilepic.dart';
import 'package:soul_comfort/common_widgets/textformfield.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/providers/userData/user_data_provider.dart';
import 'package:soul_comfort/screen/home/home_screen.dart';
import 'package:soul_comfort/services/share_pre.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    this.firstProfile = true,
    super.key,
  });

  final bool firstProfile;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String? image;
  var ref;
  var url;

  User? currentUser = FirebaseAuth.instance.currentUser;
  final ImagePicker picker = ImagePicker();
  UserPreferences pref = UserPreferences.user;

  Future<void> _pickImageFromCamera() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 100,
    );

    Navigator.pop(context);
    setState(() {
      image = pickedImageFile!.path;
    });

    ref = (widget.firstProfile)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('${currentUser!.uid}.jpg')
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('Other_Profile_Image');
    await ref.putFile(File(image!)).whenComplete(() => null);

    url = await ref.getDownloadURL();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 0,
      maxWidth: 100,
    );
    Navigator.pop(context);
    setState(() {
      image = pickedImageFile!.path;
    });

    final dataImage = pickedImageFile!.path.split('/').last;
    // await UploadImageStorage.imageStorage(image!, widget.firstProfile);
    ref = (widget.firstProfile)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('${currentUser!.uid}.jpg')
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('Other_Profile_Image')
            .child(dataImage);
    await ref.putFile(File(image!));

    url = await ref.getDownloadURL();

  }

  Future<void> _removeProfilePicture() async {
    Navigator.pop(context);
    setState(() {
      image = null;
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
                    icon: 'assets/icons/camera.png',
                    onTap: _pickImageFromCamera,
                  ),
                  SelectProfilePic(
                    icon: 'assets/icons/gallery.png',
                    title: localization.uploadFromGallery,
                    onTap: _pickImageFromGallery,
                  ),
                  SelectProfilePic(
                    icon: 'assets/images/profile_picture.jpg',
                    title: localization.removeProfilePicture,
                    onTap: _removeProfilePicture,
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

  Future<void> _submitData(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser!;
    final id = FirebaseFirestore.instance
        .collection('users')
        .doc(uid.uid)
        .collection('userData')
        .doc(uid.phoneNumber)
        .collection('other Profile')
        .doc()
        .id;

    final users = Users(
      id: widget.firstProfile ? currentUser!.uid : id,
      name: nameController.text,
      image: '$url',
      address: addressController.text,
      email: emailController.text,
      age: ageController.text,
      birthDate: birthDateController.text,
      phoneNumber: currentUser!.phoneNumber,
      relation: relationController.text,
    );
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      if (widget.firstProfile == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid.uid)
            .collection('userData')
            .doc(uid.phoneNumber)
            .set(
              users.toJson(),
            );
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid.uid)
            .collection('userData')
            .doc(uid.phoneNumber)
            .collection('other Profile')
            .doc(id)
            .set(
              users.toJson(),
            );
      }
      await context.read<UserDataProvider>().addData(
            image,
            nameController.text,
            emailController.text,
          );

      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          widget.firstProfile
              ? localization.registration
              : localization.addProfile,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showModalBottomSheet,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // color: greenColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: image != null
                            ? FileImage(
                                File(image!),
                              )
                            : const AssetImage(
                                'assets/images/profile_picture.jpg',
                              ) as ImageProvider,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CommonTextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  text: localization.name,
                ),
                CommonTextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  text: localization.address,
                ),
                CommonTextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null ) {
                      return localization.pleaseEnterSomeText;
                    }
                    else if(value.isEmpty || !value.contains('@') || !value.contains('.com')){
                      return localization.invalidEmail;
                    }
                    return null;
                  },
                  text: localization.email,
                ),
                CommonTextFormField(
                  textInputAction: TextInputAction.next,
                  text: '${FirebaseAuth.instance.currentUser!.phoneNumber}',
                  readOnly: true,
                  enabled: false,
                  showCursor: false,
                  onSaved: (value) {
                    phoneNumberController.text =
                        '${FirebaseAuth.instance.currentUser!.phoneNumber}';
                    return null;
                  },
                ),
                if (!widget.firstProfile)
                  CommonTextFormField(
                    controller: relationController,
                    textInputAction: TextInputAction.next,
                    text: localization.relation,
                  )
                else
                  const SizedBox(),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: ageController,
                        text: localization.age,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          ).then((pickedDate) {
                            final formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate!);
                            setState(() {
                              birthDateController.text = formattedDate;
                              // users!.birthDate = formattedDate;
                            });
                          });
                        },
                        child: AbsorbPointer(
                          child: CommonTextFormField(
                            controller: birthDateController,
                            showCursor: false,
                            validator: (v) {
                              return (v!.isEmpty)
                                  ? localization.pleaseSelectBirthDate
                                  : null;
                            },
                            textInputAction: TextInputAction.none,
                            keyboardType: TextInputType.none,
                            text: localization.birthDate,
                            icon: Icons.date_range_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CommonButton(
                    name: widget.firstProfile
                        ? localization.save
                        : localization.addProfile,
                    onTap: () async {
                      await _submitData(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
