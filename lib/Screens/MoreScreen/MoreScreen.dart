import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Advertising/AdvertisingScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/FriendsScreen/HomeFollowers.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/share.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogHome.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/PageMoreAll.dart';
import 'package:wowondertimelineflutterapp/Screens/Events/EventsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Market/MarketScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Movies/MoviesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Offers/OffersScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/QRCode/QrCodeScreen.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:wowondertimelineflutterapp/Screens/Pokes/HomePoksScreen.dart';
import 'package:wowondertimelineflutterapp/Util/DarkMode/DarkModeWidget.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/MyGroupsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Weather/ScreenWeather.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MyVideos/MyVideoScreen.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wowondertimelineflutterapp/Screens/Language/LanguageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Memories/MemoriesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/SavePost/SavePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Packages/ProPlanPackages.dart';
import 'package:wowondertimelineflutterapp/Screens/AlbumsScreen/AlbumsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ImageScreen/MyImageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/HomeScreenEarnings.dart';
import 'package:wowondertimelineflutterapp/Screens/FriendsScreen/FriendsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/invitation/InvitationScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AlbumsScreen/ScreenAddAlbums.dart';
import 'package:wowondertimelineflutterapp/Screens/HelpAndSupport/SupportScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Privacy/PrivacySettingScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Screens/MyProfile/MyProfileHomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/GeneralSettingsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Infomation/DownloadMyInfoScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MoreScreen/WidgetTextMoreSettings.dart';
import 'package:wowondertimelineflutterapp/Screens/Notification/NotificationSettingsScreen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  bool seMore = false;

  TextEditingController _username = TextEditingController();
  final lists = GetSetList[0];
  bool chekbox = false;
  void initState() {
    _username.text = 'ameen';
    super.initState();
  }

  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());
    final conts = Get.put(SettingController());

    return GetBuilder<SettingController>(
        builder: (_) => Scaffold(
              // appBar:( AppBar(
              //   title: Row(children: [
              //     Image.asset(
              //       images.logoApar,
              //       color: Get.isDarkMode ? null : null,
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Text(nameApp,
              //         style: SafeGoogleFont(Fonts.font3,
              //             fontWeight: FontWeight.bold,
              //             color: Get.isDarkMode ? Colors.white : Colors.black))
              //   ]),
              //   actions: [
              //     Padding(
              //       padding: const EdgeInsets.all(0.0),
              //       child: IconButton(
              //         onPressed: () {

              //         },
              //         icon: Icon(Icons.add),
              //       ),
              //     )
              //   ],
              //   backgroundColor:
              //       Get.isDarkMode ? ColorDarkComponents : Colors.white,
              //   elevation: 0,
              // )),

              appBar: (AppBar(
                foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
                backgroundColor:
                    Get.isDarkMode ? ColorDarkComponents : Colors.white,
                centerTitle: false,
                elevation: 0,
                title: Row(children: [
                  Image.asset(
                    images.logoApar,
                    color: Get.isDarkMode ? null : null,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(nameApp,
                      style: SafeGoogleFont(Fonts.font3,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : Colors.black))
                ]),
                actions: [
                  if (conts.dataWhait.length > 0)
                    GetBuilder<SettingController>(
                        builder: (controller) => Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  // color: ColorTheme,
                                  border: Border.all(color: ColorTheme),
                                  borderRadius: BorderRadius.circular(5)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ScreenWeather());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.1,
                                          child: DotLottieLoader.fromAsset(
                                              "assets/animations/weather.lottie",
                                              frameBuilder: (ctx, dotlottie) {
                                            if (dotlottie != null) {
                                              return Lottie.memory(dotlottie
                                                  .animations.values.single);
                                            } else {
                                              return Container();
                                            }
                                          }),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller
                                                  .dataWhait[controller
                                                          .dataWhait.length -
                                                      1]
                                                  .temperature
                                                  .toString()
                                                  .replaceAll('Celsius', 'C'),
                                              style:
                                                  TextStyle(color: ColorTheme),
                                            ),
                                            Text(
                                              controller
                                                  .dataWhait[controller
                                                          .dataWhait.length -
                                                      1]
                                                  .country
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: ColorTheme),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                ],
              )),
              backgroundColor:
                  Get.isDarkMode ? ColorDarkBackground : Colors.grey[200],
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          GetBuilder<GetMyUserDataCont>(
                              init: GetMyUserDataCont(),
                              builder: ((cont) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        for (var i = 0;
                                            i < cont.data.length;
                                            i++)
                                          InkWell(
                                            onTap: () {
                                              Get.to(MyProfileHomeScreen(
                                                contFollooing: cont
                                                    .data[i].following_count,
                                                contFollowers: cont
                                                    .data[i].followers_count,
                                                contPosts:
                                                    cont.data[i].post_count,
                                                name: cont.data[i].name,
                                                avat: cont.data[i].avatar,
                                                cover: cont.data[i].cover,
                                                user_id: cont.data[i].user_id,
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.isDarkMode
                                                      ? ColorDarkComponents
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    for (var i = 0;
                                                        i < cont.data.length;
                                                        i++)
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                              maxRadius: 25,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child:
                                                                    CircleAvatar(
                                                                  maxRadius: 25,
                                                                  backgroundImage:
                                                                      NetworkImage(cont
                                                                          .data[
                                                                              i]
                                                                          .avatar),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            cont.data[i].name,
                                                            style: GoogleFonts.cairo(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Color
                                                                    .fromARGB(
                                                                        44,
                                                                        210,
                                                                        202,
                                                                        202)
                                                                : ColorBackIcons,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              for (var i = 0;
                                                                  i <
                                                                      cont.data
                                                                          .length;
                                                                  i++) {
                                                                Get.to(
                                                                    QrCodeScreen(
                                                                  avat: cont
                                                                      .data[i]
                                                                      .avatar,
                                                                  name: cont
                                                                      .data[i]
                                                                      .name,
                                                                  user_id: cont
                                                                      .data[i]
                                                                      .user_id,
                                                                ));
                                                              }
                                                            },
                                                            icon: Icon(Icons
                                                                .qr_code))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ))),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? ColorDarkComponents
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Menu'.tr,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  DarkModeWidget(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 3),
                            child: InkWell(
                              onTap: () {
                                Get.to(ProPlanPackages());
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: ColorTheme,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Go Pro Account'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          // if (false)
                          // if (conts.dataWhait.length > 0)
                          //   InkWell(
                          //     onTap: () {
                          //       Get.to(ScreenWeather());
                          //     },
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 8),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             color: Color(0xff331C71),
                          //             borderRadius:
                          //                 BorderRadius.circular(10)),
                          //         child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: GetBuilder<SettingController>(
                          //               builder: (controller) => Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Image(
                          //                     height: Get.height * 0.05,
                          //                     image: AssetImage(
                          //                         'assets/ImageNew/cloud.png'),
                          //                   ),
                          //                   Text(
                          //                     controller
                          //                         .dataWhait[controller
                          //                                 .dataWhait.length -
                          //                             1]
                          //                         .temperature
                          //                         .toString(),
                          //                     style: SafeGoogleFont(
                          //                         Fonts.font3,
                          //                         color: Colors.white,
                          //                         fontWeight: FontWeight.bold,
                          //                         fontSize: 25),
                          //                   ),
                          //                   Text(
                          //                     controller
                          //                         .dataWhait[controller
                          //                                 .dataWhait.length -
                          //                             1]
                          //                         .country
                          //                         .toString(),
                          //                     style: SafeGoogleFont(
                          //                         Fonts.font3,
                          //                         color: Colors.white,
                          //                         fontWeight: FontWeight.bold,
                          //                         fontSize: 25),
                          //                   )
                          //                 ],
                          //               ),
                          //             )),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        bottom: 0, left: 8, right: 8, top: 0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.7,
                      ),
                      delegate: SliverChildListDelegate(
                        [
                          if (Albums)
                            _continerMore(
                              ontap: () {
                                Get.to(AlbumsScreen(
                                  title: 'String title;',
                                ));
                              },
                              title: 'Albums'.tr,
                              svg: SvgImages.Albums,
                            ),
                          if (SavedPosts)
                            _continerMore(
                              ontap: () {
                                Get.to(SaveItemsScreen());
                              },
                              title: 'Saved Posts'.tr,
                              svg: SvgImages.SavePost,
                            ),
                          if (FriendsFollowers)
                            _continerMore(
                              ontap: () {
                                Get.to(HomeFollowers());
                              },
                              title: Friends_System
                                  ? 'Friends'.tr
                                  : 'Followers'.tr,
                              svg: SvgImages.Following,
                            ),
                          if (Groups)
                            _continerMore(
                              ontap: () {
                                Get.to(MyGroupsScreen());
                              },
                              title: 'Groups'.tr,
                              svg: SvgImages.Groups,
                            ),
                          if (MyVideo)
                            _continerMore(
                              ontap: () {
                                Get.to(MyVideoScreen());
                              },
                              title: 'My Video'.tr,
                              svg: SvgImages.MyVideo,
                            ),
                          if (MarketPlace)
                            _continerMore(
                              ontap: () {
                                Get.to(MarketScreen());
                              },
                              title: 'Market Place'.tr.toString(),
                              svg: SvgImages.MarketPlace,
                            ),
                          if (Blogs)
                            _continerMore(
                              ontap: () {
                                Get.to(BlogHome());
                              },
                              title: 'Blogs'.tr,
                              svg: SvgImages.Blogs,
                            ),
                          if (Events)
                            _continerMore(
                              ontap: () {
                                Get.to(EventsScreen());
                              },
                              title: 'Events'.tr,
                              svg: SvgImages.Events,
                            ),
                          if (Jobs)
                            _continerMore(
                              ontap: () async {},
                              title: 'Jobs'.tr,
                              svg: SvgImages.Jobs,
                            ),
                          if (Pages)
                            _continerMore(
                              ontap: () {
                                Get.to(AllPagesScreen());
                              },
                              title: 'Pages'.tr,
                              svg: SvgImages.Pages,
                            ),
                          if (seMore)
                            if (Memories)
                              _continerMore(
                                ontap: () {
                                  Get.to(MemoriesScreen());
                                },
                                title: 'Memories'.tr,
                                svg: SvgImages.Memories,
                              ),
                          if (seMore)
                            if (Offers)
                              _continerMore(
                                ontap: () {
                                  Get.to(OffersScreen());
                                },
                                title: 'Offers'.tr,
                                svg: SvgImages.Offers,
                              ),
                          if (seMore)
                            if (MyImages)
                              _continerMore(
                                ontap: () {
                                  Get.to(MyImageScreen());
                                },
                                title: 'My Images'.tr,
                                svg: SvgImages.MyImages,
                              ),
                          if (seMore)
                            if (Boosted)
                              _continerMore(
                                ontap: () {
                                  Get.to(MyImageScreen());
                                },
                                title: 'Boosted'.tr,
                                svg: SvgImages.Boosted,
                              ),
                          if (seMore)
                            if (Advertising)
                              _continerMore(
                                ontap: () {
                                  Get.to(AdvertisingScreen());
                                },
                                title: 'Advertising'.tr,
                                svg: SvgImages.Advertising,
                              ),
                          if (seMore)
                            if (Pokes)
                              _continerMore(
                                ontap: () {
                                  Get.to(HomePoksScreen());
                                },
                                title: 'Pokes'.tr,
                                svg: SvgImages.Pokes,
                              ),
                          if (seMore)
                            if (Movies)
                              _continerMore(
                                ontap: () {
                                  Get.to(MoviesScreen());
                                },
                                title: 'Movies'.tr,
                                svg: SvgImages.Movies,
                              ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(4.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    seMore = !seMore;
                                  });
                                },
                                child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.05,
                                  decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Get.isDarkMode
                                      //           ? Colors.white
                                      //           : Color.fromARGB(85, 0, 0, 0),
                                      //       spreadRadius: 0.1,
                                      //       blurRadius: 1),
                                      // ],

                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    seMore ? 'See Less'.tr : 'See More'.tr,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Color.fromARGB(255, 47, 55, 85)),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(LanguageScreen(
                                      lang: false,
                                    ));
                                  },
                                  svg: SvgImages.Language,
                                  text: 'Language'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(GeneralSettingsScreen(
                                      firstname: '',
                                    ));
                                  },
                                  svg: SvgImages.GeneralSetting,
                                  text: 'General Account'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(PrivacySettingScreen());
                                  },
                                  svg: SvgImages.Privacy,
                                  text: 'Privacy'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(NotificationSettingsScreen());
                                  },
                                  svg: SvgImages.Notification,
                                  text: 'Notifications'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                if (InvitationLinks)
                                  WidgetTextMoreSetetings(
                                    ontap: () {
                                      Get.to(invitationScreen());
                                    },
                                    svg: SvgImages.InvitationLink,
                                    text: 'Invitation Links'.tr,
                                  ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(DownloadMyInfoScreen(
                                      avat: cont
                                          .data[cont.data.length - 1].avatar,
                                      name:
                                          cont.data[cont.data.length - 1].name,
                                    ));
                                  },
                                  svg: SvgImages.Information,
                                  text: 'My Information'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                if (Earnings)
                                  WidgetTextMoreSetetings(
                                    ontap: () {
                                      Get.to(HomeScreenEarnings());
                                    },
                                    svg: SvgImages.Earnings,
                                    text: 'Earnings'.tr,
                                  ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  ontap: () {
                                    Get.to(SupportScreen());
                                  },
                                  svg: SvgImages.HelpSupport,
                                  text: 'Help & Support'.tr,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                                WidgetTextMoreSetetings(
                                  svg: SvgImages.logout,
                                  text: 'Logout'.tr,
                                  ontap: () async {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.confirm,
                                      text: 'Do you want to logout'.tr,
                                      confirmBtnText: 'Yes'.tr,
                                      onConfirmBtnTap: () async {
                                        await SharedP.Remove();
                                        Get.offAll(LoginScreen());
                                      },
                                      cancelBtnText: 'No'.tr,
                                      confirmBtnColor: Colors.green,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

class _continerMore extends StatelessWidget {
  const _continerMore({
    super.key,
    required this.title,
    required this.svg,
    this.ontap,
  });

  final String title;
  final String svg;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ontap();
          },
          child: Container(
            width: Get.width * 0.45,
            height: Get.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.035,
                  ),
                  Container(
                    width: Get.width * 0.09,
                    height: Get.width * 0.09,
                    decoration: BoxDecoration(
                        // color: Get.isDarkMode
                        //     ? Color.fromARGB(44, 175, 175, 175)
                        //     : ColorBackIcons,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      svg,
                      color: ColorTheme,
                      // color: Color.fromARGB(255, 255, 255, 255),
                      width: 15,
                      height: 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Container(
                    width: Get.width * 0.22,
                    child: Text(
                      title,
                      maxLines: 2,
                      style: SafeGoogleFont(Fonts.font1,
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
