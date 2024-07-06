import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:wowondertimelineflutterapp/Colors2.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/HomeScreenChat.dart';
import 'package:wowondertimelineflutterapp/Screens/Notification/NotificationScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/AddStoriesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/new/StoriesScreenView.dart';
import 'package:wowondertimelineflutterapp/Widget/CustomPainterCir.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';

import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetWebViewRequst.dart';

import 'package:wowondertimelineflutterapp/Screens/Home/ContHomeScreen.dart';

import 'package:wowondertimelineflutterapp/Screens/Home/RecommendedFrind.dart';

import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

import 'package:wowondertimelineflutterapp/Screens/Pages/CreatePageScreen.dart';

import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/broadcast_page.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/CreateGroupScreen.dart';

import 'package:wowondertimelineflutterapp/Screens/Market/CreateProductScreen.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/WidgetHomeAnnouncements.dart';

import 'package:wowondertimelineflutterapp/Screens/Home/WidgetWilccomeHomeScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Config = GetSetList[0];
    final controller = Get.put(ContHomeScreen());

    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? ColorDarkBackground
          : Theme.of(context).scaffoldBackgroundColor,
      // body: Obx(
      //   () =>
      //   NestedScrollView(
      //     floatHeaderSlivers: true,
      //     headerSliverBuilder: (context, innerBoxIsScrolled) {
      //       return [
      //         SliverAppBar(
      //           backgroundColor:
      //               Get.isDarkMode ? ColorDarkComponents : Colors.white,
      //           elevation: 2,
      //           centerTitle: true,
      //           pinned: true,
      //           foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      //           title: Row(children: [
      //             Image.asset(
      //               images.logoApar,
      //               color: Get.isDarkMode ? null : null,
      //             ),
      //             SizedBox(
      //               width: Get.width * 0.02,
      //             ),
      //             Text(nameApp,
      //                 style: SafeGoogleFont(Fonts.font3,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 14,
      //                     color: Get.isDarkMode ? Colors.white : Colors.black))
      //           ]),
      //           actions: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Row(
      //                 children: [
      //                   InkWell(
      //                     onTap: () {
      //                       Get.to(
      //                         SearchScreen(),
      //                       );
      //                     },
      //                     child: Container(
      //                       padding: EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                           color: Get.isDarkMode
      //                               ? Color.fromARGB(44, 210, 202, 202)
      //                               : ColorBackIcons,
      //                           borderRadius: BorderRadius.circular(50)),
      //                       child: SvgPicture.asset(
      //                         SvgImages.Search,
      //                         height: Get.height * 0.02,
      //                         width: Get.width * 0.02,
      //                         color: Get.isDarkMode ? Colors.white : ColorTheme,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     width: Get.width * 0.02,
      //                   ),
      //                   InkWell(
      //                       onTap: () {
      //                         Get.to(NotificationScreen());
      //                       },
      //                       child: CircleAvatar(
      //                         backgroundColor: Get.isDarkMode
      //                             ? Color.fromARGB(44, 210, 202, 202)
      //                             : ColorBackIcons,
      //                         child: Stack(
      //                           children: [
      //                             Center(
      //                               child: SvgPicture.asset(
      //                                 SvgImages.Notifications,
      //                                 height: Get.height * 0.02,
      //                                 width: Get.width * 0.02,
      //                                 color: Get.isDarkMode
      //                                     ? Colors.white
      //                                     : ColorTheme,
      //                               ),
      //                             ),
      //                             controller.notfi.toString() == 'null'
      //                                 ? SizedBox()
      //                                 : controller.notfi.toString() == '0'
      //                                     ? SizedBox()
      //                                     : Positioned(
      //                                         right: 3,
      //                                         top: 5,
      //                                         child: Container(
      //                                           height: 10,
      //                                           width: 10,
      //                                           decoration: BoxDecoration(
      //                                               color: Colors.red,
      //                                               shape: BoxShape.circle,
      //                                               border: Border.all(
      //                                                 color: Colors.white,
      //                                               )),
      //                                         ),
      //                                       ),
      //                           ],
      //                         ),
      //                       )),
      //                   SizedBox(
      //                     width: Get.width * 0.02,
      //                   ),
      //                   if (ChatSystem == '1')
      //                     InkWell(
      //                       onTap: () {
      //                         // Get.to(ChatScreenGpt());
      //                         Get.to(HomeScreenChat());
      //                       },
      //                       child: Stack(
      //                         children: [
      //                           CircleAvatar(
      //                             backgroundColor: Get.isDarkMode
      //                                 ? Color.fromARGB(44, 210, 202, 202)
      //                                 : ColorBackIcons,
      //                             child: SvgPicture.asset(
      //                               SvgImages.Message,
      //                               height: Get.height * 0.02,
      //                               width: Get.width * 0.02,
      //                               color: Get.isDarkMode
      //                                   ? Colors.white
      //                                   : ColorTheme,
      //                             ),
      //                           ),
      //                           controller.count_new_messagesApi2.toString() ==
      //                                   'null'
      //                               ? SizedBox()
      //                               : controller.count_new_messagesApi2
      //                                           .toString() ==
      //                                       '0'
      //                                   ? SizedBox()
      //                                   : Positioned(
      //                                       right: 3,
      //                                       top: 0,
      //                                       child: Container(
      //                                         decoration: BoxDecoration(
      //                                             color: Colors.red,
      //                                             shape: BoxShape.circle),
      //                                         child: Padding(
      //                                           padding:
      //                                               const EdgeInsets.all(4.0),
      //                                           child: Text(
      //                                             controller
      //                                                 .count_new_messagesApi2
      //                                                 .toString(),
      //                                             style: TextStyle(
      //                                                 color: Colors.white),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     )
      //                         ],
      //                       ),
      //                     ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ];
      //     },
      body: Obx(
        () => Column(
          children: [
            Expanded(
              flex: -1,
              child: Visibility(
                child: Container(
                  height: sizedHeight(context) * 0.27,
                  child: AnimatedContainer(
                    height: 14,
                    curve: Curves.easeInOutQuart,
                    duration: Duration(seconds: 5),
                    child: Stack(
                      children: [
                        Container(
                          width: sizedwidth(context),
                          height: sizedHeight(context) * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50)),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/imagesNew/pattern.png'),
                                fit: BoxFit.cover),
                            color: Color(0xffD9FBE9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icon.png',
                                          height: 25,
                                          width: 40,
                                        ),
                                        Text(
                                          nameApp,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(HomeScreenChat());
                                          },
                                          child: SvgPicture.asset(
                                              'assets/SvgNew/messages.svg'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(NotificationScreen());
                                          },
                                          child: SvgPicture.asset(
                                              'assets/SvgNew/notfi.svg'),
                                        ),
                                        SvgPicture.asset(
                                            'assets/SvgNew/add.svg')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: sizedwidth(context) * 0.99,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                        AddStoriesScreen()); // Get.to(StoryPage());
                                                  },
                                                  child: CustomPaint(
                                                    painter:
                                                        CircleBorderwith4Color(
                                                      gap: 1,
                                                      borderThinckness: 8,
                                                      topRightColor:
                                                          Greyscale800,
                                                      bottomLeftColor:
                                                          Greyscale600,
                                                      topLeftColor:
                                                          Greyscale400,
                                                      bottomRightColor:
                                                          Greyscale400,
                                                    ),
                                                    child: CircleAvatar(
                                                      maxRadius: 28,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                              mydata.data.length >
                                                                      0
                                                                  ? mydata
                                                                      .data[0]
                                                                      .avatar
                                                                  : ''),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text('Add story')
                                              ],
                                            ),
                                          ),
                                          for (var i = 0;
                                              i < controller.stor.length;
                                              i++)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(NewStoreViw(
                                                          cont: controller,
                                                          initialPage: i));
                                                    },
                                                    child: CustomPaint(
                                                      painter:
                                                          CircleBorderwith4Color(
                                                        gap: 1,
                                                        borderThinckness: 8,
                                                        topRightColor:
                                                            Greyscale800,
                                                        bottomLeftColor:
                                                            Greyscale600,
                                                        topLeftColor:
                                                            Greyscale400,
                                                        bottomRightColor:
                                                            Greyscale400,
                                                      ),
                                                      child: CircleAvatar(
                                                        maxRadius: 28,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                controller
                                                                    .stor[i]
                                                                    .avatar),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(controller.stor[i].name)
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SmartRefresher(
                onRefresh: controller.refesh,
                onLoading: controller.onLoding,
                enablePullDown: true,
                enablePullUp: true,
                controller: controller.refreshController,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (false)
                          //   Container(
                          //     color:
                          //         Get.isDarkMode ? ColorDarkComponents : Colors.white,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         GetBuilder<GetMyUserDataCont>(
                          //             init: GetMyUserDataCont(),
                          //             builder: ((cont) => Padding(
                          //                   padding: const EdgeInsets.all(8),
                          //                   child: Container(
                          //                     width: Get.width * 0.96,
                          //                     // height: 50,
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         for (var i = 0;
                          //                             i < cont.data.length;
                          //                             i++)
                          //                           Row(
                          //                             mainAxisAlignment:
                          //                                 MainAxisAlignment.start,
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment.start,
                          //                             children: [
                          //                               CircleAvatar(
                          //                                 maxRadius: 17,
                          //                                 child: Padding(
                          //                                   padding:
                          //                                       const EdgeInsets.all(0),
                          //                                   child: CircleAvatar(
                          //                                     maxRadius: 17,
                          //                                     backgroundImage:
                          //                                         CachedNetworkImageProvider(
                          //                                             cont.data[i]
                          //                                                 .avatar),
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                               SizedBox(
                          //                                 width: Get.width * 0.01,
                          //                               ),
                          //                               InkWell(
                          //                                 child: Column(
                          //                                   crossAxisAlignment:
                          //                                       CrossAxisAlignment
                          //                                           .start,
                          //                                   children: [
                          //                                     Text(
                          //                                       'What\'s going on? #Hashtag.. @Mention',
                          //                                       style: TextStyle(
                          //                                           fontWeight:
                          //                                               FontWeight.bold,
                          //                                           fontSize: 13),
                          //                                     ),
                          //                                     SizedBox(
                          //                                       height:
                          //                                           Get.height * 0.005,
                          //                                     ),
                          //                                     Text(
                          //                                       'Type Something here...',
                          //                                       style: TextStyle(
                          //                                           fontSize: 12),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               )
                          //                             ],
                          //                           ),
                          //                         SizedBox(
                          //                           height: Get.height * 0.01,
                          //                         ),
                          //                         Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.spaceAround,
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment.start,
                          //                           children: [
                          //                             for (var i = 0; i < 4; i++)
                          //                               Container(
                          //                                 clipBehavior: Clip.hardEdge,
                          //                                 decoration: BoxDecoration(
                          //                                   borderRadius:
                          //                                       BorderRadius.circular(
                          //                                           5),
                          //                                 ),
                          //                                 child: Material(
                          //                                   child: InkWell(
                          //                                     onTap: (() {}),
                          //                                     child: Container(
                          //                                       padding: EdgeInsets
                          //                                           .symmetric(
                          //                                               vertical: 5,
                          //                                               horizontal: 12),
                          //                                       child: Row(
                          //                                         mainAxisAlignment:
                          //                                             MainAxisAlignment
                          //                                                 .start,
                          //                                         crossAxisAlignment:
                          //                                             CrossAxisAlignment
                          //                                                 .start,
                          //                                         children: [
                          //                                           SvgPicture.asset(
                          //                                             SvgImages
                          //                                                 .AddPerson,
                          //                                             color: ColorTheme,
                          //                                             // color: Color.fromARGB(255, 255, 255, 255),
                          //                                             width: 15,
                          //                                             height: 15,
                          //                                           ),
                          //                                           SizedBox(
                          //                                             width: Get.width *
                          //                                                 0.02,
                          //                                           ),
                          //                                           Text(
                          //                                             'Camera',
                          //                                             style: SafeGoogleFont(
                          //                                                 Fonts.font1,
                          //                                                 fontSize: 13,
                          //                                                 fontWeight:
                          //                                                     FontWeight
                          //                                                         .w600),
                          //                                           ),
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                               )
                          //                           ],
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ))),
                          //       ],
                          //     ),
                          //   ),
                          // Container(
                          //   color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                          //   margin: EdgeInsets.symmetric(vertical: 10),
                          //   width: Get.width,
                          //   child: SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child: Row(
                          //       children: [
                          //         GetBuilder<GetMyUserDataCont>(
                          //             init: GetMyUserDataCont(),
                          //             builder: ((cont) => Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Row(
                          //                     children: [
                          //                       for (var i = 0;
                          //                           i < cont.data.length;
                          //                           i++)
                          //                         InkWell(
                          //                           onTap: () {
                          //                             Get.bottomSheet(
                          //                                 AddStoriesScreen()); // Get.to(StoryPage());
                          //                           },
                          //                           child: Column(
                          //                             children: [
                          //                               if (Story_Theme_Version == 1)
                          //                                 MyStoryWidget(
                          //                                   name:
                          //                                       controller.data[i].name,
                          //                                   images: cont.data[i].avatar,
                          //                                 ),
                          //                               if (Story_Theme_Version == 2)
                          //                                 MyStoryWidgetv2(
                          //                                   name: cont.data[i].name,
                          //                                   images: cont.data[i].avatar,
                          //                                 ),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       Row(
                          //                         children: [
                          //                           for (var i = 0;
                          //                               i < controller.stor.length;
                          //                               i++)
                          //                             InkWell(
                          //                               onTap: () {
                          //                                 Get.to(StoriesScreenView(
                          //                                     user_id: controller
                          //                                         .stor[controller
                          //                                                 .stor.length -
                          //                                             1]
                          //                                         .user_id,
                          //                                     stior: controller.stor,
                          //                                     i: i));
                          //                               },
                          //                               child: Padding(
                          //                                   padding:
                          //                                       EdgeInsets.all(8.0),
                          //                                   child: Column(
                          //                                     children: [
                          //                                       if (Story_Theme_Version ==
                          //                                           1)
                          //                                         StroyWidget(
                          //                                           avatir: controller
                          //                                               .stor[i].avatar,
                          //                                           images: controller
                          //                                               .stor[i]
                          //                                               .stories,
                          //                                           name: controller
                          //                                               .stor[i].name,
                          //                                         ),
                          //                                       if (Story_Theme_Version ==
                          //                                           2)
                          //                                         StroyWidgetv2(
                          //                                           avatir: controller
                          //                                               .stor[i].avatar,
                          //                                           images: controller
                          //                                               .stor[i]
                          //                                               .stories,
                          //                                           name: controller
                          //                                               .stor[i].name,
                          //                                         ),
                          //                                     ],
                          //                                   )),
                          //                             ),
                          //                         ],
                          //                       ),

                          //                     ],
                          //                   ),
                          //                 ))),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          WidgetHomeAnnouncements(),
                          WidgetWilcomeHomeScreen(),
                          SizedBox(
                            height: Get.height * 0.015,
                          )
                        ],
                      ),
                      // Divider(),
                      //// add posts//
                      ///

                      // WidgetAdd
                      ///posts
                      ///
                      ///
                      ///
                      ///

                      for (var i = 0; i < controller.boost.length; i++)
                        if (controller.boost[i].avatar.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(0)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.007,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.05,
                                      ),
                                      SvgPicture.asset(
                                        SvgImages.Promoted,
                                        width: 18,
                                        height: 18,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Text(
                                        'Promoted'.tr,
                                        style: SafeGoogleFont(Fonts.font1,
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.007,
                                  ),
                                  Column(
                                    children: [
                                      WidgetPosts(
                                        blog: controller.boost[i].blog,
                                        voted_id: controller.boost[i].voted_id,
                                        postFileName:
                                            controller.boost[i].postFileName,
                                        vy_live: controller.boost[i].vy_live,
                                        blur: controller.boost[i].blur,
                                        color_id: controller.boost[i].color_id,
                                        stream_name:
                                            controller.boost[i].stream_name,
                                        pro_type: controller.boost[i].pro_type,
                                        is_pro: controller.boost[i].is_pro,
                                        headline: controller.boost[i].headline,
                                        yout: controller.boost[i].postYoutube,
                                        shared_info:
                                            controller.boost[i].shared_info,
                                        url_post: controller.boost[i].urlsss,
                                        trueflasecommet:
                                            controller.boost[i].comments_status,
                                        event: controller.boost[i].event,
                                        product_id:
                                            controller.boost[i].product_id,
                                        product: controller.boost[i].product,
                                        more: Container(
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                    WidgetMorePosts(
                                                      url_post: controller
                                                          .boost[i].urlsss,
                                                      refreshPost: () {
                                                        controller.GetPost();
                                                      },
                                                      postText: controller
                                                          .boost[i].postText,
                                                      pos: controller
                                                          .boost[i].post_id,
                                                      hidePost: () {
                                                        controller.boost
                                                            .removeAt(i);
                                                      },
                                                      remove: () {
                                                        QuickAlert.show(
                                                          onConfirmBtnTap: () {
                                                            PostActionsApi.reaction(
                                                                    controller
                                                                        .boost[
                                                                            i]
                                                                        .post_id,
                                                                    'delete')
                                                                .asStream();

                                                            controller.data
                                                                .removeAt(i);

                                                            Get.back();
                                                            Get.back();
                                                          },
                                                          context: context,
                                                          type: QuickAlertType
                                                              .confirm,
                                                          text:
                                                              'Do you want to delete the post',
                                                          confirmBtnText: 'Yes',
                                                          cancelBtnText: 'No',
                                                          confirmBtnColor:
                                                              Colors.red,
                                                        );
                                                      },
                                                      adminPost: controller
                                                          .boost[i].admin,
                                                      avat: controller
                                                          .boost[i].avatar,
                                                      name: controller
                                                          .boost[i].name,
                                                      user_id: controller
                                                          .boost[i].user_id,
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.more_vert))),
                                        user_id: controller.boost[i].user_id,
                                        reomvePost: () {
                                          controller.boost.removeAt(i);
                                        },
                                        data: controller.boost,
                                        adminPost: controller.boost[i].admin,
                                        iint: i,
                                        imReaction: controller.boost[i].type,
                                        reaction: controller.boost[i].reaction,
                                        post_id: controller.boost[i].post_id,
                                        postType: controller.boost[i].postType,
                                        verified: controller.boost[i].verified,
                                        postFeeling:
                                            controller.boost[i].postFeeling,
                                        time: controller.boost[i].post_time,
                                        name: controller.boost[i].name,
                                        avat: controller.boost[i].avatar,
                                        postText: controller.boost[i].postText,
                                        postFile: controller.boost[i].postFile,
                                        p1080p: controller.boost[i].p1080,
                                        p2048p: controller.boost[i].p2048,
                                        p240p: controller.boost[i].p240,
                                        p360p: controller.boost[i].p360,
                                        p4096p: controller.boost[i].p4096,
                                        p480p: controller.boost[i].p480,
                                        p720p: controller.boost[i].p720,
                                        options: controller.boost[i].options,
                                        postRecord:
                                            controller.boost[i].postRecord,
                                        contLike: controller.boost[i].reaction,
                                        contcoment: int.parse(
                                            controller.boost[i].post_comments),
                                        post_share: int.parse(
                                            controller.boost[i].post_share),
                                        islike: controller.boost[i].reaction1,
                                        photoMulti2:
                                            controller.boost[i].photoMulti2,
                                        photo_album:
                                            controller.boost[i].photo_album,
                                        postimage: controller.boost[i].postFile,
                                        type: controller.boost[i].type,
                                        page_id: controller.boost[i].page_id,
                                        group_id: controller.boost[i].group_id,
                                        avatar_group:
                                            controller.boost[i].avatargroupe,
                                        name_group:
                                            controller.boost[i].group_title,
                                        cover: controller.boost[i].cover,
                                        comment_cont:
                                            controller.boost[i].comments_status,
                                        ad_media: controller.boost[i].ad_media,
                                        biddingAds:
                                            controller.boost[i].biddingAds,
                                        descriptionAds:
                                            controller.boost[i].descriptionAds,
                                        nameAds: controller.boost[i].nameAds,
                                        user_dataAds:
                                            controller.boost[i].user_dataAds,
                                        postPrivacy:
                                            controller.boost[i].postPrivacy,
                                        Boosted: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      controller.lodingPosts.value
                          ? LodingPostsWidget(
                              len: 5,
                            )
                          : Column(
                              children: [
                                for (var i = 0; i < controller.data.length; i++)
                                  Column(
                                    children: [
                                      if (i == 3) RecommendedFrind(),
                                      _WidgetPosts(
                                          controller: controller, i: i),
                                    ],
                                  )
                              ],
                            ),
                      if (controller.lodingPostsMore.value)
                        LodingPostsWidget(
                          len: 2,
                        ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WidgetPosts extends StatelessWidget {
  const _WidgetPosts({
    super.key,
    required this.controller,
    required this.i,
  });

  final ContHomeScreen controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return WidgetPosts(
      blog: controller.data[i].blog,
      voted_id: controller.data[i].voted_id,
      postFileName: controller.data[i].postFileName,
      vy_live: controller.data[i].vy_live,
      blur: controller.data[i].blur,
      postPrivacy: controller.data[i].postPrivacy,
      color_id: controller.data[i].color_id,
      stream_name: controller.data[i].stream_name,
      pro_type: controller.data[i].pro_type,
      is_pro: controller.data[i].is_pro,
      ad_media: controller.data[i].ad_media,
      biddingAds: controller.data[i].biddingAds,
      descriptionAds: controller.data[i].descriptionAds,
      nameAds: controller.data[i].nameAds,
      user_dataAds: controller.data[i].user_dataAds,
      headline: controller.data[i].headline,
      Boosted: false,
      yout: controller.data[i].postYoutube,
      shared_info: controller.data[i].shared_info,
      url_post: controller.data[i].urlsss,
      trueflasecommet: controller.data[i].comments_status,
      event: controller.data[i].event,
      product_id: controller.data[i].product_id,
      product: controller.data[i].product,
      more: Container(
          child: IconButton(
              onPressed: () {
                Get.bottomSheet(
                  WidgetMorePosts(
                    url_post: controller.data[i].urlsss,
                    refreshPost: () {
                      controller.GetPost();
                    },
                    postText: controller.data[i].postText,
                    pos: controller.data[i].post_id,
                    hidePost: () {
                      controller.data.removeAt(i);
                    },
                    remove: () {
                      QuickAlert.show(
                        onConfirmBtnTap: () {
                          PostActionsApi.reaction(
                                  controller.data[i].post_id, 'delete')
                              .asStream();

                          controller.data.removeAt(i);

                          Get.back();
                          Get.back();
                        },
                        context: context,
                        type: QuickAlertType.confirm,
                        text: 'Do you want to delete the post'.tr,
                        confirmBtnText: 'Yes'.tr,
                        cancelBtnText: 'No'.tr,
                        confirmBtnColor: Colors.red,
                      );
                    },
                    adminPost: controller.data[i].admin,
                    avat: controller.data[i].avatar,
                    name: controller.data[i].name,
                    user_id: controller.data[i].user_id,
                  ),
                );
              },
              icon: Icon(Icons.more_vert))),
      user_id: controller.data[i].user_id,
      reomvePost: () {
        controller.data.removeAt(i);
      },
      data: controller.data,
      adminPost: controller.data[i].admin,
      iint: i,
      imReaction: controller.data[i].type,
      reaction: controller.data[i].reaction,
      post_id: controller.data[i].post_id,
      postType: controller.data[i].postType,
      verified: controller.data[i].verified,
      postFeeling: controller.data[i].postFeeling,
      time: controller.data[i].post_time,
      name: controller.data[i].name,
      avat: controller.data[i].avatar,
      postText: controller.data[i].postText,
      postFile: controller.data[i].postFile,
      p1080p: controller.data[i].p1080,
      p2048p: controller.data[i].p2048,
      p240p: controller.data[i].p240,
      p360p: controller.data[i].p360,
      p4096p: controller.data[i].p4096,
      p480p: controller.data[i].p480,
      p720p: controller.data[i].p720,
      options: controller.data[i].options,
      postRecord: controller.data[i].postRecord,
      contLike: controller.data[i].reaction,
      contcoment: int.parse(controller.data[i].post_comments),
      post_share: int.parse(controller.data[i].post_share),
      islike: controller.data[i].reaction1,
      photoMulti2: controller.data[i].photoMulti2,
      photo_album: controller.data[i].photo_album,
      postimage: controller.data[i].postFile,
      type: controller.data[i].type,
      page_id: controller.data[i].page_id,
      group_id: controller.data[i].group_id,
      avatar_group: controller.data[i].avatargroupe,
      name_group: controller.data[i].group_title,
      cover: controller.data[i].cover,
      comment_cont: controller.data[i].comments_status,
    );
  }
}

// class AddHomeScreen extends StatelessWidget {
//     String config;
class AddHomeScreen extends StatelessWidget {
  const AddHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Config = GetSetList[0];
    // Get.to(CreatePostScreen());
    Future<void> onJoin({required bool isBroadcaster}) async {
      await [Permission.camera, Permission.microphone].request();
      var uuid = Uuid();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BroadcastPage(
            isBroadcaster: isBroadcaster,
            channelName: uuid.v4().toString(),
            token: null,
          ),
        ),
      );
    }

    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20, bottom: Get.height * 0.065),
      padding: EdgeInsets.only(top: 10, bottom: 0),
      // height: Get.height * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Get.isDarkMode ? ColorDarkComponents : Colors.grey[200],
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
                            "Create new content".tr,
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

                  BottomCreateMenu(
                    icon: SvgImages.CreatePost,
                    title: 'Post'.tr,
                    onTap: () async {
                      Get.to(CreatePostScreen(
                        typeBackPost: 'HomeScreen',
                      ));
                    },
                  ),

                  if (Config['live_video'] == '1')
                    BottomCreateMenu(
                      icon: SvgImages.CreateLive,
                      title: 'Live'.tr,
                      onTap: () async {
                        if (LiveStreamplugin) {
                          Get.to(WidgetWebViewRequst(
                            appBar: false,
                            token: await SharedP.Get('tok'),
                            urls: 'livestream',
                          ));
                        } else {
                          onJoin(isBroadcaster: true);
                        }
                      },
                    ),

                  if (Config['classified'] == '1')
                    BottomCreateMenu(
                      icon: SvgImages.CreateProduct,
                      title: 'Product'.tr,
                      onTap: () async {
                        Get.to(CreateProductScreen());
                      },
                    ),

                  if (Config['groups'] == '1')
                    BottomCreateMenu(
                      icon: SvgImages.CreateGroup,
                      title: 'Group'.tr,
                      onTap: () async {
                        Get.to(CreateGroupScreen());
                      },
                    ),
                  if (Config['pages'] == '1')
                    BottomCreateMenu(
                      icon: SvgImages.CreatePage,
                      title: 'Page'.tr,
                      onTap: () async {
                        Get.to(CreatePageScreen());
                      },
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCreateMenu extends StatelessWidget {
  BottomCreateMenu({
    required this.title,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String title;
  final icon;
  final onTap;
  @override
  Widget build(BuildContext context) {
    // Widget add(String title, icon) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: InkWell(
          onTap: () {
            Get.back();

            if (onTap != null) onTap();
          },
          child: Container(
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
                SvgPicture.asset(
                  icon,
                  width: 20,
                  height: 20,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
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
          )

          // add('Page'.tr, SvgImages.CreatePage),
          ),
    );
  }
}
