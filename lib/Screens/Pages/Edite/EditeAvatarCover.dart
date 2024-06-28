import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdataAvatCoverPage.dart';

class EditeAvatarCover extends StatefulWidget {
  final String page_id;
  const EditeAvatarCover({
    super.key,
    required this.page_id,
  });

  @override
  State<EditeAvatarCover> createState() => _EditeAvatarCoverState();
}

class _EditeAvatarCoverState extends State<EditeAvatarCover> {
  bool loding = false;
  final ImagePicker picker = ImagePicker();
  XFile? Cover;
  Future<void> UplodeCover(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    print(picker);
    setState(() {
      Cover = image;
    });
  }

  XFile? avatar;
  Future<void> UplodeAvatar(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    print(picker);
    setState(() {
      avatar = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: Get.width,
            height: Get.height * 0.28,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    UplodeCover(ImageSource.gallery);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.20,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(69, 158, 158, 158),
                      ),
                      child: Cover != null
                          ? Image.file(
                              File(Cover!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(child: Icon(Icons.image_rounded)),
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        UplodeAvatar(ImageSource.gallery);
                      },
                      child: CircleAvatar(
                        maxRadius: 55,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: avatar == null
                              ? null
                              : Image.file(File(avatar!.path)).image,
                          child: Center(
                            child:
                                avatar != null ? null : Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        loding
            ? Center(
                child: CircularProgressIndicator(),
              )
            : InkWell(
                onTap: () async {
                  setState(() {
                    loding = true;
                  });
                  await ApiUpdataAvatCoverPage.uplde(
                      page_id: widget.page_id,
                      cover: Cover?.path,
                      avat: avatar?.path);
                  setState(() {
                    loding = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
