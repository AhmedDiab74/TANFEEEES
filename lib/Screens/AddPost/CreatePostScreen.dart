import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/bubbleAudio.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/VideoList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostCont.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({
    Key? key,
    this.open,
    this.update,
    this.namePage,
    this.avat,
    required this.typeBackPost,
  }) : super(key: key);
  final String? open;
  final update;
  final String? namePage;
  final String? avat;
  final String typeBackPost;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String postPrivacu = '0';
  bool newPool = false;
  openWidget(controller) async {
    if (widget.open != null) {
      if (widget.open == 'gallery')
        Get.bottomSheet(WidgetPhotoAnvideo(controller));
    }
  }

  void getPublicSgerd() async {
    Get.put(CreatePostCont());
    var getpublic = await SharedP.Get('PostPublic');
    setState(() {
      postPrivacu = getpublic == null ? '0' : getpublic;
    });
  }

  String backColorPost = '';
  String backImagePost = '';
  @override
  void initState() {
    getPublicSgerd();

    super.initState();
  }

  savePublicSherd() async {
    await SharedP.Save('PostPublic', postPrivacu);
  }

  int addNewPoll = 2;
  int plusNewpoll = 2;
  String smaileText = '';
  String smaileIcon = '';
  bool ColorPostsMenu = false;
  bool ColorPosts = false;

  void toggleColorPostsMenu() {
    setState(() {
      ColorPostsMenu = !ColorPostsMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostCont>(
        init: CreatePostCont(),
        builder: ((controller) {
          openWidget(controller);

          return Scaffold(
            backgroundColor:
                Get.isDarkMode ? ColorDarkBackground : Colors.white,
            // bottomNavigationBar:

            appBar: AppBar(
              centerTitle: false,
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
              backgroundColor:
                  Get.isDarkMode ? ColorDarkComponents : Colors.white,
              title: Text('Create Post'.tr,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 18)),
              actions: [
                InkWell(
                  onTap: () async {
                    controller.CreatPost(postPrivacu);

                    if (widget.typeBackPost == 'HomeScreen') {
                      Get.offAll(HomeNavBar());
                      controller.cleare();
                    } else if (widget.typeBackPost == 'myPofile') {
                      Get.back();
                      widget.update();
                      controller.cleare();
                    } else if (widget.typeBackPost == 'Group') {
                      Get.back();
                      widget.update();
                      controller.cleare();
                    } else if (widget.typeBackPost == 'Page') {
                      Get.back();
                      widget.update();
                      controller.cleare();
                    }
                    // if (await widget.myprofile != null) {
                    //   Get.offAll(HomeNavBar());
                    //   controller.cleare();
                    // } else {
                    //   Get.back();
                    //   widget.update();
                    //   controller.cleare();
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode
                            ? colorTextBoardingDark1
                            : colorTextBoardingLight1,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Text("Post".tr,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GetBuilder<GetMyUserDataCont>(
                              init: GetMyUserDataCont(),
                              builder: ((controller) => Row(
                                    children: [
                                      for (var i = 0;
                                          i < controller.data.length;
                                          i++)
                                        CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  widget.avat != null
                                                      ? widget.avat.toString()
                                                      : controller
                                                          .data[i].avatar),
                                        ),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (var i = 0;
                                              i < controller.data.length;
                                              i++)
                                            Text(
                                              widget.namePage != null
                                                  ? widget.namePage.toString()
                                                  : controller.data[i].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          InkWell(
                                            onTap: () {
                                              Get.bottomSheet(Pivacy());
                                            },
                                            child: Row(
                                              children: [
                                                if (postPrivacu == '1')
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/photos-selection-svgrepo-com.svg',
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : null,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'People I Follow'.tr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                if (postPrivacu == '0')
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/global-search-svgrepo-com.svg',
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : null,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'Everyone'.tr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                if (postPrivacu == '2')
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/colorfilter-svgrepo-com.svg',
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : null,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'People Follow Me'.tr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                if (postPrivacu == '3')
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/profile-wowondertimelineflutterapp-svgrepo-com.svg',
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : null,
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'Only me'.tr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            )),

                        if (smaileIcon.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.smailetext.clear();
                                      smaileIcon = '';
                                    });
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 12,
                                    backgroundColor: colorTextBoardingDark1,
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text('Feel:'.tr),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  controller.smailetext.text.tr,
                                  style: TextStyle(),
                                ),
                                Text(
                                  smaileIcon,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        if (backColorPost.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(int.parse(GetSetList[0]['post_colors']
                                          [backColorPost]['color_2']
                                      .toString()
                                      .replaceAll('#', '0xff'))),
                                  Color(int.parse(GetSetList[0]['post_colors']
                                          [backColorPost]['color_1']
                                      .toString()
                                      .replaceAll('#', '0xff'))),
                                ],
                              )),
                              child: Container(
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller:
                                          controller.textEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: newPool
                                            ? 'Create a poll'.tr
                                            : 'what are you thinking?'.tr,
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(int.parse(GetSetList[0]
                                                      ['post_colors']
                                                  [backColorPost]['text_color']
                                              .toString()
                                              .replaceAll('#', '0xff'))),
                                        ),
                                      ),
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        if (backImagePost.isNotEmpty)
                          Container(
                            width: Get.width,
                            height: Get.height * 0.50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      GetSetList[0]['post_colors']
                                              [backImagePost]['image']
                                          .toString())),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(int.parse(GetSetList[0]
                                                  ['post_colors'][backImagePost]
                                              ['text_color']
                                          .toString()
                                          .replaceAll('#',
                                              '0xff'))), // Set the text color
                                    ),
                                    controller:
                                        controller.textEditingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: Colors.white,
                                      hintText: newPool
                                          ? 'Create a poll'.tr
                                          : 'what are you thinking?'.tr,
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(int.parse(GetSetList[0]
                                                    ['post_colors']
                                                [backImagePost]['text_color']
                                            .toString()
                                            .replaceAll('#', '0xff'))),
                                      ),
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (backImagePost.isEmpty)
                          if (backColorPost.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextField(
                                    controller:
                                        controller.textEditingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: newPool
                                          ? 'Create a poll'.tr
                                          : 'what are you thinking?'.tr,
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    maxLines: null,
                                  ),
                                ],
                              ),
                            ),
                        if (controller.imageFileList.isNotEmpty)
                          Container(
                            height: Get.height * 0.60,
                            width: Get.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: GridView.builder(
                                  itemCount: controller.imageFileList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              controller.imageFileList.length >
                                                      4
                                                  ? 3
                                                  : 2),
                                  itemBuilder: ((context, index) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: InkWell(
                                            onTap: () {
                                              controller.reomveSelected(index);
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: Get.width * 0.60,
                                                  height: Get.height * 0.09,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          colorTextBoardingDark1,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                    width: Get.width * 0.60,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 21,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.05,
                                        ),
                                        Container(
                                          width: Get.width * 0.70,
                                          height: Get.height * 0.70,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.file(
                                                  File(controller
                                                      .imageFileList[index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                      ],
                                    );
                                  })),
                            ),
                          ),
                        if (newPool)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(56, 158, 158, 158),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          newPool = false;
                                          controller.poll1.clear();
                                          controller.poll2.clear();
                                          controller.poll3.clear();
                                          controller.poll4.clear();
                                          controller.poll5.clear();
                                          controller.poll6.clear();
                                          controller.poll7.clear();
                                          controller.poll8.clear();
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 12,
                                        backgroundColor: colorTextBoardingDark1,
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 1'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll2,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 2'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    if (2 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll3,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 3'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (3 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll4,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 4'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (4 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll5,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 5'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (5 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll6,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 6'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (6 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll7,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 7'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (7 < addNewPoll)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    118, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: TextField(
                                                controller: controller.poll8,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Question 8'.tr,
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    if (2 < addNewPoll)
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              addNewPoll--;
                                            });
                                          },
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  colorTextBoardingDark1,
                                              child: Icon(Icons.delete,
                                                  color: Colors.white))),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    if (addNewPoll != 8)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            addNewPoll++;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: colorTextBoardingDark1,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text('Add'.tr,
                                                    style: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 16))),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        controller.ImagePost != null
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.ImagePost = null;
                                      });
                                    },
                                    child: Container(
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: colorTextBoardingDark1,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Image.file(
                                    File(controller.ImagePost!.path),
                                    width: Get.width * 0.5,
                                  ),
                                ],
                              )
                            : SizedBox(),
                        //  Image.file(File(controller.ameenhamed!.path)),

                        controller.videoUp != null
                            ? VideosList(
                                videoPlayerController:
                                    VideoPlayerController.file(
                                  File(controller.videoUp!.path),
                                ),
                                looping: true)
                            : SizedBox(),
                        if (controller.gifs != null)
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.removeGif();
                                      },
                                      icon: Icon(Icons.cancel)),
                                ],
                              ),
                              GiphyImage.original(gif: controller.gifs!),
                            ],
                          ),
                                    if (controller.nameFilee != null)
                  if (!controller.musicFile.toString().isAudioFileName)
                    Container(
                      width: sizedwidth(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.file_present,
                                  color: Color.fromARGB(255, 173, 185, 44),
                                  size: 60,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: sizedwidth(context) * 0.60,
                                  child: Text(controller.nameFilee.toString()),
                                ),
                              ],
                            ),
                            IconButton.outlined(
                                onPressed: () {
                                  controller.removeFile();
                                },
                                icon: Icon(Icons.cancel))
                          ],
                        ),
                      ),
                    ),
               
                                      if (controller.musicFile.toString().isAudioFileName)
                  WaveBubble(
                    path: controller.musicFile,
                    isSender: true,
  
                  ),
                if (controller.recordsCreate)
                  Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.updateRecore(false);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      if (controller.isRecordingCompleted)
                        if (isAudio(controller.pathRecord.toString()))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WaveBubble(
                                path: controller.pathRecord,
                                isSender: true,
                             
                              ),
                            ],
                          ),
                      if (controller.isRecording)
                        if (controller.pathRecord.toString().isAudioFileName)
                          AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: AudioWaveforms(
                                enableGesture: true,
                                size: Size(
                                    MediaQuery.of(context).size.width / 2, 50),
                                recorderController:
                                    controller.recorderController,
                                waveStyle: const WaveStyle(
                                  waveColor: Colors.white,
                                  extendWaveform: true,
                                  showMiddleLine: false,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: const Color(0xFF1E1B26),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: controller.startOrStopRecording,
                          child: CircleAvatar(
                            maxRadius: 50,
                            backgroundColor: Colors.red,
                            child: Icon(
                              controller.isRecordingCompleted
                                  ? Icons.delete
                                  : controller.isRecording
                                      ? Icons.stop
                                      : Icons.mic,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                        if (controller.postTr != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.updateTr(null);
                                        },
                                        icon: Icon(Icons.cancel))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      controller.postTr.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    28, 158, 158, 158)),
                                            child: TextField(
                                              controller:
                                                  controller.travlintext,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
                                            )))
                                  ],
                                ),
                              ],
                            ),
                          ),

                        if (controller.postMap)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.updatePostMap(false);
                                        },
                                        icon: Icon(Icons.cancel))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    28, 158, 158, 158)),
                                            child: TextField(
                                              controller:
                                                  controller.postMapText,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
                                            )))
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Row(children: [
                        if (ColorPosts)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: ColorPostsMenu
                                      ? Colors.transparent
                                      : Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  toggleColorPostsMenu();
                                },
                                child: ColorPostsMenu
                                    ? Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                            alignment: Alignment.center,
                                            child:
                                                Icon(Icons.arrow_back_ios_new)),
                                      )
                                    : Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: Image.asset(
                                              SvgImages
                                                  .ColorPost, // Replace with your image URL
                                            ).image,
                                            fit: BoxFit
                                                .cover, // You can use different values depending on your needs
                                          ),
                                        ),
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Aa',
                                              style: GoogleFonts.urbanist(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                              ),
                            ),
                          ),
                        if (ColorPostsMenu)
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        backImagePost = '';
                                        backColorPost = '';
                                        controller.backRound.clear();
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.disabled_by_default,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  for (var i = 1;
                                      i <
                                          GetSetList[0]['post_colors'].length +
                                              1;
                                      i++)
                                    if (GetSetList[0]['post_colors']['$i']
                                            ['image']
                                        .toString()
                                        .isEmpty)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            backImagePost = '';
                                            backColorPost = i.toString();
                                            controller.backRound.text =
                                                i.toString();
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(int.parse(GetSetList[0]
                                                              ['post_colors']
                                                          ['$i']['color_1']
                                                      .toString()
                                                      .replaceAll(
                                                          '#', '0xff'))),
                                                  Color(int.parse(GetSetList[0]
                                                              ['post_colors']
                                                          ['$i']['color_2']
                                                      .toString()
                                                      .replaceAll(
                                                          '#', '0xff'))),
                                                ],
                                              )),
                                        ),
                                      ),
                                  for (var i = 1;
                                      i <
                                          GetSetList[0]['post_colors'].length +
                                              1;
                                      i++)
                                    if (GetSetList[0]['post_colors']['$i']
                                            ['image']
                                        .toString()
                                        .isNotEmpty)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            backImagePost = i.toString();
                                            backColorPost = '';
                                            controller.backRound.text =
                                                i.toString();
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: GetSetList[0]
                                                ['post_colors']['$i']['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),

                        // for (var i = 1;
                        //     i < GetSetList[0]['post_colors'].length + 1;
                        //     i++)
                        //   if (GetSetList[0]['post_colors']['$i']['image']
                        //       .toString()
                        //       .isEmpty)
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           backImagePost = '';
                        //           backColorPost = i.toString();
                        //           controller.backRound.text = i.toString();
                        //         });
                        //       },
                        //       child: Container(
                        //          width: 40,
                        //         height: 40,
                        //         decoration: BoxDecoration(
                        //             gradient: LinearGradient(
                        //           begin: Alignment.topRight,
                        //           end: Alignment.bottomLeft,
                        //           colors: [
                        //             Color(int.parse(GetSetList[0]
                        //                     ['post_colors']['$i']['color_1']
                        //                 .toString()
                        //                 .replaceAll('#', '0xff'))),
                        //             Color(int.parse(GetSetList[0]
                        //                     ['post_colors']['$i']['color_2']
                        //                 .toString()
                        //                 .replaceAll('#', '0xff'))),
                        //           ],
                        //         )),
                        //       ),
                        //     ),
                        // for (var i = 1;i < GetSetList[0]['post_colors'].length + 1;i++)
                        //   if (GetSetList[0]['post_colors']['$i']['image'].toString().isNotEmpty)
                        //   SizedBox(width: 8,),
                        // for (var i = 1;i < GetSetList[0]['post_colors'].length + 1;i++)
                        //   if (GetSetList[0]['post_colors']['$i']['image'].toString().isNotEmpty)
                        //     InkWell(
                        //       onTap: () {
                        //         print(i);
                        //         setState(() {
                        //           backImagePost = i.toString();
                        //           backColorPost = '';
                        //           controller.backRound.text = i.toString();
                        //         });
                        //       },
                        //       child: Container(
                        //         width: 40,
                        //         height: 40,
                        //         child: CachedNetworkImage(
                        //           imageUrl: GetSetList[0]['post_colors']['$i']
                        //               ['image'],
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                      ]),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? backRoundContDark
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black12)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                        WidgetPhotoAnvideo(controller));
                                  },
                                  child: WidgetPostImagesNav(
                                    images: 'SDF.png',
                                  ),
                                ),
                              ),
                          
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.updatePostMap(true);
                                  },
                                  child: WidgetPostImagesNav(
                                    images: 'Iconly-Bold-Location.png',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.bottomSheet(felling(controller));
                                  },
                                  child: WidgetPostImagesNav(
                                    images: 'hg.png',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWellMreNave(
                                  controller: controller,
                                  onTapVideoImage: () {
                                    Get.back();
                                    Get.bottomSheet(
                                        WidgetPhotoAnvideo(controller));
                                  },
                                  ontapPoll: () {
                                    setState(() {
                                      newPool = true;
                                      Get.back();
                                    });
                                  },
                                  onTapFeling: () {
                                    Get.back();
                                    Get.bottomSheet(felling(controller));
                                  },
                                  onTapColorPost: () {
                                    Get.back();
                                    setState(() {
                                      ColorPosts = !ColorPosts;
                                      ColorPostsMenu = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                            // children: [
                            //   if (false)
                            //     InkWell(
                            //       onTap: () {
                            //         Get.bottomSheet(
                            //             WidgetPhotoAnvideo(controller));
                            //       },
                            //       child: WidgetPostImagesNav(
                            //         images: 'SDF.png',
                            //       ),
                            //     ),
                            //   if (false)
                            //     WidgetPostImagesNav(
                            //       images: 'friend.png',
                            //     ),
                            //   if (false)
                            //     InkWell(
                            //       onTap: () {
                            //         Get.bottomSheet(felling(controller));
                            //       },
                            //       child: WidgetPostImagesNav(
                            //         images: 'hg.png',
                            //       ),
                            //     ),
                            //   if (false)
                            //     WidgetPostImagesNav(
                            //       images: 'Iconly-Bold-Location.png',
                            //     ),
                            //   InkWellMreNave(
                            //     controller: controller,
                            //     onTapVideoImage: () {
                            //       Get.back();
                            //       Get.bottomSheet(
                            //           WidgetPhotoAnvideo(controller));
                            //     },
                            //     ontapPoll: () {
                            //       setState(() {
                            //         newPool = true;
                            //         Get.back();
                            //       });
                            //     },
                            //     onTapFeling: () {
                            //       Get.back();
                            //       Get.bottomSheet(felling(controller));
                            //     },
                            //     onTapColorPost: () {
                            //       Get.back();
                            //       toggleColorPostsMenu();
                            //     },
                            //   ),
                            // ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          );
        }));
  }

  Widget felling(CreatePostCont controller) {
    return Container(
      //height: Get.height * 0.40,
      height: Get.height * 0.40,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.back();
                Get.dialog(Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    height: Get.height * 0.50,
                    width: Get.width * 0.80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScaffoldWidget(
                        title: 'Feeling'.tr,
                        centerTitle: true,
                        elevation: 0,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'happy';

                                    setState(() {
                                      smaileIcon = '😃';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😃',
                                    text: 'Happy'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'loved';

                                    setState(() {
                                      smaileIcon = '🥰';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥰',
                                    text: 'Loved'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'sad';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileIcon = '😞';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😞',
                                    text: 'Sad'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'so_sad';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😭';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😭',
                                    text: 'Very Sad'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'angry';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😡';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😡',
                                    text: 'Angry'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'angry';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;

                                      smaileIcon = '😕';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😕',
                                    text: 'Confused'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'smirk';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🥵';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥵',
                                    text: 'Hot'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'broke';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '💔';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '💔',
                                    text: 'Broken'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text =
                                        'expressionless';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😑';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😑',
                                    text: 'expressionless'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'cool';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😎';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😎',
                                    text: 'Cool'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'funny';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😂';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😂',
                                    text: 'Funny'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'tired';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😫';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😫',
                                    text: 'Tired'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'lovely';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '❤️';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '❤️',
                                    text: 'Lovely'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'blessed';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😇';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😇',
                                    text: 'Blessed'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'shocked';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😵';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😵',
                                    text: 'Shocked',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'sleepy';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😴';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😴',
                                    text: 'Sleepy'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'pretty';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🌺';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🌺',
                                    text: 'Pretty'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'bored';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🥱';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥱',
                                    text: 'Bored'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        loding: false,
                        AppBarTrueOrFalse: true,
                      ),
                    ),
                  ),
                ));
              },
              child: Row(
                children: [
                  WidgetPostImagesNav(
                    images: 'hg.png',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Felling'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            InkWell(
              onTap: () {
                controller.updateTr('Traveling to');
              },
              child: Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: Colors.blue,
                    images: 'travel-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Traveling to'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            InkWell(
              onTap: () {
                controller.updateTr('Watching');
              },
              child: Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: colorTextBoardingDark1,
                    images: 'watching-a-video-on-a-tablet-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Watching'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorTextBoardingDark1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            InkWell(
              onTap: () {
                controller.updateTr('Playing');
              },
              child: Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: false,
                    colorr: Colors.blue,
                    images: 'man-playing-handball-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Playing'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            InkWell(
              onTap: () {
                controller.updateTr('Listening to');
              },
              child: Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: Colors.deepPurpleAccent,
                    images: 'listening-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Listening to'.tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Pivacy() {
    return Container(
      width: Get.width,
      height: Get.height * 0.45,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.04),
            InkWell(
              onTap: () {
                setState(() {
                  postPrivacu = '3';
                  savePublicSherd();

                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/profile-wowondertimelineflutterapp-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Only me'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Only show this post to me.'.tr,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  postPrivacu = '0';
                  savePublicSherd();
                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/global-search-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Everyone'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Show this post to everyone.'.tr,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  postPrivacu = '1';
                  savePublicSherd();
                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/coin-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People I Follow'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Get.width * 0.70,
                        child: Text(
                          'Only show this post to people I follow.'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  postPrivacu = '2';
                  savePublicSherd();
                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/colorfilter-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People Follow Me'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Get.width * 0.70,
                        child: Text(
                          'Only show this post to people who follow me.'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget WidgetPhotoAnvideo(camera) {
    return Container(
      width: Get.width,
      height: Get.height * 0.40,
      decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(255, 31, 30, 30) : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            InkWell(
              onTap: () => camera.selectimges(),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                              'assets/svg/photos-selection-svgrepo-com.svg',
                              color: Colors.green)),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Images / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.vedioupolde(ImageSource.gallery),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/youtube.png',
                          color: colorTextBoardingDark1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Video / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.UplodeImage(ImageSource.camera),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/svg/camera-svgrepo-com.svg',
                        color: Colors.green,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Images / Camera'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.vedioupolde(ImageSource.camera),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/svg/camera-svgrepo-com.svg',
                        color: Colors.red,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Video / Camera'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class InkWellMreNave extends StatelessWidget {
  InkWellMreNave({
    required this.ontapPoll,
    required this.onTapVideoImage,
    required this.controller,
    required this.onTapFeling,
    required this.onTapColorPost,
    Key? key,
  }) : super(key: key);
  final ontapPoll;
  final onTapVideoImage;
  final CreatePostCont controller;
  final onTapFeling;
  final onTapColorPost;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
            isScrollControlled: true,
            Container(
              child: Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: sizedHeight(context) * 0.70,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 15,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.04),
                          InkWell(
                            onTap: onTapVideoImage,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/SDF.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'Images / Video'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        
                          SizedBox(height: Get.height * 0.02),
                          InkWell(
                            onTap: () {
                              controller.pickFile();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                        child: Icon(
                                  Icons.file_copy,
                                      size: 30,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'File'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                               InkWell(
                            onTap: () {
                                 controller.updateRecore(true);
              Get.back();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                        child: Icon(
                                      Icons.record_voice_over,
                                      size: 30,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                'Voice Record'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          InkWell(
                            onTap: onTapFeling,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/hg.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'feeling / activity'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.updatePostMap(true);
                                  Get.back();
                                },
                                child: Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/Iconly-Bold-Location.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              Text(
                                'place'.tr,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02),
                          InkWell(
                            onTap: () {
                              controller.GifUpode(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/GIF.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'GIF',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          InkWell(
                            onTap: ontapPoll,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/Polls.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'Polls'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                             SizedBox(height: Get.height * 0.02),
                          InkWell(
                            onTap: onTapColorPost,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.06,
                                  width: Get.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFEEEF0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          SvgImages.ColorPostSvg),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Text(
                                  'ColorPost'.tr,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                  Positioned(
                    left: Get.width * 0.30,
                    right: Get.width * 0.30,
                    top: Get.height * 0.01,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      width: Get.width * 0.20,
                      height: 3,
                    ),
                  )
                ],
              ),
            ));
      },
      child: WidgetPostImagesNav(
        images: 'more_horiz_black_24dp (4).png',
      ),
    );
  }
}

// class FellimgWidget extends StatelessWidget {
//   const FellimgWidget({
//     required this.finggg,
//     required this.controller,
//     super.key,
//   });
//   final controller;
//   final finggg;
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class FeelinngSmileWidget extends StatelessWidget {
  FeelinngSmileWidget({
    required this.smailetext,
    required this.text,
    super.key,
  });
  final String smailetext;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              smailetext,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
// class FellimgWidget extends StatelessWidget {
//   const FellimgWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: Row(
//                 children: [
//                   WidgetPostImagesNav(
//                     images: 'hg.png',
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class WidgetPostImagesNav extends StatelessWidget {
  WidgetPostImagesNav({
    required this.images,
    Key? key,
  }) : super(key: key);
  String images;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/$images',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

class WidgetPostImagesNavSvg extends StatelessWidget {
  WidgetPostImagesNavSvg({
    required this.colorr,
    required this.images,
    required this.colorbool,
    Key? key,
  }) : super(key: key);
  bool colorbool;
  String images;
  Color colorr;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      width: Get.width * 0.13,
      decoration: BoxDecoration(
          color: Color(0xffFEEEF0), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SvgPicture.asset(
            'assets/images/svg/$images',
            color: colorbool ? colorr : null,
          ),
        ),
      ),
    );
  }
}

// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // controller.UplodeImage(ImageSource.gallery);
//                           Get.bottomSheet(Container(
//                             height: Get.height * 0.2,
//                             width: Get.width * 0.2,
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     controller.UplodeImage(ImageSource.camera);
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(Icons.camera,
//                                               color: Colors.red[900]),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Camera',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     controller.UplodeImage(ImageSource.gallery);
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(
//                                             Icons.photo,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Gallery',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         child: CircleAvatar(
//                             child: Icon(Icons.photo, color: Colors.green)),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // controller.vedioupolde(ImageSource.gallery);
//                           Get.bottomSheet(Container(
//                             height: Get.height * 0.2,
//                             width: Get.width * 0.2,
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     controller.vedioupolde(ImageSource.camera);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(Icons.camera,
//                                               color: Colors.red[900]),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Camera',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     controller.vedioupolde(ImageSource.gallery);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(
//                                             Icons.photo,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Gallery',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         child: CircleAvatar(
//                           child: Icon(
//                             Icons.video_call,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       controller.records
//                           ? InkWell(
//                               onTap: () {
//                                 // controller.stoprecord();
//                               },
//                               child: CircleAvatar(
//                                 child: Icon(
//                                   Icons.stop,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 // controller.recored();
//                               },
//                               child: CircleAvatar(
//                                 child: Icon(
//                                   Icons.mic,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                             )
//                     ],
//                   )