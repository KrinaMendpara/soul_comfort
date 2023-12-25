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
          openPDF ? 'PDF' : 'Image',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: openPDF
          ? SfPdfViewer.network(
              image,
              onDocumentLoadFailed: (value) {
                showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(value.error),
                      content: Text(value.description),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          : Container(
              height: MediaQuery.of(context).size.height - 60,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
            ),
    );
  }
}
