import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

class MessengerUserMedia extends StatefulWidget {
  const MessengerUserMedia({
    Key? key,
  }) : super(key: key);

  @override
  State<MessengerUserMedia> createState() => _MessengerUserMediaState();
}

class _MessengerUserMediaState extends State<MessengerUserMedia>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
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
      appBar: AppBar(
        title: Text('Media, files & links'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
      ),
      body: FrostedBottomBar(
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
                icons: 'Images',
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                icons: 'Files',
                color: currentPage == 1 ? colors[1] : Colors.white),
            TabsIcon(
                icons: 'Links',
                color: currentPage == 2 ? colors[2] : Colors.white),
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
              TabsScreen(id: currentPage),
              FilesTab(id: currentPage),
              LinksTab(id: currentPage),
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

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Text(
          icons,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

class TabsScreen extends StatefulWidget {
  final id;
  TabsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<String> placeholderImages =
      List.generate(30, (index) => 'https://via.placeholder.com/550');

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: placeholderImages.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          placeholderImages[index],
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
        );
      },
    );
  }
}

class FilesTab extends StatelessWidget {
  final id;
  FilesTab({
    Key? key,
    required this.id,
  }) : super(key: key);
  final List<String> placeholderImages =
      List.generate(30, (index) => 'https://via.placeholder.com/550');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 1; i < 20; i++)
            Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('Test $i');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.document_scanner),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filename $i',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '920 Bytes',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class LinksTab extends StatelessWidget {
  final id;
  LinksTab({
    Key? key,
    required this.id,
  }) : super(key: key);
  final List<String> placeholderImages =
      List.generate(30, (index) => 'https://via.placeholder.com/550');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 1; i < 20; i++)
            Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('Test $i');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      i == 2 || i == 5
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/100"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 25),
                              child: Text(''),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Icon(Icons.link),
                            ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Link Title $i',
                            style: TextStyle(fontSize: 14),
                          ),
                          if (i == 2 || i == 5)
                            Text(
                              'example.com',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
