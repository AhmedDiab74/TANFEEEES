import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogPost.dart';

class CateogoryPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cateogory'),
        backgroundColor: ColorTheme,
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: InkWell(
                onTap: () {
                  Get.to(BlogPostScreen(
                    id: '3',
                    title: '',
                    category: '',
                    thumbnail: '',
                    shared: '',
                    view: '',
                    tags_array: [],
                    avat: '',
                    name: '',
                    Posted: '',
                    url: '',
                    description: '',
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
                              borderRadius: BorderRadius.circular(15)),
                          child: Image(
                            image: Image.network(
                                    'https://img.freepik.com/free-photo/workplace-with-smartphone-laptop-black-table-top-view-copyspace-background_144627-24860.jpg')
                                .image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                            left: 18,
                            top: 12,
                            child: Chip(
                              label: Row(children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('5 Views')
                              ]),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            )),
                        Positioned(
                            right: 18,
                            top: 12,
                            child: Chip(
                              label: Text('Science and Technology'),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'State Management in Flutter',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Stringlength(
                                text:
                                    'Flutter is an open-source UI framework developed by Google that allows developers to create visually stunning native applications for multiple platforms, including iOS, Android, Web, and desktop, using a single codebase. This article delves into the details of what Flutter is',
                                length: 180),
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage: NetworkImage(
                                              'https://demo.ameenhost.com/upload/photos/d-avatar.jpg?cache=0'),
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
                                        'Chaudhry Hamza',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Posted: 1 h'),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    color: ColorTheme,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  'Read More...',
                                  style: TextStyle(color: Colors.white),
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
          );
        },
      ),
    );
  }
}
