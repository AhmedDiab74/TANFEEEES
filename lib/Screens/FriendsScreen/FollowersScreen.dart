import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetFollo.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<GetAllFrindsModel> data = [];
  TextEditingController controller = new TextEditingController();
  String userid = '0';
  GetAllFrind() async {
    await ApiGetFollo.get(
            user_id: userid, following_offset: userid, typeGet: 'followers')
        .then((ameen) {
      setState(() {
        data = ameen.toList();
        userid = data[data.length - 1].user_id;
      });
    });
  }

  @override
  void initState() {
    GetAllFrind();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void refesh() async {
    await ApiGetFollo.get(
            user_id: userid, following_offset: '0', typeGet: 'followers')
        .then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : userid = value[value.length - 1].user_id;

        _refreshController.refreshCompleted();
      });
    });
  }

  void onLoding() async {
    var list = await ApiGetFollo.get(
        user_id: userid, following_offset: userid, typeGet: 'followers');
    if (list.length - 1 == -1 ? false : userid.isNotEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 1].user_id;
    if (userid.isEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 2].user_id;
    print(userid);
    // ignore: unnecessary_null_comparison
    userid == null ? dispose() : data.addAll(list);

    _refreshController.loadComplete();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            'Followers'.tr,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        ///tapBar
        Expanded(
          child: SmartRefresher(
            onRefresh: refesh,
            onLoading: onLoding,
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < data.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Card(
                        surfaceTintColor:
                            Get.isDarkMode ? Colors.black : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: sizedwidth(context) * 0.80,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      ProfileUserScreen(
                                          user_id: data[i].user_id, avat: data[i].avatar, cover: data[i].cover, name: data[i].name,),
                                      arguments: data[i].user_id,
                                    );
                                    ;
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 25,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                data[i].avatar),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                Stringlength(
                                                  text: data[i].name,
                                                  length: 20,
                                                ),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Text(
                                              data[i].friends_count.toString() +
                                                  ' ' +
                                                  'mutual frinds'.tr,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // if (false)
                              //   InkWell(
                              //     onTap: () {
                              //       ApiFollowUser.folow(data[i].user_id);
                              //       setState(() {
                              //         data.removeAt(i);
                              //       });
                              //     },
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(5),
                              //           color: ColorThame),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Text(
                              //           'Follow',
                              //           style: TextStyle(
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.w700),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                          
                          
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
