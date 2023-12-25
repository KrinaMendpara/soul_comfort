import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageStorage extends ChangeNotifier{

  static ImagePicker picker = ImagePicker();
  static bool _isLoadingImage = false;

  static Future<void> imageStorage(String imagePath, bool firstProfile) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final ref = (firstProfile == true)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child('${currentUser!.uid}.jpg')
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('Other_Profile_Image')
            .child(imagePath);
    await ref.putFile(File(imagePath));
  }

  static Future<void> documentImageStorage(
      String imagePath, String titleName, String id, url) async {

    final ref = FirebaseStorage.instance
            .ref()
            .child('documentimage')
            .child(id)
            .child(titleName)
            .child(imagePath);
    await ref.putFile(File(imagePath));
    url = ref.getDownloadURL();
  }
  static Future<void> pickImageFromCamera(File images, listImage, url, String titleName, String id) async {

    final pickedImageFile = await picker
        .pickImage(
      source: ImageSource.camera,
    )
        .whenComplete(() {
        _isLoadingImage = true;
    });

    images = File(pickedImageFile!.path);
    final dataImage = pickedImageFile.path.split('/').last;
    // Navigator.pop(context);
    await documentImageStorage(dataImage, titleName,id, url);
    listImage.add(images);
      _isLoadingImage = false;


    // listImageUrl.add('$url');
  }
}
