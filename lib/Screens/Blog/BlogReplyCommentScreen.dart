import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogReplyCommentsScreen extends StatefulWidget {
  @override
  _BlogReplyCommentsScreenState createState() =>
      _BlogReplyCommentsScreenState();
}

class _BlogReplyCommentsScreenState extends State<BlogReplyCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies'),
        backgroundColor: ColorTheme,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ReplyCommentTile(),
            for (var i = 0; i < 30; i++) ReplyCommentsTile(),
          ],
        ),
      )),
    );
  }
}

class ReplyCommentTile extends StatelessWidget {
  ReplyCommentTile({
    this.name,
    this.comment,
    super.key,
  });

  final name;
  final comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'https://demo.ameenhost.com/upload/photos/d-avatar.jpg?cache=0'),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Stringlength(text: 'Chaudhry Hamza', length: 30),
                            style: SafeGoogleFont(Fonts.font3,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '1h ago',
                            style: SafeGoogleFont(
                              Fonts.font3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('asdasdasd'),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Divider(),
                          SvgPicture.asset(
                            SvgImages.CommentBtn,
                            height: 25,
                            width: 25,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            '0',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            'Comments'.tr,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReplyCommentsTile extends StatelessWidget {
  ReplyCommentsTile({
    this.icon,
    this.onTap,
    super.key,
  });

  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'https://demo.ameenhost.com/upload/photos/d-avatar.jpg?cache=0'),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        Stringlength(text: 'Chaudhry Hamza', length: 30),
                        style: SafeGoogleFont(Fonts.font3,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.bottomSheet(Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          child: Column(
                            children: [
                              Text('asdasdasd'),
                            ],
                          ),
                        ));
                      },
                      icon: Icon(Icons.more_horiz))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('asdasdasd'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
