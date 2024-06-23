import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:photo_view/photo_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MoreInfoProudct.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 300,
                  child: PageView.builder(
                    itemCount: product['images'].length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.dialog(Scaffold(
                              backgroundColor: Colors.black,
                              appBar: AppBar(
                                backgroundColor: Colors.black,
                              ),
                              body: Center(
                                child: PageView.builder(
                                  controller: PageController(initialPage: index),
                                  itemCount: product['images'].length,
                                  itemBuilder: (context, index) {
                                    return PhotoView(
                                      imageProvider: CachedNetworkImageProvider(
                                          product['images'][index]['image']),
                                    );
                                  },
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            width: Get.width *0.962790,
                            child: CachedNetworkImage(

                                fit: BoxFit.cover,
                                imageUrl: product['images'][index]['image_org']),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                 
                    color: Color.fromARGB(169, 0, 0, 0),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40))),
                              height: Get.height * 0.07,
                              width: Get.width * 0.24,
                              child: Center(
                                  child: Text(
                                product['type'] == '0' ? 'New' : 'Used',
                                style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            )),
                        Column(children: [
                          Text(
                            product['name'],
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                CurrencyConverter(Currency_Array[
                                    int.parse(product['currency'])]),
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Text(
                                product['price_format'],
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                //status
                if (product['status'] == '0')
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(50)),
                          color: Colors.blue,
                        ),
                        height: Get.height * 0.1,
                        width: Get.width * 0.2,
                        child: Center(
                          child: Text(
                            'In stock'.tr,
                            style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      )),
                // type
                if (product['status'] == '1')
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(50)),
                          color: Color.fromARGB(255, 91, 13, 8),
                        ),
                        height: Get.height * 0.1,
                        width: Get.width * 0.2,
                        child: Center(
                          child: Text(
                            'Sold'.tr,
                            style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(74, 158, 158, 158),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.message),
                        Text(
                          'Contact Seller'.tr,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ColorTheme, borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.production_quantity_limits,
                          color: Colors.white,
                        ),
                        Text(
                          'Buy Now'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(MoreInfoProudct(
                      product: product,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(74, 158, 158, 158),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.info),
                          Text(
                            'More Info'.tr,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Text(product['edit_description'],
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold), maxLines: 1)
          // DetectableText(
          //   trimCollapsedText: 'Show More'.tr,
          //   trimExpandedText: 'Show less'.tr,
          //   // trimExpandedText: 'show less'.tr,
          //   // trimCollapsedText: 'read more'.tr,
          //   trimLines: 4,

          //   text: product['edit_description'],
          //   detectedStyle: GoogleFonts.cairo(
          //     fontSize: 20,
          //     color: Colors.blue,
          //   ),
          //   basicStyle: GoogleFonts.cairo(
          //     fontSize: 17,
          //     fontWeight: FontWeight.w800,
          //   ),
          //   onTap: (tappedText) async {
          //     if (hasHashTags(tappedText)) {
          //       Get.to(HashtagPostsScreen(
          //         titel: tappedText,
          //       ));
          //     }
          //     ;

          //     RegExp exp = RegExp(
          //         "([@]([$detectionContentLetters]+))|$urlRegexContent",
          //         multiLine: true);

          //     Iterable<RegExpMatch> matches =
          //         exp.allMatches(product['edit_description']);
          //     for (final m in matches) {
          //       if (m[0].toString().isNotEmpty) {
          //         var username = await GetUserDataUserName.getUserData(
          //             m[0].toString().replaceAll('@', ''));
          //         if (username != null) {
          //           Get.toNamed(Routes.profileUserScreen,
          //               arguments: ({
          //                 'user_id': username['user_id'],
          //                 'avatar': username['avatar'],
          //                 'cover': username['cover'],
          //               }));
          //         }
          //       }
          //     }
          //   },
          //   detectionRegExp: RegExp(
          //     "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
          //     multiLine: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}
