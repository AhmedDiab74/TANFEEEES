import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({
    super.key,
    required this.photoMulti2,
    required this.contLike,
    required this.contcoment,
    required this.post_share,
    required this.postimage,
    required this.type,
    required this.islike,
    required this.post_id,
  });

  final photoMulti2;
  final contLike;
  final contcoment;
  final post_share;
  final postimage;
  final type;
  final islike;
  final post_id;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  int dot = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 30,
      height: widget.photoMulti2.length == 3
          ? Get.height * 0.28
          : Get.height * 0.50,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              widget.photoMulti2.length == 3 ? 3 : 2, // Number of columns
          crossAxisSpacing: 4, // Spacing between columns
          mainAxisSpacing: 4, // Spacing between rows
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            (widget.photoMulti2.length > 3) ? 4 : widget.photoMulti2.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < 3) {
            // Build and return the individual grid items for the first 3 items
            return InkWell(
              onTap: () {
                Get.to(NewWidget(
                  photoMulti2: widget.photoMulti2,
                  photoMulti2Lin: index,
                ));
              },
              child: CachedNetworkImage(
                width: Get.width * 80,
                height: Get.height * 0.30,
                imageUrl: widget.photoMulti2[index]['image'].toString(),
                fit: BoxFit.cover,
              ),
            );
          } else if (index >= 3) {
            // Build the 4th item with the remaining count
            int remainingCount = widget.photoMulti2.length - 3;
            return InkWell(
              onTap: () {
                Get.to(NewWidget(
                  photoMulti2: widget.photoMulti2,
                  photoMulti2Lin: index,
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(
                      widget.photoMulti2[index]['image']
                          .toString(), // Replace with your image URL
                    ).image,
                    fit: BoxFit
                        .fitHeight, // You can use different values depending on your needs
                  ),
                ),
                child: Container(
                    color: Colors.black.withOpacity(0.6),
                    alignment: Alignment.center,
                    child: Text(
                      '+${widget.photoMulti2.length - 3}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            );
          }
        },
      ),
      //         child: GridView.builder(
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2, // Number of columns
      //   crossAxisSpacing: 0.0, // Spacing between columns
      //   mainAxisSpacing: 0.0, // Spacing between rows
      // ),
      //           // onPageChanged: (val) {
      //           //   setState(() {
      //           //     dot = val;
      //           //   });
      //           // },
      //           itemBuilder: ((context, index) {
      //             return ClipRRect(
      //               borderRadius: BorderRadius.circular(0),
      //               child: InkWell(
      //                 onTap: () {
      //                   Get.to(NewWidget(
      //                     photoMulti2: widget.photoMulti2,
      //                     photoMulti2Lin: index,
      //                   ));
      //                 },
      //                 child: CachedNetworkImage(
      //                   width: Get.width * 80,
      //                   height: Get.height * 0.30,
      //                   imageUrl: widget.photoMulti2[index]['image'].toString(),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             );
      //           }),
      //           itemCount: 3,
      //         ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    required this.photoMulti2Lin,
    super.key,
    this.ontap,
    this.delete,
    required this.photoMulti2,
  });
  final photoMulti2Lin;
  final photoMulti2;
  final delete;
  final ontap;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          actions: [
            if (widget.delete != null)
              IconButton(
                  onPressed: widget.delete,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ))
          ],
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: PageView.builder(
            controller: PageController(
              initialPage: widget.photoMulti2Lin.toInt(),
            ),
            pageSnapping: true,
            onPageChanged: (value) {},
            padEnds: false,
            itemCount: widget.photoMulti2.length,
            itemBuilder: (BuildContext context, int index) {
              return PhotoView(
                imageProvider: NetworkImage(widget.photoMulti2[index]['image']),
              );
            },
          ),
        ));
  }
}
