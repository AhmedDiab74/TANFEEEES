import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdataNorifactions.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
final getimydata = Get.put(GetMyUserDataCont());

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}


class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  @override
  void dispose() {
    getimydata.getUserdata();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.grey[100],
      appBar: AppBar(
        title: Text('Privacy Setting'.tr),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            for (var i = 0; i < getimydata.data.length; i++)
              Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(getimydata.data[i].avatar),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorTheme,
                              child: Icon(
                                Icons.privacy_tip,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width * 0.60,
                            child: Text(
                              getimydata.data[i].name,
                              maxLines: 1,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            'Privacy Setting'.tr,
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

            Column(
              children: [
                _privce(
                    title: 'Who can follow me ?',
                    vals: 'follow_privacy',
                    list: [
                      'Everyone',
                      'I Follow',
                    ],
                    lenth: int.parse(getimydata.data[0].e_liked) == 0
                        ? 0
                        : int.parse(getimydata.data[0].follow_privacy)),
                _privce(
                    title: 'Who can message me ?',
                    vals: 'message_privacy',
                    list: [
                      'Everyone',
                      'I Follow',
                      'No body',
                    ],
                    lenth: int.parse(getimydata.data[0].message_privacy)),
                _privce(
                    title: 'Who can see my friends ?',
                    vals: 'friend_privacy',
                    list: [
                      'Everyone',
                      'I Follow',
                      'Follow me',
                      'No body',
                    ],
                    lenth: int.parse(getimydata.data[0].friend_privacy) == 0
                        ? 0
                        : int.parse(getimydata.data[0].friend_privacy)),
                _privce(
                    title: 'Who can see my birthday?',
                    vals: 'birth_privacy',
                    list: [
                      'Everyone',
                      'I Follow',
                      'No body',
                    ],
                    lenth: int.parse(getimydata.data[0].birth_privacy) == 0
                        ? 0
                        : int.parse(getimydata.data[0].birth_privacy)),
                _privce(
                    title: 'Confirm request  follows you',
                    vals: 'confirm_followers',
                    list: [
                      'No',
                      'Yes',
                    ],
                    lenth: int.parse(getimydata.data[0].confirm_followers) == 0
                        ? 0
                        : int.parse(getimydata.data[0].confirm_followers)),
                _privce(
                    title: 'Show my activities ?',
                    vals: 'show_activities_privacy',
                    list: [
                      'No',
                      'Yes',
                    ],
                    lenth: int.parse(getimydata.data[0].show_activities_privacy) == 0
                        ? 0
                        : int.parse(getimydata.data[0].show_activities_privacy)),
                _privce(
                    title: 'Status ?',
                    vals: 'status',
                    list: [
                      'Offline',
                      'Online',
                    ],
                    lenth: int.parse(getimydata.data[0].status) == 0
                        ? 0
                        : int.parse(getimydata.data[0].status)),
                _privce(
                    title: 'Share my location with public?',
                    vals: 'share_my_location',
                    list: [
                      'No',
                      'Yes',
                    ],
                    lenth: int.parse(getimydata.data[0].share_my_location) == 0
                        ? 0
                        : int.parse(getimydata.data[0].share_my_location)),
              ],
            ),

            SizedBox(
              height: Get.height * 0.01,
            )
          ]),
        ),
      ),
    );
  }
}

class YesOrNoWidget extends StatefulWidget {
  YesOrNoWidget({
    required this.yesOrNo,
    required this.title,
    required this.text,
    super.key,
  });

  String text;
  String title;
  String yesOrNo;

  @override
  State<YesOrNoWidget> createState() => _YesOrNoWidgetState();
}

