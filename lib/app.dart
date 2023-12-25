import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/flavors.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/providers/language/languages.dart';
import 'package:soul_comfort/screen/splash_screen/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Languages>(
      builder: (context, value, child) {
        return MaterialApp(
          title: F.title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              primary: greenColor,
              seedColor: whiteColor,
            ),
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              backgroundColor: whiteColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: blackColor,
              ),
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: blackColor,
              ),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent,
            ),
          ),
          home: const SplashScreen(),
          localizationsDelegates: const [
            // FlutterFireUILocalizations.withDefaultOverrides(AppLocalizations()),
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // FlutterFireUILocalizations.delegate,
          ],
          supportedLocales: const AppLocalizationDelegate().supportedLocales,
          locale: value.locale,
        );
      },
    );
  }
}
