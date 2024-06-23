import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayStack.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAddWallet.dart';
import 'package:wowondertimelineflutterapp/Screens/Payment/WidgetPayStack.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomSnackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';

class SendMonyeScreen extends StatefulWidget {
  const SendMonyeScreen({super.key});

  @override
  State<SendMonyeScreen> createState() => _SendMonyeScreenState();
}

class _SendMonyeScreenState extends State<SendMonyeScreen> {
  @override
  void initState() {
    var cont = Get.put(GetMyUserDataCont());

    super.initState();
  }

  var conts = Get.put(GetMyUserDataCont());
  TextEditingController _amount = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Send Monye'),
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        ),
        body: GetX<GetMyUserDataCont>(
          init: GetMyUserDataCont(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 31,
                                backgroundColor: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller
                                          .data[controller.data.length - 1]
                                          .avatar),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                        .data[controller.data.length - 1].name,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    '@${controller.data[controller.data.length - 1].username}',
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    Default_Currency +
                                        controller
                                            .data[controller.data.length - 1]
                                            .wallet,
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Wallet',
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Pays.png',
                      height: Get.height * 0.3,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Center(
                      child: Text(
                    'Sending money to a friend',
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Default_Currency,
                        style: SafeGoogleFont(Fonts.font1,
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Container(
                        width: Get.width * 0.1,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amount,
                          decoration: InputDecoration(
                              hintText: '00.0',
                              hintStyle: SafeGoogleFont(Fonts.font1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(Center(
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _SendMony(
                              p: _amount.text,
                              up: conts.getUserdata,
                            ),
                          ),
                        ),
                      ));
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Text(
                            'Send Monye',
                            style: SafeGoogleFont(Fonts.font2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
          },
        ));
  }
}

class _SendMony extends StatefulWidget {
  _SendMony({
    required this.p,
    required this.up,
    super.key,
  });
  String p;
  final up;

  @override
  State<_SendMony> createState() => _SendMonyState();
}

String avat = '';
String user_id = '';
String name = '';
String cover = '';
String email = '';
bool nodata = false;
bool datais = true;

class _SendMonyState extends State<_SendMony> {
  TextEditingController _username = TextEditingController();
  Future<void> SearchMyFrind() async {
    setState(() {
      nodata = false;
      datais = true;
    });
    var username = await GetUserDataUserName.getUserData(_username.text);
    if (username != null) {
      setState(() {
        datais = false;
        email = username['email'];
        avat = username['avatar'];
        user_id = username['user_id'];
        name = username['name'];
        cover = username['cover'];
      });
    } else {
      setState(() {
        datais = true;
        nodata = true;
      });
    }
  }

  @override
  void initState() {
    avat = '';
    user_id = '';
    name = '';
    cover = '';
    email = '';
    nodata = false;
    datais = true;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 225, 224, 224)),
                      width: Get.width * 0.70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: _username,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please enter username'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SearchMyFrind();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Search'.tr,
                            style: SafeGoogleFont(Fonts.font1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              datais
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(ProfileUserScreen(
                                avat: avat,
                                user_id: user_id,
                                cover: cover,
                                name: name));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(avat),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    email,
                                    style: SafeGoogleFont(Fonts.font3,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // ApiAddWalletSendFrind.add(u: user_id, p: widget.p);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text:
                                  'Are you sure you want to send ${widget.p} to ${name}',
                              confirmBtnText: 'Yes'.tr,
                              onConfirmBtnTap: () async {
                                var aa = await ApiAddWalletSendFrind.add(
                                    u: user_id, p: widget.p);
                                if (aa.toString().isNotEmpty) {
                                  showCustomSnackbar(
                                    snackbar: 'error',
                                    context: context,
                                    message: aa['errors']['error_text'],
                                  );
                                } else {
                                  widget.up();
                                  Get.back();
                                  Get.back();

                                  showCustomSnackbar(
                                    snackbar: 'success',
                                    context: context,
                                    message: 'The money was sent to ${name}',
                                  );
                                }
                              },
                              cancelBtnText: 'No'.tr,
                              confirmBtnColor: Colors.green,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorTheme,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Send',
                                style: SafeGoogleFont(Fonts.font1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ));
  }
}
