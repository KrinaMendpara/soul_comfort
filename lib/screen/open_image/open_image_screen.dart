import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/generated/l10n.dart';
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
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          openPDF ? localization.pdf : localization.image,
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
                          child: Text(localization.ok),
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
          // : Center(child: Image.network(image)),
       : Center(
         child: CachedNetworkImage(
           imageUrl: image,
           fit: BoxFit.contain,
           progressIndicatorBuilder: (context, url, progress) {
             return Center(
               child: CircularProgressIndicator(
                 value: progress.progress,
                 color: greenColor,
               ),
             );
           },
         ),
       ),
    );
  }
}
