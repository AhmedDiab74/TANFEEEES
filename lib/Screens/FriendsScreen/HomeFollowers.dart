import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wowondertimelineflutterapp/Screens/FriendsScreen/FollowersScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/FriendsScreen/FollowingScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class HomeFollowers extends StatefulWidget {
   HomeFollowers({super.key, this.indexInt});
final indexInt;
  @override
  State<HomeFollowers> createState() => _HomeFollowersState();
}

class _HomeFollowersState extends State<HomeFollowers> {
  int indexInt = 0;
  indexint({required int index, required String titl}) {
    setState(() {
      title = titl;
      indexInt = index;
    });
  }

  String title = 'Following';
  @override
 void initState() {

  if(widget.indexInt!=null){
 indexInt=2;
  }else{
    indexInt=0;
  }


    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.tr),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CircleAvatar(
          //       backgroundColor: Color.fromARGB(47, 118, 120, 121),
          //       child: IconButton(
          //           onPressed: () {
          //             // Get.to(SerachScreenPage());
          //           },
          //           icon: Icon(
          //             Icons.search,
          //             size: 20,
          //           ))),
          // )
        ],
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                _Haeder(
                  OnTaps: () {
                    indexint(index: 0, titl: 'Following');
                  },
                  ColorBool: indexInt == 0,
                  title: 'Following',
                ),
                SizedBox(
                  width: 10,
                ),
                _Haeder(
                  OnTaps: () {
                    indexint(index: 2, titl: 'Followers');
                  },
                  ColorBool: indexInt == 2,
                  title: 'Followers',
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          if (indexInt == 0) Expanded(child: FollowingScreen()),
          if (indexInt == 2) Expanded(child: FollowersScreen()),
        ],
      ),
    );
  }
}

class _Haeder extends StatelessWidget {
  _Haeder({
    required this.title,
    required this.ColorBool,
    super.key,
    required this.OnTaps,
  });
  String title;
  bool ColorBool;
  final OnTaps;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          OnTaps();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  ColorBool ? ColorTheme : Color.fromARGB(108, 118, 120, 121),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
