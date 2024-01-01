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
import 'package:soul_comfort/gen/assets.gen.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/providers/userData/user_data_provider.dart';
import 'package:soul_comfort/screen/delete_account/delete_account.dart';
import 'package:soul_comfort/screen/home/home_screen.dart';
import 'package:soul_comfort/services/share_pre.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    this.firstProfile = true,
    this.editProfile = false,
    super.key,
  });

  final bool firstProfile;
  final bool editProfile;

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
  String? url;
  Users? users;
  bool _isDeleteUser = false;

  User? currentUser = FirebaseAuth.instance.currentUser;
  final ImagePicker picker = ImagePicker();
  UserPreferences pref = UserPreferences.user;
  final uid = FirebaseAuth.instance.currentUser!;

  Future<void> _pickImageFromCamera() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    Navigator.pop(context);
    setState(() {
      image = pickedImageFile!.path;
    });

    final ref = (widget.firstProfile)
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
    );
    Navigator.pop(context);
    setState(() {
      image = pickedImageFile!.path;
    });

    final dataImage = pickedImageFile!.path.split('/').last;
    // await UploadImageStorage.imageStorage(image!, widget.firstProfile);
    final ref = (widget.firstProfile)
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
                    icon: Assets.icons.camera.path,
                    onTap: _pickImageFromCamera,
                  ),
                  SelectProfilePic(
                    icon: Assets.icons.gallery.path,
                    title: localization.uploadFromGallery,
                    onTap: _pickImageFromGallery,
                  ),
                  SelectProfilePic(
                    icon: Assets.images.profilePicture.path,
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

  Future<void> _submitData(BuildContext context) async {
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
      isDeleteUser: _isDeleteUser,
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

  Future<void> editProfileData() async {
    if (widget.editProfile) {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid.uid)
          .collection('userData')
          .doc(uid.phoneNumber)
          .get();
      users = Users.fromJson(data.data()!);
      nameController.text = users!.name;
      addressController.text = users!.address;
      emailController.text = users!.email;
      phoneNumberController.text = users!.phoneNumber!;
      ageController.text = users!.age;
      birthDateController.text = users!.birthDate;
      image = users!.image;
      _isDeleteUser = users!.isDeleteUser;
      setState(() {});

      print('users!.isDeleteUser --------- ${users!.isDeleteUser}');
    }
  }

  Future<void> submitEditProfileData() async {
    final user = Users(
      id: currentUser!.uid,
      name: nameController.text,
      image: users!.image ?? url!,
      address: addressController.text,
      email: emailController.text,
      age: ageController.text,
      birthDate: birthDateController.text,
      phoneNumber: currentUser!.phoneNumber,
      isDeleteUser: _isDeleteUser,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid.uid)
        .collection('userData')
        .doc(uid.phoneNumber)
        .update(
          user.toJson(),
        );
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    editProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          widget.editProfile
              ? localization.editProfile
              : widget.firstProfile
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
                        image: (image != null)
                            ? (widget.editProfile)
                                ? NetworkImage(
                                    users!.image!,
                                  ) as ImageProvider
                                : FileImage(
                                    File(image!),
                                  )
                            : AssetImage(
                                Assets.images.profilePicture.path,
                              ),
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
                    if (value == null) {
                      return localization.pleaseEnterSomeText;
                    } else if (value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.com')) {
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
                if (widget.editProfile)
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isDeleteUser = true;
                          users!.isDeleteUser = true;
                        });
                        // submitEditProfileData();
                        deleteUserAccount(
                          context: context,
                          imageUrl: users!.image!,
                          userEmail: users!.email,
                          userName: users!.name,
                        );
                      },

                      child: Text(
                        localization.deleteMyAccount,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CommonButton(
                    name: widget.editProfile
                        ? localization.editProfile
                        : widget.firstProfile
                            ? localization.save
                            : localization.addProfile,
                    onTap: () async {
                      if (widget.editProfile) {
                        await submitEditProfileData();
                      } else {
                        await _submitData(context);
                      }
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
