import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StroyWidget extends StatelessWidget {
  StroyWidget(
      {super.key,
      required this.images,
      required this.name,
      required this.avatir});
  String images;
  final name;
  String avatir;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: ColorTheme),
          height: Get.height * 0.10,
          width: Get.width * 0.20,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(images, scale: 1.0,maxWidth: 50,maxHeight: 50))),
                ),
              ),
              Positioned(
                  top: 2,
                  right: 0,
                  child: CircleAvatar(
                    maxRadius: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        maxRadius: 15,
                        backgroundImage: CachedNetworkImageProvider(avatir,maxHeight: 25,maxWidth: 25,),
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Text(
          name,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class StroyWidgetv2 extends StatelessWidget {
  StroyWidgetv2(
      {super.key,
      required this.images,
      required this.name,
      required this.avatir});
  String images;
  final name;
  String avatir;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Get.isDarkMode
              ? ColorDarkBackground
              : Theme.of(context).scaffoldBackgroundColor),
      height: Get.height * 0.16,
      width: Get.width * 0.25,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Get.height * 0.12,
                width: Get.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      maxWidthDiskCache: 150,
                      maxHeightDiskCache: 150,
                      imageUrl: images,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 5,
                  left: 5,
                  child: CircleAvatar(
                    maxRadius: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        maxRadius: 15,
                        backgroundImage: CachedNetworkImageProvider(avatir,maxHeight: 150,maxWidth: 150),
                      ),
                    ),
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              name,
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
