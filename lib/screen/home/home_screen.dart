import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/button.dart';
import 'package:soul_comfort/common_widgets/profileview.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/users.dart';
import 'package:soul_comfort/providers/language/languages.dart';
import 'package:soul_comfort/screen/document_list/document_list_screen.dart';
import 'package:soul_comfort/screen/registration/registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final langList = <String>['English', 'ગુજરાતી', 'हिंदी'];

  // Future<void> checkConnection() async {
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     print('ConnectivityResult.mobile');
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     print('ConnectivityResult.wifi');
  //   } else if (connectivityResult == ConnectivityResult.ethernet) {
  //     print('ConnectivityResult.ethernet');
  //   } else if (connectivityResult == ConnectivityResult.none) {
  //     print('ConnectivityResult.none');
  //     return showDialog(
  //         context: context,
  //         barrierColor: blackColor.withOpacity(0.5),
  //         builder: (context) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             contentPadding: const EdgeInsets.all(20),
  //             alignment: Alignment.center,
  //             content: const Text(
  //               'No Internet Connection',
  //             ),
  //             actions: [
  //               Align(
  //                 child: Image.asset(
  //                   'assets/icons/wifi_offline.png',
  //                   height: 80,
  //                   width: 80,
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 20, bottom: 10),
  //                 child: Align(
  //                   child: Text(
  //                     'Please Check Your Internet Connection',
  //                     style: TextStyle(color: Colors.grey),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         });
  //   }
  // }

  @override
  void initState() {
    // checkConnection();
    super.initState();
  }

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
                    Icons.translate,
                    color: blackColor,
                  ),
                  iconSize: 20,
                  underline: Container(
                    width: 0,
                  ),
                  items: langList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          color: (e == provider.selectedLanguages)
                              ? greenColor
                              : blackColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? v) async {
                    await provider.changeLanguage(v!);
                    await provider.setLanguages(v);
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
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.error == snapshot.hasError) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final data = snapshot.data?.data();
                  final userModel = Users.fromJson(data!);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DocumentListScreen(
                            id: userModel.id,
                            image: userModel.image,
                            name: userModel.name,
                            email: userModel.email,
                          ),
                        ),
                      );
                    },
                    child: CommonProfileView(
                      height: 100,
                      width: 100,
                      userImage: userModel.image,
                      userName: userModel.name,
                      userEmail: userModel.email,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: cloudyGreyColor,
                          size: 22,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationScreen(editProfile: true),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
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
                      physics: const BouncingScrollPhysics(),
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
                                  builder: (context) => DocumentListScreen(
                                    id: userModel.id,
                                    image: userModel.image,
                                    name: userModel.name,
                                    email: userModel.email,
                                  ),
                                ),
                              );
                            },
                            child: CommonProfileView(
                              userImage: userModel.image,
                              userName: userModel.name,
                              userEmail: userModel.email,
                              widget: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: cloudyGreyColor,
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                        editProfile: true,
                                        firstProfile: false,
                                        userId: userModel.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                builder: (context) => const RegistrationScreen(
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
