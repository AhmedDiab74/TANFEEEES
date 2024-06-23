import 'dart:async';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/HomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MoreScreen/MoreScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/PostVideoRels.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Screens/AddFriend/FriendRequestsScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

final cont = Get.put(GetMyUserDataCont());
PageController _controller = PageController(initialPage: 0);

class _HomeNavBarState extends State<HomeNavBar> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  var tabIndex = 0;
  var contFrind = '0';
  // var getToNamedList = [
  //   HomeScreen(),
  //   SearchScreen(),
  //   Container(),
  //   MoreScreen(),
  //   VideoScreen(),
  // ];
  String img = 'assets/images/';
  void changePageTo(int index) {
    tabIndex = index;
    setState(() {});
  }

  @override
  onLine() {
    SocketNew.UPDATEUSERLASTSEEN();
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (NodeJS) {
        SocketNew.UPDATEUSERLASTSEEN();
      } else {}
    });
  }

  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.bounceIn, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 0).animate(curvedAnimation);
    OneSignalNotf();
    onLine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());
    final List<BottomNavigationBarItem> items;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        floatingActionButton: Align(
          alignment: Alignment(1, 1),
          child: tabIndex == 0
              ? FloatingActionButton.extended(
                  elevation: 4,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  disabledElevation: 0,
                  tooltip: 'Add'.tr,
                  splashColor: ColorTheme,
                  backgroundColor: ColorTheme,
                  onPressed: () {
                    // changePageTo(3);
                    Get.bottomSheet(
                      AddHomeScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 16,
                  ),
                  label: Text(
                    'Add'.tr,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : SizedBox(),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          // shape: CircularNotchedRectangle(),
          notchMargin: 0,
          child: Container(
              height: Get.height * 0.07,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      changePageTo(0);
                    },
                    child: Container(
                      width: Get.width * 0.20,
                      child: Center(
                        child: SvgPicture.asset(
                          SvgImages.home,
                          color: tabIndex == 0 ? ColorTheme : Colors.grey,
                          // color: Color.fromARGB(255, 255, 255, 255),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      changePageTo(1);
                    },
                    child: Container(
                      width: Get.width * 0.20,
                      child: Center(
                        child: SvgPicture.asset(
                          SvgImages.MyVideo,
                          color: tabIndex == 1 ? ColorTheme : Colors.grey,
                          // color: Color.fromARGB(255, 255, 255, 255),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        changePageTo(2);
                      },
                      child: Container(
                        width: Get.width * 0.20,
                        child: Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                SvgImages.users,
                                color: tabIndex == 2 ? ColorTheme : Colors.grey,
                                // color: Color.fromARGB(255, 255, 255, 255),
                                width: 20,
                                height: 20,
                              ),
                            ),
                            if (contFrind != '0')
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorTheme),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      contFrind,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      changePageTo(4);
                    },
                    child: Container(
                      width: Get.width * 0.20,
                      child: Center(
                        child: SvgPicture.asset(
                          SvgImages.Menu,
                          color: tabIndex == 4 ? ColorTheme : Colors.grey,
                          // color: Color.fromARGB(255, 255, 255, 255),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        body: PageView(
          onPageChanged: (index) {
            changePageTo(index);
          },
          controller: PageController(initialPage: tabIndex),
          children: [
            if (tabIndex == 0) HomeScreen(),
            if (tabIndex == 1) VideoScreen(),
            if (tabIndex == 2) FriendRequestsScreen(),
            if (tabIndex == 4) MoreScreen(),
          ],
        ));
  }
}
