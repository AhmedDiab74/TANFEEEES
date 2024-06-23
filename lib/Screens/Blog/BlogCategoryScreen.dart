import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/CategoryPosts.dart';

class CategoriesPage extends StatelessWidget {
  final List<String> items = List.generate(30, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: ColorTheme,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            for (var i = 1; i < Blog_Categories.length; i++)
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.to(CateogoryPosts());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${Blog_Categories['${i}']!.toString()}",
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        )),
      ),
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 3,
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //       ),
      //       itemCount: Blog_Categories.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return GridTile(
      //           child: InkWell(
      //             onTap: () {
      //               Get.to(CateogoryPosts());
      //             },
      //             child: Container(
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(10),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.black.withOpacity(0.2),
      //                       blurRadius: 1,
      //                     )
      //                   ]),
      //               child: Center(
      //                 child: Text(
      //                   "${Blog_Categories['${index+1}']!.toString()}",
      //                   style: TextStyle(color: Colors.black),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
