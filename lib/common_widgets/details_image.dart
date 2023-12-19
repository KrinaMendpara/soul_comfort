import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:soul_comfort/app_const/colors.dart';
import 'package:soul_comfort/screen/open_image/open_image_screen.dart';

class DetailsImageList extends StatelessWidget {
  const DetailsImageList({super.key, this.imageList});

  final List<String>? imageList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageList!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final uri = Uri.parse(imageList![index]);
        final pathSegments = uri.pathSegments.last.split('/').last;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenImageScreen(
                    image: imageList![index],
                    openPDF: imageList![index].contains('.jpg')
                        ? false
                        : true,
                  ),
                ),
              );
            },
            child: (imageList![index].contains('jpg'))
                ? Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 30,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          imageList![index],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 30,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: blackColor.withOpacity(0.3),
                      // color: greenColor.withOpacity(0.3),
                      // color: const Color(0xFFdbf8c8),
                      //   color: const Color(0xFFd9fdd3),
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
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                ),
                                child: const PDF(
                                  enableSwipe: false,
                                  autoSpacing: false,
                                ).cachedFromUrl(
                                  imageList![index],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color:  blackColor.withOpacity(0.1),
                              // color: greenColor.withOpacity(0.1),
                              // color: Color(0xFFceeaba),
                              // color: Color(0xFFd1f4cc),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child:
                                      Image.asset('assets/icons/pdf_icon.png'),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      pathSegments,
                                      // style: const TextStyle(
                                      //   color: whiteColor,
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
