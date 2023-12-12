
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  UserPreferences._();
  static UserPreferences user = UserPreferences._();
  static SharedPreferences? pref;

 static Future<void> initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }


  set userLanguage(String languages) => pref!.setString('selectedLanguage', languages);
  String get userLanguage => pref!.getString('selectedLanguage') ?? 'en';


  set userImageList (List<String> image) => pref!.setStringList('userImageList', image);
  List<String> get userImageList => pref!.getStringList('userImageList') ?? [];


  set userNameList (List<String> image) => pref!.setStringList('userImageList', image);
  List<String> get userNameList => pref!.getStringList('userImageList') ?? [];

  set userEmailList (List<String> image) => pref!.setStringList('userImageList', image);
  List<String> get userEmailList => pref!.getStringList('userImageList') ?? [];




}
