import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCreatePage.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class CreatePageScreen extends StatefulWidget {
  const CreatePageScreen({super.key});

  @override
  State<CreatePageScreen> createState() => _CreatePageScreenState();
}

class _CreatePageScreenState extends State<CreatePageScreen> {
  var ameen22;
  @override
  @override
  void initState() {
    super.initState();
  }

  String SelectPrivacy = 'Select Privacy'.tr;
  String SelectCategory = 'Select Category'.tr;
  String catid = '0';
  String PrivacyId = '1';
  String namepagevalue = '';
  String PageUrlValeue = '';
  String aboutValue = '';
  String categoryValue = '';
  void OnTapSelectCategory(SelectCategory2, catid0) {
    setState(() {
      SelectCategory = SelectCategory2;
      catid = catid0;
    });
    Get.back();
  }

  TextEditingController page_name = TextEditingController();
  TextEditingController page_title = TextEditingController();
  TextEditingController about = TextEditingController();

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Create Page'.tr,
      centerTitle: true,
      elevation: 0,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Get.isDarkMode
                    ? Color.fromARGB(54, 244, 246, 248)
                    : Color(0xffF4F6F8),
              ),
              child: Form(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: page_title,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Page Name'.tr),
                ),
              )),
            ),
            if (namepagevalue.isNotEmpty) Text(namepagevalue),
            SizedBox(height: Get.height * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Get.isDarkMode
                    ? Color.fromARGB(54, 244, 246, 248)
                    : Color(0xffF4F6F8),
              ),
              child: Form(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '${accounts[0]['sm0']}/',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      width: Get.width * 0.4,
                      child: TextField(
                        controller: page_name,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Page URL'),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            if (PageUrlValeue.isNotEmpty) Text(PageUrlValeue),
            SizedBox(height: Get.height * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Get.isDarkMode
                    ? Color.fromARGB(54, 244, 246, 248)
                    : Color(0xffF4F6F8),
              ),
              child: Form(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: about,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Describe your Page'.tr),
                  maxLength: 100,
                  maxLines: 5,
                ),
              )),
            ),
            if (aboutValue.isNotEmpty) Text(aboutValue),
            SizedBox(height: Get.height * 0.01),
            Container(
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Get.isDarkMode
                    ? Color.fromARGB(54, 244, 246, 248)
                    : Color(0xffF4F6F8),
              ),
              child: Form(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              // height: Get.height * 0.40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (var i = 1;
                                        i <= Page_Categories.length;
                                        i++)
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            OnTapSelectCategory(
                                                "${Page_Categories['$i']!.toString()}",
                                                "$i");
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Text(
                                                    "${Page_Categories['$i']!.toString()}"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              )));

                          // showAdaptiveActionSheet(
                          //   context: context,

                          //   actions: <BottomSheetAction>[
                          //     for (var i=1; i <=  Page_Categories.length; i++)

                          //       BottomSheetAction(
                          //         title: Text("${Page_Categories['$i']!.toString()}"),
                          //         onPressed: (BuildContext context) {
                          //           OnTapSelectCategory("${Page_Categories['$i']!.toString()}", "$i");
                          //         },
                          //       ),

                          //   ],
                          //   cancelAction: CancelAction(
                          //       title: Text('Cancel'
                          //           .tr)), // onPressed parameter is optional by default will dismiss the ActionSheet
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              SelectCategory,
                              style: TextStyle(
                                  color: SelectCategory == 'Select Category'.tr
                                      ? Colors.grey
                                      : null),
                            ),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ))),
            ),
            if (categoryValue.isNotEmpty) Text('$categoryValue'.tr),
            SizedBox(height: Get.height * 0.01),
            SizedBox(height: Get.height * 0.03),
            InkWell(
              onTap: () async {
                var creapi = await ApiCreatePage.create(
                  page_name.text,
                  page_title.text,
                  catid,
                  about.text,
                );

                setState(() {
                  if (creapi['errors'] != null) {
                    if (creapi['errors']['error_text'] ==
                        'page_title (POST) is missing') {
                      namepagevalue = 'Type the name of the page';
                    } else {
                      namepagevalue = '';
                    }
                    ;
                    if (creapi['errors']['error_text'] ==
                        'Page name must be between 5 / 32') {
                      PageUrlValeue = creapi['errors']['error_text'];
                    } else {
                      PageUrlValeue = '';
                    }
                    if (creapi['errors']['error_text'] ==
                        'error_text: about (POST) is missing') {
                      aboutValue = 'Please write a description';
                    } else {
                      aboutValue = '';
                    }
                    ;

                    if (creapi['errors']['error_text'] ==
                        'category (POST) is missing') {
                      categoryValue = 'Please select a category';
                    } else {
                      categoryValue = '';
                    }
                    ;
                    if (creapi['errors']['error_text'] ==
                        'Page name is already exists.') {
                      PageUrlValeue = creapi['errors']['error_text'];
                    } else {
                      PageUrlValeue = '';
                    }
                  } else {
                    // Get.back(closeOverlays: true);
                    // Get.back(closeOverlays: true);
                  }
                });
                if (creapi['page_data'] != null) {
                  Get.back(closeOverlays: true);

                  Get.to(HomePageScreen(
                    page_id: creapi['page_data']['page_id'].toString(),
                  ));
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorTheme,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    width: Get.width,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Create'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),
              ),
            )
          ]),
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
