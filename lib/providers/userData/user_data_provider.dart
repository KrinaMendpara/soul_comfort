

import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier{

List<String?> userImageList = [];
List<String> userNameList = [];
List<String> userEmailList = [];



  Future<void> addData(String? userImage, String userName, String userEmail) async{

    userImageList.add(userImage ?? null);
    userNameList.add(userName);
    userEmailList.add(userEmail);

    notifyListeners();
  }
}
