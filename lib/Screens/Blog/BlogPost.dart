import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogComment.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/CategoryPosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchBlogs.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogCommentsScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FechBlogsModel.dart';

class BlogPostScreen extends StatefulWidget {
  BlogPostScreen({
    Key? key,
    required this.id,
    required this.tags_array,
    required this.view,
    required this.shared,
    required this.thumbnail,
    required this.category,
    required this.title,
    required this.avat,
    required this.name,
    required this.Posted,
    required this.url,
    required this.description,
  }) : super(key: key);
  final tags_array;
  String view;
  String shared;
  String thumbnail;
  String category;
  String title;
  String avat;
  String name;
  String Posted;
  String url;
  String description;
  String id;
  @override
  _BlogPostScreenState createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  double _fontSize = 16.0;
  final Comments = 1;
  FlutterTts flutterTts = FlutterTts();

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize = _fontSize - 2.0 > 0 ? _fontSize - 2.0 : 1.0;
    });
  }

  List<FechBlogsModel> data = [];
  getApi() {
    ApiFetchBlogsById.Fetch(blog_id: widget.id).then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  final List<dynamic> tagsArray = [];

  @override
  void initState() {
    getApi();
    tagsArray.addAll(widget.tags_array);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundImage: NetworkImage(widget.avat),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Posted:'.tr + ' ${widget.Posted}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ),
        actions: [
          Row(
            children: [
              ActionBarButtons(
                icon: Icons.share,
                onTap: () async {
                  String text = 'Check out this Article:'.tr + ' ${widget.url}';
                  Share.share(text);
                },
              ),
              ActionBarButtons(
                icon: Icons.copy,
                onTap: () async {
                  final String linkToCopy =
                      'Check out this Article:'.tr + ' ${widget.url}';
                  Clipboard.setData(ClipboardData(text: linkToCopy));
                  final snackBar = SnackBar(
                    content: Text('Link copied to clipboard'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          child: Image(
                              image: Image.network(widget.thumbnail).image),
                        ),
                        Positioned(
                            left: 18,
                            top: 18,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? ColorDarkComponents
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(children: [
                                Icon(Icons.remove_red_eye),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('${widget.view} ' + 'Views'.tr)
                              ]),
                            )),
                        Positioned(
                            right: 18,
                            top: 18,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? ColorDarkComponents
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('${widget.shared} ' + 'Shares'.tr)
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (() {
                              // Get.to(CateogoryPosts());
                            }),
                            child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 2,
                                          offset: Offset(1, 1))
                                    ],
                                    color: Get.isDarkMode
                                        ? ColorDarkComponents
                                        : ColorTheme,
                                    borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Text(
                                  widget.category,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                          Row(
                            children: [
                              CenterButtons(
                                icon: Icons.add,
                                onTap: () {
                                  _increaseFontSize();
                                },
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              CenterButtons(
                                icon: Icons.remove,
                                onTap: () {
                                  _decreaseFontSize();
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    data.length == 0
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Html(
                              data: data[0].content,
                              style: {
                                "html": Style(
                                  fontSize: FontSize(
                                      _fontSize), // Change the font size here
                                ),
                              },
                            )),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text(
                    //     Description,
                    //     style: TextStyle(fontSize: _fontSize),
                    //     textAlign: TextAlign.justify,
                    //   ),
                    // ),
                    Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 0,
                        children:
                            List<Widget>.generate(tagsArray.length, (index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            margin: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? ColorDarkComponents
                                    : ColorTheme,
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.tag_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  tagsArray[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Divider(),
                    Comments == 1
                        ? Row(
                            children: [
                              Container(
                                // color: Colors.blue,
                                height: Get.height * 0.3,
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 50,
                                    ),
                                    Text(
                                      'No comments yet'.tr,
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              for (var i = 0; i < 3; i++) CommentsTile(),
                              InkWell(
                                onTap: () {
                                  Get.to(BlogCommentsScreen());
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  padding: EdgeInsets.all(8),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'More Comments'.tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  )),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
            if (false)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(-1, -1))
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.emoji_emotions),
                      onPressed: () {
                        // Add your logic here for emoji button
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your Comment...',
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Add your logic here for sending the comment
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ActionBarButtons extends StatelessWidget {
  ActionBarButtons({
    required this.icon,
    this.onTap,
    super.key,
  });

  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              if (onTap != null) onTap();
            },
            child: Container(padding: EdgeInsets.all(15), child: Icon(icon))),
      ),
    );
  }
}

class CenterButtons extends StatelessWidget {
  CenterButtons({
    required this.icon,
    this.onTap,
    super.key,
  });

  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 2, offset: Offset(1, 1))
          ],
          color: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
          borderRadius: BorderRadius.circular(50)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
