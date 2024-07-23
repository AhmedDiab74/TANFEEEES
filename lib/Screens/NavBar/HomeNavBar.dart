import 'dart:async';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/ContHomeScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Colors2.dart';

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
// Timer? _timer;

// getCall() {
//   _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
//     AgoraCallApi.call();
//   });
// }

class _HomeNavBarState extends State<HomeNavBar> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  var tabIndex = 0;
  var contFrind = '0';

  final scrollController = ScrollController();

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
    // getCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          tooltip: 'Add'.tr,
          splashColor: ColorTheme2,
          backgroundColor: Get.isDarkMode ? Colors.black : ColorTheme2,
          onPressed: () {
            // changePageTo(3);
            Get.bottomSheet(
              AddHomeScreen(),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          child: Container(
            width: Get.width,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                              if (tabIndex == 0) {
                       
                                    scrollController.animateTo(0,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeIn);
                                 
                                  }
                        changePageTo(0);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/SvgNew/home.svg',
                            color: tabIndex == 0 ? Colors.black : Greyscale400,
                            height: 30,
                            width: 30,
                          ),
                          Text('Home')
                        ],
                      )),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      changePageTo(1);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/SvgNew/video.svg',
                          color: tabIndex == 1 ? Colors.black : Greyscale400,
                          height: 30,
                          width: 30,
                        ),
                        Text('Rells')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  child: InkWell(
                    
                      onTap: () {
                        changePageTo(2);
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  SvgImages.users,
                                  color: tabIndex == 2
                                      ? Colors.black
                                      : Greyscale400,
                                  width: 25,
                                  height: 25,
                                ),
                                Text('Request')
                              ],
                            ),
                          ),
                          if (contFrind != '0')
                            Positioned(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: ColorTheme),
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
                      )),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      changePageTo(4);
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          SvgImages.Menu,
                          color: tabIndex == 4
                              ? Colors.black
                              : Greyscale400,
                          height: 25,
                          width: 25,
                          // color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        Text('Mune')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          onPageChanged: (index) {
            changePageTo(index);
          },
          controller: PageController(initialPage: tabIndex),
          children: [
            if (tabIndex == 0) HomeScreen(scrollController: scrollController,),
            if (tabIndex == 1) VideoScreen(),
            if (tabIndex == 2) FriendRequestsScreen(),
            if (tabIndex == 4) MoreScreen(),
          ],
        ));
  }
}
