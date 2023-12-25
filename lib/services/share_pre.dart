
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  UserPreferences._();
  static UserPreferences user = UserPreferences._();
  static SharedPreferences? pref;

 static Future<void> initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }


  set userLanguage(String languages) => pref!.setString('userLanguage', languages);
  String get userLanguage => pref!.getString('userLanguage') ?? 'en';

  set selectedLanguage(String languages) => pref!.setString('selectedLanguage', languages);
  String get selectedLanguage => pref!.getString('selectedLanguage') ?? 'English';
  //
  // set collectionList (List<String> collectionName) => pref!.setStringList('collectionList', collectionName);
  // List<String> get collectionList => pref!.getStringList('collectionList') ?? [];

}
