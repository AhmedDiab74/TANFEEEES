import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/SharePostGroupsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/SharePostMyTimelineScreen.dart';

class WidgetShare extends StatelessWidget {
  const WidgetShare({
    required this.postid,
    required this.url_post,
    super.key,
  });
  final String url_post;
  final String postid;
  @override
  Widget build(BuildContext context) {
    final Config = GetSetList[0];
    // return SingleChildScrollView(
    //   child: Container(
    //     // height: Get.height * 0.30,
    //     decoration: BoxDecoration(
    //         color: Get.isDarkMode? ColorDarkBackground: Colors.grey[200],
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    //     child: Padding(
    //       padding: const EdgeInsets.all(0),
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               SizedBox(),
    //               Text('Share to'.tr),
    //               SizedBox(),
    //             ],
    //           ),
    //           Material(
    //             child: InkWell(
    //               onTap: () {
    //                 Get.to(SharePostMyTimelineScreen(
    //                   postid: postid,
    //                 ));
    //               },
    //               child: ShareDialogue('Share to my Timeline'.tr,Icons.sync),
    //               // child: Row(
    //               //   mainAxisAlignment: MainAxisAlignment.start,
    //               //   children: [
    //               //     Icon(Icons.sync,size: 16,),
    //               //     SizedBox(width: Get.width * 0.02,),
    //               //     Text(
    //               //       'Share to my Timeline'.tr,
    //               //       style: SafeGoogleFont(Fonts.font1,
    //               //           fontWeight: FontWeight.bold, fontSize: 14),
    //               //     ),
    //               //   ],
    //               // ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: Get.height * 0.04,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               Get.to(
    //                 SharePostGroupsScreen(
    //                   post_id: postid,
    //                 ),
    //               );
    //             },
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   'Share to a Group'.tr,
    //                   style: SafeGoogleFont(Fonts.font1,
    //                       fontWeight: FontWeight.bold, fontSize: 17),
    //                 ),
    //                 Icon(Icons.group),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: Get.height * 0.04,
    //             child: Divider(),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'Share to a Page'.tr,
    //                 style: SafeGoogleFont(Fonts.font1,
    //                     fontWeight: FontWeight.bold, fontSize: 17),
    //               ),
    //               Icon(Icons.pages),
    //             ],
    //           ),
    //           SizedBox(
    //             height: Get.height * 0.04,
    //             child: Divider(),
    //           ),
    //           InkWell(
    //             onTap: () async {
    //               Share.share(url_post);
    //             },
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   'More Options'.tr,
    //                   style: SafeGoogleFont(Fonts.font1,
    //                       fontWeight: FontWeight.bold, fontSize: 17),
    //                 ),
    //                 Icon(Icons.ios_share_outlined),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20, bottom: Get.height * 0.065),
      padding: EdgeInsets.only(top: 10, bottom: 0),
      // height: Get.height * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Get.isDarkMode ? ColorDarkBackground : Colors.grey[200],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 50,
                            height: 2,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          SizedBox(),
                        ]),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "Share this Post".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: "Mulish",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.cancel),
                          )
                        ]),
                  ),

                  // Divider(),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.to(SharePostMyTimelineScreen(
                          postid: postid,
                        ));
                      },
                      child:
                          ShareDialogue('Share to my Timeline'.tr, Icons.sync),
                    ),
                  ),

                  if (Config['groups'] == '1')
                    Container(
                      width: Get.width,
                      height: 0.5,
                      color: Colors.grey[400],
                    ),

                  if (Config['groups'] == '1')
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            SharePostGroupsScreen(
                              post_id: postid,
                            ),
                          );
                        },
                        child:
                            ShareDialogue('Share to a Group'.tr, Icons.group),
                      ),
                    ),

                  if (Config['pages'] == '1')
                    Container(
                      width: Get.width,
                      height: 0.5,
                      color: Colors.grey[400],
                    ),

                  if (Config['pages'] == '1')
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: ShareDialogue('Share to a Page'.tr, Icons.pages),
                      ),
                    ),

                  Container(
                    width: Get.width,
                    height: 0.5,
                    color: Colors.grey[400],
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        Share.share(url_post);
                      },
                      child: ShareDialogue(
                          'More Options'.tr, Icons.ios_share_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ShareDialogue(String title, icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      // color: Get.isDarkMode
      //     ? ColorDarkComponents
      //     : ColorBackIcons,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
        ),
        SizedBox(
          width: Get.width * 0.035,
        ),
        Text(
          title,
          style: SafeGoogleFont(
            Fonts.font1,
            fontSize: 13,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}
