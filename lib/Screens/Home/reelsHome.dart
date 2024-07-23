import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReels.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';

class ReelsRecomend extends StatefulWidget {
  const ReelsRecomend({
    super.key,
  });

  @override
  State<ReelsRecomend> createState() => _ReelsRecomendState();
}

class _ReelsRecomendState extends State<ReelsRecomend> {
  List<PostModel> data = [];
  GetReelsApi() async {
    await ApiReels.Getposts('0').then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  void initState() {
    GetReelsApi();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      width: sizedwidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reels'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.replay))
              ],
            ),
          ),
          Container(
            width: sizedwidth(context),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < data.length; i++)
                    InkWell(
                      onTap: () {
                        // Get.to(
                        //     duration: Duration(milliseconds: 300),
                        //     transition: Transition.circularReveal,
                        //     VideoReelsScreen(
                        //       lastId: data[i].post_id,
                        //     ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          width: sizedwidth(context) * 0.35,
                          height: sizedHeight(context) * 0.30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      data[i].postFileThumb)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 25,
                                      child: CircleAvatar(
                                        maxRadius: 23,
                                        backgroundImage:
                                        CachedNetworkImageProvider(
                                            data[i].avatar),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          data[i].videoViews,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(93, 0, 0, 0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 1),
                                    child: Text(
                                      TextLength(nump: 11, name: data[i].name),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: sizedwidth(context),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Get.isDarkMode ? Colors.black : Color(0xFFF1F4F5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String TextLength({required int nump, required String name}) {
  return name.length > nump ? name.substring(0, nump) + '...' : name;
}