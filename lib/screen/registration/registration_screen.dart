import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
    this.userId,
    super.key,
  });

  final bool firstProfile;
  final bool editProfile;
  final String? userId;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
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
    image = pickedImageFile!.path;

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
    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.pop(context);
    image = pickedImageFile!.path;


    final dataImage = pickedImageFile.path.split('/').last;
    // await UploadImageStorage.imageStorage(dataImage, widget.firstProfile, url!);
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
    setState(() {});
  }

  Future<void> _removeProfilePicture() async {
    setState(() {
      image = null;
      url = null;
    });
    Navigator.pop(context);
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
      image: url,
      pinCode: pinCodeController.text,
      address: addressController.text,
      email: emailController.text,
      panCard: panCardController.text,
      birthDate: birthDateController.text,
      phoneNumber: phoneNumberController.text,
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
      final data = (widget.firstProfile)
          ? await FirebaseFirestore.instance
              .collection('users')
              .doc(uid.uid)
              .collection('userData')
              .doc(uid.phoneNumber)
              .get()
          : await FirebaseFirestore.instance
              .collection('users')
              .doc(uid.uid)
              .collection('userData')
              .doc(uid.phoneNumber)
              .collection('other Profile')
              .doc(widget.userId)
              .get();
      users = Users.fromJson(data.data()!);
      nameController.text = users!.name;
      addressController.text = users!.address;
      pinCodeController.text = users!.pinCode;
      emailController.text = users!.email;
      phoneNumberController.text = users!.phoneNumber!;
      panCardController.text = users!.panCard;
      relationController.text = users!.relation!;
      birthDateController.text = users!.birthDate;
      url = users!.image;
      _isDeleteUser = users!.isDeleteUser;
      setState(() {});
    }
  }

  Future<void> submitEditProfileData() async {
    final user = Users(
      id: (widget.firstProfile) ? currentUser!.uid : widget.userId!,
      name: nameController.text,
      image: (url != null) ? url! : null,
      address: addressController.text,
      pinCode: pinCodeController.text,
      email: emailController.text,
      panCard: panCardController.text,
      birthDate: birthDateController.text,
      relation: relationController.text,
      phoneNumber: phoneNumberController.text,
      isDeleteUser: _isDeleteUser,
    );
    (widget.firstProfile)
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(uid.uid)
            .collection('userData')
            .doc(uid.phoneNumber)
            .update(
              user.toJson(),
            )
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(uid.uid)
            .collection('userData')
            .doc(uid.phoneNumber)
            .collection('other Profile')
            .doc(widget.userId)
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
    if (widget.firstProfile) {
      phoneNumberController.text =
          '${FirebaseAuth.instance.currentUser!.phoneNumber}';
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: GestureDetector(
                    onTap: _showModalBottomSheet,
                    child: (url != null) ?
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: url!,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: greenColor,
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              color: greenColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            Assets.images.profilePicture.path,
                          ),
                        ),
                      ),
                    ),
                    // (widget.editProfile)
                    //     ? Container(
                    //         height: 100,
                    //         width: 100,
                    //         decoration: BoxDecoration(
                    //           color: greenColor.withOpacity(0.1),
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: (url != null)
                    //                 ? NetworkImage(
                    //                     url!,
                    //                   )
                    //                 : AssetImage(
                    //                     Assets.images.profilePicture.path,
                    //                   ) as ImageProvider,
                    //           ),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 100,
                    //         width: 100,
                    //         decoration: BoxDecoration(
                    //           color: greenColor.withOpacity(0.1),
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: (image != null)
                    //                 ? FileImage(
                    //                     File(image!),
                    //                   )
                    //                 : AssetImage(
                    //                     Assets.images.profilePicture.path,
                    //                   ) as ImageProvider,
                    //           ),
                    //         ),
                    //       ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TitleText(
                  text: localization.personalInformation,
                ),
                AddProfileTextFormField(
                  controller: nameController,
                  labelText: '${localization.name}*',
                  textInputAction: TextInputAction.next,
                ),
                GestureDetector(
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
                      });
                    });
                  },
                  child: AbsorbPointer(
                    child: AddProfileTextFormField(
                      controller: birthDateController,
                      showCursor: false,
                      validator: (v) {
                        return (v!.isEmpty)
                            ? localization.pleaseSelectBirthDate
                            : null;
                      },
                      textInputAction: TextInputAction.none,
                      keyboardType: TextInputType.none,
                      labelText: '${localization.dateOfBirth}*',
                      icon: Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                AddProfileTextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: panCardController,
                  labelText: '${localization.panCardNumber}*',
                  validator: (value) {
                    if (value!.length < 10) {
                      return localization.pleaseEnterValidPanCardNumber;
                    } else if (value.length != 10) {
                      return localization.panCardNumberShouldBeOf10Digit;
                    }
                  },
                ),
                if (!widget.firstProfile)
                  AddProfileTextFormField(
                    controller: relationController,
                    textInputAction: TextInputAction.next,
                    labelText: localization.relation,
                  )
                else
                  const SizedBox(),
                TitleText(
                  text: localization.contactInformation,
                ),
                AddProfileTextFormField(
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
                  },
                  labelText: '${localization.email}*',
                ),
                if (widget.firstProfile)
                  AddProfileTextFormField(
                    controller: phoneNumberController,
                    textInputAction: TextInputAction.next,
                    labelText: localization.phoneNumber,
                    readOnly: true,
                    enabled: false,
                    showCursor: false,
                  )
                else
                  AddProfileTextFormField(
                    textInputAction: TextInputAction.next,
                    labelText: '${localization.phoneNumber}*',
                    keyboardType: TextInputType.number,
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value!.length < 10) {
                        return localization.pleaseEnterValidPhoneNumber;
                      } else if (value.length != 10) {
                        return localization.phoneNumberShouldBeOf10Digit;
                      }
                    },
                  ),
                TitleText(
                  text: localization.address,
                ),
                AddProfileTextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  labelText: '${localization.address}*',
                ),
                AddProfileTextFormField(
                  controller: pinCodeController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  labelText: '${localization.pinCode}*',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return localization.pleaseEnterPinCodeNumber;
                    } else if (value.length < 6) {
                      return localization.pleaseEnterValidPinCodeNumber;
                    } else if (value.length > 6) {
                      return localization.pinCodeNumberShouldBeOf6Digit;
                    }
                  },
                ),
                if (widget.editProfile)
                  TextButton(
                    onPressed: () async {
                      deleteUserAccount(
                        context: context,
                        imageUrl: users!.image,
                        userEmail: users!.email,
                        userName: users!.name,
                        firstProfile: widget.firstProfile,
                        userId: widget.userId,
                      );
                      if (widget.firstProfile) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid.uid)
                            .collection('userData')
                            .doc(uid.phoneNumber)
                            .update({
                          'isDeleteUser': true,
                        });
                      }
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent,
                      ),
                    ),
                    child: Text(
                      (widget.firstProfile)
                          ? localization.deleteMyAccount
                          : localization.deleteThisAccount,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
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

class AddProfileTextFormField extends StatelessWidget {
  const AddProfileTextFormField({
    required this.labelText,
    required this.textInputAction,
    this.controller,
    this.showCursor = true,
    this.enabled = true,
    this.readOnly = false,
    super.key,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.icon,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String labelText;
  final TextInputAction textInputAction;
  final IconData? icon;
  final bool showCursor;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: whiteColor,
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 2,
          //     offset: const Offset(0,1),
          //     color: blackColor.withOpacity(0.25),
          //   ),
          // ],
          border: Border.all(
            width: 0.2,
            color: cloudyGreyColor.withOpacity(0.25),
          ),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          showCursor: showCursor,
          readOnly: readOnly,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSaved: onSaved,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator ??
              ((readOnly == false)
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return localization.pleaseEnterSomeText;
                      } else {
                        return null; // Validation passed
                      }
                    }
                  : null),
          decoration: InputDecoration(
            label: Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: blackColor.withOpacity(0.6),
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: cloudyGreyColor.withOpacity(0.4),
                width: 0.4,
              ),
            ),
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  TitleText({
    required this.text,
    super.key,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: blackColor.withOpacity(0.4),
        ),
      ),
    );
  }
}
