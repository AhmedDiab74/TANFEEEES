import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/MyPages.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/LikedPages.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class AllPagesScreen extends StatefulWidget {
  const AllPagesScreen({super.key});

  @override
  State<AllPagesScreen> createState() => _AllPagesScreenState();
}

class _AllPagesScreenState extends State<AllPagesScreen> {
  int indexInt = 0;
  indexint({required int index, required String titl}) {
    setState(() {
      title = titl;
      indexInt = index;
    });
  }

  String title = 'My Pages';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.tr),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                backgroundColor: Color.fromARGB(47, 118, 120, 121),
                child: IconButton(
                    onPressed: () {
                      // Get.to(SerachScreenPage());
                    },
                    icon: Icon(
                      Icons.search,
                      size: 20,
                    ))),
          )
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
                    indexint(index: 0, titl: 'My Pages');
                  },
                  ColorBool: indexInt == 0,
                  title: 'My Pages',
                ),
                SizedBox(
                  width: 10,
                ),
                _Haeder(
                  OnTaps: () {
                    indexint(index: 2, titl: 'Liked Page');
                  },
                  ColorBool: indexInt == 2,
                  title: 'Liked Page',
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          if (indexInt == 0) Expanded(child: MyPages()),
          if (indexInt == 2) Expanded(child: LikedPages()),
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
