import 'dart:async';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/HomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Market/MarketScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/PostVideoRels.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Screens/AddFriend/FriendRequestsScreen.dart';

class HomeMarket extends StatefulWidget {
  HomeMarket({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeMarket> createState() => _HomeMarketState();
}

class _HomeMarketState extends State<HomeMarket> with TickerProviderStateMixin {
  var tabIndex = 0;
  // var getToNamedList = [
  //   HomeScreen(),
  //   SearchScreen(),
  //   Container(),
  //   MoreScreen(),
  //   VideoScreen(),
  // ];
  void changePageTo(int index) {
    tabIndex = index;
    setState(() {});
  }

  @override
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
                  onPressed: () {},
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
                ],
              )),
        ),
        body: PageView(
          onPageChanged: (index) {
            changePageTo(index);
          },
          controller: PageController(initialPage: tabIndex),
          children: [
            if (tabIndex == 0) MarketScreen(),
            if (tabIndex == 1) VideoScreen(),
          ],
        ));
  }
}
