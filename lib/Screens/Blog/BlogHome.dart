import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogPost.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetWebViewRequst.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchBlogs.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FechBlogsModel.dart';

class BlogHome extends StatefulWidget {
  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> {
  List<FechBlogsModel> data = [];
  fetchBlogs() {
    ApiFetchBlogs.Fetch().then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  void initState() {
    fetchBlogs();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        title: Text('Blog'),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
        actions: [
          Container(
            // padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            child: InkWell(
              onTap: () async {
                Get.to(WidgetWebViewRequst(
                  appBar: false,
                  token: await SharedP.Get('tok'),
                  urls: 'create-blog',
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? ColorDarkBackground : Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text("Post".tr,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            color: Get.isDarkMode ? Colors.white : ColorTheme)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: data.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      height: Get.height * 0.25,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: () {
                              Get.to(BlogPostScreen(
                                id: data[i].id,
                                title: data[i].title,
                                category: data[i].category,
                                thumbnail: data[i].thumbnail,
                                shared: data[i].shared,
                                view: data[i].view,
                                tags_array: data[i].tags_array,
                                avat: data[i].author['avatar'],
                                name: data[i].author['name'],
                                Posted: data[i].posted,
                                url: data[i].url,
                                description: data[i].description,
                              ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.height * 0.25,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    data[i].thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    bottom: 10,
                                    left: 8,
                                    right: 8,
                                    child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                        ReplaceCharacter(data[i].title),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        },
                        itemCount: data.length >= 5 ? 5 : data.length,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      )),
                  Column(
                    children: [
                      for (var i = 1; i < data.length; i++)
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                              onTap: () {
                                Get.to(BlogPostScreen(
                                  id: data[i].id,
                                  title: data[i].title,
                                  category: data[i].category,
                                  thumbnail: data[i].thumbnail,
                                  shared: data[i].shared,
                                  view: data[i].view,
                                  tags_array: data[i].tags_array,
                                  avat: data[i].author['avatar'],
                                  name: data[i].author['name'],
                                  Posted: data[i].posted,
                                  url: data[i].url,
                                  description: data[i].description,
                                ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        width: Get.width,
                                        height: Get.height * 0.20,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Image(
                                          image:
                                              Image.network(data[i].thumbnail)
                                                  .image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Positioned(
                                        left: 18,
                                        top: 10,
                                        child: Chip(
                                          label: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text('${data[i].view} ' +
                                                  'Views'.tr),
                                            ],
                                          ),
                                          backgroundColor: Get.isDarkMode
                                              ? ColorDarkComponents
                                              : Colors.white,
                                        ),
                                      ),
                                      Positioned(
                                        right: 18,
                                        top: 10,
                                        child: Chip(
                                          label: Row(
                                            children: [
                                              // Icon(Icons.remove_red_eye),
                                              Text(data[i].category),
                                            ],
                                          ),
                                          backgroundColor: Get.isDarkMode
                                              ? ColorDarkComponents
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[i].title,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          Stringlength(
                                              text: data[i].description,
                                              length: 180),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    maxRadius: 25,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: CircleAvatar(
                                                        maxRadius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                data[i].author[
                                                                    'avatar']),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Stringlength(
                                                          text: data[i]
                                                              .author['name'],
                                                          length: 25),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('Posted:'.tr +
                                                        '${data[i].posted}'),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Get.isDarkMode
                                                      ? ColorDarkBackground
                                                      : ColorTheme,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                'Read More...'.tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
