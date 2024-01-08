import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/common_widgets/progress_indicator.dart';
import 'package:soul_comfort/gen/assets.gen.dart';
import 'package:soul_comfort/screen/open_image/open_image_screen.dart';

class DetailsImageList extends StatelessWidget {
  const DetailsImageList({
    this.isLoading = false,
    this.imageList,
    super.key,
  });

  final List<String?>? imageList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageList!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final uri = Uri.parse(imageList![index]!);
        final pathSegments = uri.pathSegments.last.split('/').last;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: isLoading
              ? const Center(
                  child: Indicator(),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenImageScreen(
                          image: imageList![index]!,
                          openPDF:
                              imageList![index]!.contains('pdf') ? true : false,
                        ),
                      ),
                    );
                  },
                  child: (imageList![index]!.contains('pdf'))
                      ? Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width - 30,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AbsorbPointer(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    child: const PDF(
                                      enableSwipe: false,
                                      autoSpacing: false,
                                    ).cachedFromUrl(
                                      imageList![index]!,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          Assets.icons.pdfIcon.path,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            pathSegments,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 30,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: imageList![index]!,
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
                ),
        );
      },
    );
  }
}
