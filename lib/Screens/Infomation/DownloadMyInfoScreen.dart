import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDownInfo.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/WithdarawalsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DownloadMyInfoScreen extends StatefulWidget {
  const DownloadMyInfoScreen({
    super.key,
    required this.name,
    required this.avat,
  });

  final String name;
  final String avat;

  @override
  State<DownloadMyInfoScreen> createState() => _DownloadMyInfoScreenState();
}

class _DownloadMyInfoScreenState extends State<DownloadMyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarTrueOrFalse: true,
      // centerTitle: false,
      // elevation: 0,
      // loding: false,
      // title: 'Download My Information'.tr,
      appBar: AppBar(
        title: Text(
          'Download My Information'.tr,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 30,
                        backgroundImage:
                            CachedNetworkImageProvider(widget.avat),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        widget.name,
                        style: SafeGoogleFont(Fonts.font3,
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Please choose which informaiton you would like to download'.tr,
                style: SafeGoogleFont(Fonts.font1,
                    fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _WidgetDwonload(
                    text: 'My Informaiton'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('my_information');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                  _WidgetDwonload(
                    text: 'Download Post'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('posts');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                  _WidgetDwonload(
                    text: 'Download Groups'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('groups');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                  _WidgetDwonload(
                    text: 'Download Pages'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('pages');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                  _WidgetDwonload(
                    text: 'Download Followers'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('followers');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                  _WidgetDwonload(
                    text: 'Download Following'.tr,
                    onTap: () async {
                      final dwon = await ApiDownInfo.down('following');
                      print(dwon['link'].toString());
                      await UrlGo(dwon['link']);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WidgetDwonload extends StatelessWidget {
  _WidgetDwonload({
    required this.text,
    this.onTap,
    super.key,
  });

  final String text;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (onTap != null) onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              // color: Colors.blue,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : ColorTheme,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
