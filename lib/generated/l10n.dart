// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null, 'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;
 
      return instance;
    });
  } 

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null, 'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Soul Comfort`
  String get soulComfort {
    return Intl.message(
      'Soul Comfort',
      name: 'soulComfort',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mobile Number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter Mobile Number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `To Soul Comfort`
  String get toSoulComfort {
    return Intl.message(
      'To Soul Comfort',
      name: 'toSoulComfort',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter Phone Number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOTP {
    return Intl.message(
      'Send OTP',
      name: 'sendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone Number`
  String get yourPhoneNumber {
    return Intl.message(
      'Your Phone Number',
      name: 'yourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `OTP has been sent for verification`
  String get otpHasBeenSentForVerification {
    return Intl.message(
      'OTP has been sent for verification',
      name: 'otpHasBeenSentForVerification',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP Again `
  String get sendOTPAgain {
    return Intl.message(
      'Send OTP Again ',
      name: 'sendOTPAgain',
      desc: '',
      args: [],
    );
  }

  /// `Add Profile`
  String get addProfile {
    return Intl.message(
      'Add Profile',
      name: 'addProfile',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Relation`
  String get relation {
    return Intl.message(
      'Relation',
      name: 'relation',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `BirthDate`
  String get birthDate {
    return Intl.message(
      'BirthDate',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get bankAccount {
    return Intl.message(
      'Bank Account',
      name: 'bankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Property`
  String get property {
    return Intl.message(
      'Property',
      name: 'property',
      desc: '',
      args: [],
    );
  }

  /// `Trading Account`
  String get tradingAccount {
    return Intl.message(
      'Trading Account',
      name: 'tradingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Other Assets`
  String get otherAssets {
    return Intl.message(
      'Other Assets',
      name: 'otherAssets',
      desc: '',
      args: [],
    );
  }

  /// `Provident Funds`
  String get providentFunds {
    return Intl.message(
      'Provident Funds',
      name: 'providentFunds',
      desc: '',
      args: [],
    );
  }

  /// `Locker`
  String get locker {
    return Intl.message(
      'Locker',
      name: 'locker',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get insurance {
    return Intl.message(
      'Insurance',
      name: 'insurance',
      desc: '',
      args: [],
    );
  }

  /// `Collectible`
  String get collectible {
    return Intl.message(
      'Collectible',
      name: 'collectible',
      desc: '',
      args: [],
    );
  }

  /// `Bond`
  String get bond {
    return Intl.message(
      'Bond',
      name: 'bond',
      desc: '',
      args: [],
    );
  }

  /// `P2P Landing`
  String get p2PLanding {
    return Intl.message(
      'P2P Landing',
      name: 'p2PLanding',
      desc: '',
      args: [],
    );
  }

  /// `Privet Equity`
  String get privetEquity {
    return Intl.message(
      'Privet Equity',
      name: 'privetEquity',
      desc: '',
      args: [],
    );
  }

  /// `Add Document`
  String get addDocument {
    return Intl.message(
      'Add Document',
      name: 'addDocument',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Account Type`
  String get accountType {
    return Intl.message(
      'Account Type',
      name: 'accountType',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `IFSC Code`
  String get iFSCCode {
    return Intl.message(
      'IFSC Code',
      name: 'iFSCCode',
      desc: '',
      args: [],
    );
  }

  /// `Branch Name`
  String get branchName {
    return Intl.message(
      'Branch Name',
      name: 'branchName',
      desc: '',
      args: [],
    );
  }

  /// `ART`
  String get aRT {
    return Intl.message(
      'ART',
      name: 'aRT',
      desc: '',
      args: [],
    );
  }

  /// `N.F.T`
  String get nFT {
    return Intl.message(
      'N.F.T',
      name: 'nFT',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Name`
  String get insuranceName {
    return Intl.message(
      'Insurance Name',
      name: 'insuranceName',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Privet Equity Name`
  String get privetEquityName {
    return Intl.message(
      'Privet Equity Name',
      name: 'privetEquityName',
      desc: '',
      args: [],
    );
  }

  /// `Property Name`
  String get propertyName {
    return Intl.message(
      'Property Name',
      name: 'propertyName',
      desc: '',
      args: [],
    );
  }

  /// `Property Address`
  String get propertyAddress {
    return Intl.message(
      'Property Address',
      name: 'propertyAddress',
      desc: '',
      args: [],
    );
  }

  /// `E.P.F`
  String get ePF {
    return Intl.message(
      'E.P.F',
      name: 'ePF',
      desc: '',
      args: [],
    );
  }

  /// `P.P.F`
  String get pPF {
    return Intl.message(
      'P.P.F',
      name: 'pPF',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Mutual Funds`
  String get mutualFunds {
    return Intl.message(
      'Mutual Funds',
      name: 'mutualFunds',
      desc: '',
      args: [],
    );
  }

  /// `Choose Option`
  String get chooseOption {
    return Intl.message(
      'Choose Option',
      name: 'chooseOption',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Upload From Gallery`
  String get uploadFromGallery {
    return Intl.message(
      'Upload From Gallery',
      name: 'uploadFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Remove Profile Picture`
  String get removeProfilePicture {
    return Intl.message(
      'Remove Profile Picture',
      name: 'removeProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Bond Name`
  String get bondName {
    return Intl.message(
      'Bond Name',
      name: 'bondName',
      desc: '',
      args: [],
    );
  }

  /// `Bond Details`
  String get bondDetails {
    return Intl.message(
      'Bond Details',
      name: 'bondDetails',
      desc: '',
      args: [],
    );
  }

  /// `Locker Name`
  String get lockerName {
    return Intl.message(
      'Locker Name',
      name: 'lockerName',
      desc: '',
      args: [],
    );
  }

  /// `Locker Address`
  String get lockerAddress {
    return Intl.message(
      'Locker Address',
      name: 'lockerAddress',
      desc: '',
      args: [],
    );
  }

  /// `Equity Name`
  String get equityName {
    return Intl.message(
      'Equity Name',
      name: 'equityName',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get pleaseEnterSomeText {
    return Intl.message(
      'Please enter some text',
      name: 'pleaseEnterSomeText',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please select birthDate`
  String get pleaseSelectBirthDate {
    return Intl.message(
      'Please select birthDate',
      name: 'pleaseSelectBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Valid Phone Number`
  String get pleaseEnterValidPhoneNumber {
    return Intl.message(
      'Please Enter Valid Phone Number',
      name: 'pleaseEnterValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number should be 10 digits`
  String get phoneNumberShouldBeOf10Digit {
    return Intl.message(
      'Phone number should be 10 digits',
      name: 'phoneNumberShouldBeOf10Digit',
      desc: '',
      args: [],
    );
  }

  /// `Bank account number should be 8 digits`
  String get bankAccountNumberShouldBe8Digits {
    return Intl.message(
      'Bank account number should be 8 digits',
      name: 'bankAccountNumberShouldBe8Digits',
      desc: '',
      args: [],
    );
  }

  /// `IFSC code should be 10 digits`
  String get ifscCodeShouldBe10Digits {
    return Intl.message(
      'IFSC code should be 10 digits',
      name: 'ifscCodeShouldBe10Digits',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}