class _YesOrNoWidgetState extends State<YesOrNoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.70,
              child: Text(
                widget.text,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
            if (widget.title.isNotEmpty)
              Container(
                width: Get.width * 0.70,
                child: Text(
                  widget.title,
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 13),
                ),
              ),
          ],
        ),
        InkWell(
          onTap: () {
            QuickAlert.show(
              onConfirmBtnTap: () async {
                setState(() {
                  widget.yesOrNo = 'Yes';
                });
                Get.back();
              },
              onCancelBtnTap: () async {
                setState(() {
                  widget.yesOrNo = 'No';
                });
                Get.back();
              },
              context: context,
              type: QuickAlertType.confirm,
              animType: QuickAlertAnimType.slideInRight,
              confirmBtnText: 'Yes'.tr,
              cancelBtnText: 'No'.tr,
              title: '',
              confirmBtnColor: ColorTheme,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Text(
                    widget.yesOrNo,
                    style: GoogleFonts.cairo(fontWeight: FontWeight.w700),
                  ),
                  Icon(Icons.expand_more_outlined)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PrivacySetting extends StatefulWidget {
  PrivacySetting({required this.postPrivacu, required this.text, super.key});

  String text;
  String postPrivacu;

  @override
  State<PrivacySetting> createState() => _PrivacySettingState();
}

class _PrivacySettingState extends State<PrivacySetting> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Get.bottomSheet(Pivacy());
          },
          child: Row(
            children: [
              if (widget.postPrivacu == '1')
                Container(
                  width: Get.width * 0.25,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Color.fromARGB(44, 210, 202, 202)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgImages.PeopleIFollow,
                        color: Get.isDarkMode
                            ? Color.fromARGB(44, 210, 202, 202)
                            : Colors.white,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'People I Follow'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
              if (widget.postPrivacu == '0')
                Container(
                  width: Get.width * 0.28,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/global-search-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Everyone'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.expand_more_outlined),
                    ],
                  ),
                ),
              if (widget.postPrivacu == '2')
                Card(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/colorfilter-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : null,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'People Follow Me'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
              if (widget.postPrivacu == '3')
                Card(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/profile-wowondertimelineflutterapp-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : null,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Only me'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Pivacy() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: SingleChildScrollView(
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
                    widget.postPrivacu = '3';

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
                    widget.postPrivacu = '0';

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
                    widget.postPrivacu = '1';

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
                    widget.postPrivacu = '2';

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
      ),
    );
  }
}



class _privce extends StatefulWidget {
  _privce(
      {super.key,
        required this.list,
        required this.lenth,
        required this.vals,
        required this.title});
  List<String> list;
  int lenth;
  String vals;
  final String title;

  @override
  State<_privce> createState() => __privceState();
}

class __privceState extends State<_privce> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(24, 158, 158, 158)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    widget.title.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  )
                ],
              ),
            ),
            DropdownButton<String>(
              value: widget.list[widget.lenth].tr,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.deepPurple),
              underline: Container(
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                print(value);
                setState(() {
                  if (value == 'Everyone'.tr) {
                    setState(() {
                      widget.lenth = 0;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '0');
                  } else if (value == 'I Follow'.tr) {
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '1');
                    setState(() {
                      widget.lenth = 1;
                    });
                  } else if (widget.list.length == 4
                      ? value == 'Follow me'.tr
                      : value == 'No body'.tr) {
                    setState(() {
                      widget.lenth = 2;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '2');
                  } else if (widget.list.length == 4
                      ? value == 'No body'.tr
                      : false) {
                    setState(() {
                      widget.lenth = 3;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '3');
                  } else if (value == 'No'.tr) {
                    setState(() {
                      widget.lenth = 0;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '0');
                  } else if (value == 'Yes'.tr) {
                    setState(() {
                      widget.lenth = 1;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '1');
                  } else if (value == 'Online'.tr) {
                    setState(() {
                      widget.lenth = 1;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '0');
                  } else if (value == 'Offline'.tr) {
                    setState(() {
                      widget.lenth = 0;
                    });
                    ApiUpdataNorifactions.UpdateUserData(
                        vals: widget.vals, nump: '1');
                  }
                });
              },
              items: widget.list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: '$value'.tr,
                  child: Text('$value'.tr),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
