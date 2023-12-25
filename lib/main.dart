import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app.dart';
import 'package:soul_comfort/providers/auth/auth_provider.dart';
import 'package:soul_comfort/providers/imageStorage/upload_image_storage.dart';
import 'package:soul_comfort/providers/language/languages.dart';
import 'package:soul_comfort/providers/userData/user_data_provider.dart';
import 'package:soul_comfort/services/firebase_option.dart';
import 'package:soul_comfort/services/share_pre.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOption.currentPlatform);
  await UserPreferences.initSharedPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Languages>(
          create: (context) =>
              Languages(),
        ),
        ChangeNotifierProvider<AuthProviders>(
          create: (context) =>
              AuthProviders(),
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (
              context,
              ) =>
              UserDataProvider(),
        ),
        ChangeNotifierProvider<UploadImageStorage>(
          create: (context) =>
              UploadImageStorage(),
        ),
      ],
      child: const App(),
    ),
  );
}
