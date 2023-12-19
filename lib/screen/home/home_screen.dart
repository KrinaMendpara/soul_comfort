import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/providers/userData/user_data_provider.dart';
import 'package:soul_comfort/screen/document_list/document_list_screen.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/screen/registration/registration_screen.dart';
import 'package:soul_comfort/providers/language/languages.dart';
import 'package:soul_comfort/services/share_pre.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final langList = <String>['English', 'ગુજરાતી', 'हिंदी'];
  String selectedLanguage = UserPreferences.user.userLanguage;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final uid = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          localization.soulComfort,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Consumer<Languages>(
              builder: (context, provider, child) {
                return DropdownButton(
                  icon: const Icon(
                    Icons.language,
                    color: blackColor,
                  ),
                  iconSize: 25,
                  underline: Container(
                    width: 0,
                  ),
                  items: langList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          color:
                          (e == selectedLanguage) ? greenColor : blackColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? v) async {
                    setState(() {
                      selectedLanguage = v!;
                    });
                    await provider.changeLanguage(v!);
                    provider.locale;
                    print(provider.locale);
                    print(provider.locale.languageCode);
                    print('----------');
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid.uid)
                  .collection('userData')
                  .doc(uid.phoneNumber)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && snapshot.hasError) {
                  return const CircularProgressIndicator();
                }
                else if(snapshot.error == snapshot.hasError){
                  return const CircularProgressIndicator();
                }
                else if(snapshot.hasData){
                  final data = snapshot.data!.data();
                  final userModel = Users.fromJson(data!);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DocumentListScreen(
                                id: '${userModel.id}',
                                image: '${userModel.image}',
                                name: '${userModel.name}',
                                email: '${userModel.email}',
                                firstProfile: true,
                              ),
                        ),
                      );
                    },
                    child: CommonProfileView(
                      height: 100,
                      width: 100,
                      userImage: '${userModel.image}',
                      userName: '${userModel.name}',
                      userEmail: '${userModel.email}',
                    ),
                  );
                }
                else{
                  return const SizedBox();
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid.uid)
                  .collection('userData')
                  .doc(uid.phoneNumber)
                  .collection('other Profile')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index].data();
                        final userModel = Users.fromJson(data);
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DocumentListScreen(
                                        id: '${userModel.id}',
                                        image: '${userModel.image}',
                                        name: '${userModel.name}',
                                        email: '${userModel.email}',
                                        firstProfile: false,
                                      ),
                                ),
                              );
                            },
                            child: CommonProfileView(
                              userImage: '${userModel.image}',
                              userName: '${userModel.name}',
                              userEmail: '${userModel.email}',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: CommonButton(
          name: '+ ${localization.addProfile}',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const RegistrationScreen(
                  firstProfile: false,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
