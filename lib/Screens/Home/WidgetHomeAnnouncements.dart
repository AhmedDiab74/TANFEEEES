import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAnnouncements.dart';

class WidgetHomeAnnouncements extends StatefulWidget {
  const WidgetHomeAnnouncements({
    super.key,
  });

  @override
  State<WidgetHomeAnnouncements> createState() =>
      _WidgetHomeAnnouncementsState();
}

class _WidgetHomeAnnouncementsState extends State<WidgetHomeAnnouncements> {
  String ameen = '';
  String api_status = '400';
  getdata() async {
    var ameens = await ApiAnnouncements.Cre();
    setState(() {
      api_status = ameens['api_status'].toString();
      ameen = ameens['flutterCr']['text'];
    });

    print('aklsdjklasjdklasjdkl ${ameens}');
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return api_status == '200'
        ? InkWell(
            onTap: () {
              Get.bottomSheet(Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(0)),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/ImageNew/logoApar.png',
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width * 0.71,
                              child: Html(
                                data: ameen,
                                onLinkTap: (url, attributes, element) {
                                  UrlGo(url);
                                },
                                style: {
                                  "html": Style(
                                    fontSize: FontSize(
                                        16), // Change the font size here
                                  ),
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  api_status = '400';
                                });
                              },
                              icon: Icon(Icons.cancel),
                              color: Get.isDarkMode ? Colors.black : ColorTheme,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            },
            child: Container(
              width: Get.width,
              // height: 10,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                  Image.asset(SvgImages.Announcements,cacheHeight: 105,cacheWidth: 105,width: 35,),
                   
                        
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Announcements'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          api_status = '400';
                        });
                      },
                      icon: Icon(Icons.cancel),
                      color: Get.isDarkMode ? Colors.white : ColorTheme,
                    ),
                  ]),
            ),
          )
        : SizedBox();

    // Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10),
    //     child: Container(
    //       decoration: BoxDecoration(
    //           color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
    //           borderRadius: BorderRadius.circular(0)),
    //       width: Get.width,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Center(
    //                     child: Image.asset(
    //                       'assets/ImageNew/logoApar.png',
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   width: Get.width * 0.71,
    //                   child: Html(
    //                     data: ameen,
    //                     onLinkTap: (url, attributes, element) {
    //                       UrlGo(url);
    //                     },
    //                     style: {
    //                       "html": Style(
    //                         fontSize:
    //                             FontSize(16), // Change the font size here
    //                       ),
    //                     },
    //                   ),
    //                 ),
    //                 IconButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       api_status = '400';
    //                     });
    //                   },
    //                   icon: Icon(Icons.cancel),
    //                   color: Get.isDarkMode ? Colors.black : ColorTheme,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
