import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayPro.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PlanModal.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class ProPlanPackages extends StatefulWidget {
  @override
  ProPlanPackagesState createState() => ProPlanPackagesState();
}

class ProPlanPackagesState extends State<ProPlanPackages> {
  List<PlanModal> subscriptionList = [];
  PageController controller = PageController(viewportFraction: 0.85);
  int _index = 0;
  final packages = GetSetList[0]['pro_packages'];
  @override
  void initState() {
    var cont = Get.put(GetMyUserDataCont());

    super.initState();

    init();
  }

  Future<void> init() async {
    for (var i = 1; i <= packages.length; i++)
      subscriptionList.add(
        PlanModal(
          id: packages['${i}']['id'],
          title: packages['${i}']['name'],
          description: packages['${i}']['description'],
          color: packages['${i}']['color'],
          currency: Default_Currency,
          price: packages['${i}']['price'],
          period: packages['${i}']['time'],
          icon: Icons.person,
          optionList: [
            PlanModal(
              title: 'Featured member'.tr,
              isAvailable: true,
              isImportant:
                  packages['${i}']['featured_member'] == '0' ? false : true,
            ),
            PlanModal(
              title: 'See Profile Visitors'.tr,
              isAvailable: true,
              isImportant:
                  packages['${i}']['profile_visitors'] == '0' ? false : true,
            ),
            PlanModal(
                title: 'Show / Hide last Seen'.tr,
                isAvailable: true,
                isImportant:
                    packages['${i}']['last_seen'] == '0' ? false : true),
            PlanModal(
              title: 'Verified Badge'.tr,
              isAvailable: true,
              isImportant:
                  packages['${i}']['verified_badge'] == '0' ? false : true,
            ),
            PlanModal(
                title: packages['${i}']['posts_promotion'] == '0'
                    ? 'Posts promotion'.tr
                    : '${packages['${i}']['posts_promotion']} ' +
                        'Posts promotion'.tr,
                isAvailable:
                    packages['${i}']['posts_promotion'] == '0' ? false : true,
                isImportant: false),
            PlanModal(
                title: packages['${i}']['pages_promotion'] == '0'
                    ? '0 ' + 'Pages promotion'.tr
                    : '${packages['${i}']['pages_promotion']} ' +
                        'Pages promotion'.tr,
                isAvailable:
                    packages['${i}']['pages_promotion'] == '0' ? false : true,
                isImportant: false),
            PlanModal(
                title: packages['${i}']['discount'] == '0'
                    ? '0% ' + 'Discount'.tr
                    : '${packages['${i}']['discount']}% ' + 'Discount'.tr,
                isAvailable: packages['${i}']['discount'] == '0' ? false : true,
                isImportant: false),
            PlanModal(
                title: formatBytes(int.parse(packages['${i}']['max_upload'])) +
                    'Max Upload Size'.tr,
                isAvailable: true,
                isImportant: false),
          ],
        ),
      );

    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: appBarWidget('Go Pro'.tr,
          center: false,
          color: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
          textColor: Get.isDarkMode ? Colors.white : Colors.white),
      body: PageView.builder(
          itemCount: subscriptionList.length,
          controller: controller,
          onPageChanged: (v) {
            _index = v;
            setState(() {});
          },
          itemBuilder: (context, index) {
            PlanModal data = subscriptionList[index];
            return AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: _index == index ? 16 : 50, horizontal: 8),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(defaultRadius),
                boxShadow: defaultBoxShadow(
                  shadowColor: Get.isDarkMode ? null : context.dividerColor,
                ),
                backgroundColor:
                    Get.isDarkMode ? ColorDarkComponents : context.cardColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              duration: IntExtensions(1000).milliseconds,
              curve: Curves.linearToEaseOut,
              child: Column(
                children: [
                  Text(
                    data.title.validate(),
                    style: boldTextStyle(
                        size: 28,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ).center(),
                  Text(data.description.validate(),
                          style: primaryTextStyle(
                              size: 14,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black))
                      .center(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data.currency.validate(),
                          style: primaryTextStyle(
                              color: Color(int.parse(data.color
                                  .toString()
                                  .replaceAll('#', '0xff'))),
                              size: 18)),
                      Text(data.price.validate(),
                          style: primaryTextStyle(
                              color: Color(int.parse(data.color
                                  .toString()
                                  .replaceAll('#', '0xff'))),
                              size: 36)),
                      8.width,
                      Text('/' + data.period.validate(),
                          style: secondaryTextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          )),
                    ],
                  ).center(),
                  Divider(),
                  ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.optionList!.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Row(
                          children: [
                            data.optionList![index].isImportant!
                                ? SvgPicture.asset(
                                    SvgImages.wowondertimelineflutterapp,
                                    width: 15,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  )
                                : SizedBox(),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Text(
                              data.optionList![index].title.validate(),
                              style: primaryTextStyle(
                                  size: 14,
                                  weight: data.optionList![index].isImportant!
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  decoration:
                                      !data.optionList![index].isAvailable!
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  color: Get.isDarkMode
                                      ? !data.optionList![index].isAvailable!
                                          ? Colors.white
                                          : white
                                      : !data.optionList![index].isAvailable!
                                          ? Colors.grey.shade500
                                          : textPrimaryColorGlobal),
                            ),
                          ],
                        ),
                      );
                    },
                  ).expand(),
                  16.height,
                  // for (var i = 1; i <= packages.length; i++)
                  GetX<GetMyUserDataCont>(
                    init: GetMyUserDataCont(),
                    builder: (controller) {
                      return AppButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: Color(int.parse(
                            data.color.toString().replaceAll('#', '0xff'))),
                        child: TextIcon(
                          text: controller.data[controller.data.length - 1]
                                      .pro_type ==
                                  data.id
                              ? 'Current Package'.tr
                              : 'Upgrade Now'.tr,
                          textStyle: TextStyle(color: white),
                        ),
                        onTap: () async {
                          controller.isloding.value = true;
                          if (controller
                                  .data[controller.data.length - 1].pro_type ==
                              data.id) {
                            controller.isloding.value = false;
                          } else {
                            var pay =
                                await ApiPayPro.pay(p: data.id.toString());
                            if (pay['api_status'] == '400') {
                              Get.snackbar(
                                snackPosition: SnackPosition.TOP,
                                'Error',
                                'You do not have enough balance to purchase the package ${data.title}',
                                colorText: Colors.black,
                              );
                            } else if (pay['api_status'] == 200) {
                              Get.snackbar(
                                  snackPosition: SnackPosition.TOP,
                                  'Done',
                                  ' upgraded to pro ${data.title}');
                            }
                            controller.updi();
                            controller.isloding.value = false;
                          }
                        },
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: radius(defaultRadius)),
                      ).center();
                      // child: Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius:
                      //                 BorderRadius.circular(8),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   color: Colors.grey.shade200
                      //                       .withOpacity(0.5),
                      //                   blurRadius: 1,
                      //                   spreadRadius: 5)
                      //             ]),
                      //         child: controller.isloding.value
                      //             ? Center(
                      //                 child: Padding(
                      //                   padding:
                      //                       const EdgeInsets.all(8.0),
                      //                   child:
                      //                       CircularProgressIndicator(),
                      //                 ),
                      //               )
                      //             : Padding(
                      //                 padding:
                      //                     const EdgeInsets.all(8.0),
                      //                 child: Text(
                      //                   controller
                      //                               .data[controller
                      //                                       .data
                      //                                       .length -
                      //                                   1]
                      //                               .pro_type ==
                      //                           data.id
                      //                       ? 'You are subscribed'
                      //                       : 'Upgrade Now',
                      //                   style: SafeGoogleFont(
                      //                       Fonts.font2,
                      //                       fontWeight: FontWeight.bold,
                      //                       color: Colors.black,
                      //                       fontSize: 16),
                      //                 ),
                      //               ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
