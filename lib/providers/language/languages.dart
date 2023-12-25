import 'package:flutter/material.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/services/share_pre.dart';

class Languages extends ChangeNotifier {
  List<Locale> supportedLocale =
      const AppLocalizationDelegate().supportedLocales;
  Locale locale = (UserPreferences.user.userLanguage.isNotEmpty)
      ? Locale(UserPreferences.user.userLanguage)
      : const Locale('en');

  String selectedLanguages = UserPreferences.user.selectedLanguage.isNotEmpty
      ? UserPreferences.user.selectedLanguage
      : 'English';

  Future<void> setLocale(String language) async {
    UserPreferences.user.userLanguage = language;
    locale = Locale(UserPreferences.user.userLanguage);
    notifyListeners();
  }

  Future<void> setLanguages(String language) async {
    UserPreferences.user.selectedLanguage = language;
    selectedLanguages = UserPreferences.user.selectedLanguage;
    notifyListeners();
  }

  Future<void> changeLanguage(String language) async {
    switch (language) {
      case 'English':
        await setLanguages('English');
        await setLocale('en');
      case 'ગુજરાતી':
        await setLanguages('ગુજરાતી');
        await setLocale('gu');
      case 'हिंदी':
        await setLanguages('हिंदी');
        await setLocale('hi');
      default:
        await setLanguages('English');
        await setLocale('en');
        break;
    }
    notifyListeners();
  }
}
