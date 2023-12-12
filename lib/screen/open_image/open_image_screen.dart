import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OpenImageScreen extends StatelessWidget {
  const OpenImageScreen({
    required this.image,
    this.openPDF = false,
    super.key,
  });

  final String image;
  final bool openPDF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
            openPDF == true ? 'PDF' : 'Image',
        ),
      ),
      body: openPDF == false ? Container(
        height: MediaQuery.of(context).size.height - 60 ,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
        ),
      ) : SfPdfViewer.network(
        image,
      ),
    );
  }
}
