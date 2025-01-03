import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyVideo.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyImageScreen extends StatefulWidget {
  const MyImageScreen({super.key});

  @override
  State<MyImageScreen> createState() => _MyImageScreenState();
}

class _MyImageScreenState extends State<MyImageScreen> {
  bool led = false;
  List<PostModel> data = [];
  void getmyvideo() async {
    setState(() {
      led = true;
    });
    ApiGetMyVideo.Getposts('0', 'photos').then((value) {
      setState(() {
        data = value.toList();
        led = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getmyvideo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Image'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
        elevation: 1,
      ),
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: data[index].postFile,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      ),
                    )),
              ),
            );
          }),
        ),
      ),
    );
  }
}
