import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/details_image.dart';
import 'package:soul_comfort/common_widgets/details_text.dart';
import 'package:soul_comfort/generated/l10n.dart';
import 'package:soul_comfort/model/property.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('document')
            .doc(id)
            .collection('Property')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data?.docs[index].data();
                final property = Property.fromJson(data!);
                return Column(
                  children: [
                    DetailsText(
                      name: localization.propertyName,
                      value: property.propertyName,
                    ),
                    DetailsText(
                      name: localization.propertyAddress,
                      value: property.propertyAddress,
                    ),
                    DetailsText(
                      name: localization.pinCode,
                      value: property.pinCode,
                    ),
                    DetailsText(
                      name: localization.percentageOfOwnership,
                      value: property.percentageOfOwnership,
                    ),
                    if (property.notes!.isNotEmpty)
                      DetailsText(
                        name: localization.notes,
                        value: property.notes!,
                      )
                    else
                      const SizedBox(),
                    DetailsImageList(
                      imageList: property.images ?? [],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: blackColor,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Text('No Property data');
          }
        },
      ),
    );
  }
}
