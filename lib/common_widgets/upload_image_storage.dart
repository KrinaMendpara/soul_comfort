import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageStorage {
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
      String imagePath, bool firstProfile, String titleName) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final ref = (firstProfile == true)
        ? FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('documentImage')
            .child('${currentUser.uid}.jpg')
        : FirebaseStorage.instance
            .ref()
            .child('User_Image')
            .child(currentUser!.uid)
            .child('Other_Profile_Image')
            .child('documentImage')
            .child(titleName)
            .child(imagePath);
    await ref.putFile(File(imagePath));
    // var url = ref.getDownloadURL();
  }
}
