import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/CallLogsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/ChatsHomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/PagesChatScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GroupsChatScreen.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

class HomeScreenChat extends StatefulWidget {
  const HomeScreenChat({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenChat> createState() => _HomeScreenChatState();
}

class _HomeScreenChatState extends State<HomeScreenChat>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      body: FrostedBottomBar(
        width: Get.width * 0.9,
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        child: TabBar(
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
                50), // Customize the border radius as per your needs
            color: ColorTheme, // Customize the indicator color
          ),
          tabs: [
            TabsIcon(
                name: 'Home',
                icons: Icons.home,
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                name: 'Group',
                icons: Icons.queue_play_next,
                color: currentPage == 2 ? colors[2] : Colors.white),
            TabsIcon(
                name: 'Pages',
                icons: Icons.search,
                color: currentPage == 1 ? colors[1] : Colors.white),
            TabsIcon(
                name: 'Calls',
                icons: Icons.file_download,
                color: currentPage == 3 ? colors[3] : Colors.white),
          ],
        ),
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [
              ChatsHomeScreen(),
              GroupsChatScreen(),
              PagesChatScreen(),
              CallLogsScreen(),
            ]),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final icons;
  final name;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Icon(
            icons,
            color: color,
            size: 16,
          ),
          Text(
            name,
            style: TextStyle(color: color, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
