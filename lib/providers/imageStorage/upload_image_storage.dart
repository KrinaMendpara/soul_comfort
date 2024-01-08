import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageStorage extends ChangeNotifier{

  static ImagePicker picker = ImagePicker();

  static Future<void> imageStorage(String imagePath, bool firstProfile, String url ) async {
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
    url = await ref.getDownloadURL();
  }

  static Future<void> documentImageStorage(
      String imagePath, String titleName, String id, String url,) async {

    final ref = FirebaseStorage.instance
            .ref()
            .child('documentImage')
            .child(id)
            .child(titleName)
            .child(imagePath);
    await ref.putFile(File(imagePath));
    url = await ref.getDownloadURL();
  }
}
