import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayPro.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class ScreenPackages extends StatefulWidget {
  const ScreenPackages({super.key});

  @override
  State<ScreenPackages> createState() => _ScreenPackagesState();
}

class _ScreenPackagesState extends State<ScreenPackages> {
  final packages = GetSetList[0]['pro_packages'];
  @override
  void initState() {
    var cont = Get.put(GetMyUserDataCont());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        title: Text('Pro Packages'.tr),
      ),
      body: Container(
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.07,
              ),
              for (var i = 1; i <= packages.length; i++)
                _Packages(
                  color: packages['${i}']['color'],
                  title: packages['${i}']['type'],
                  desc: packages['${i}']['description'],
                  price: Default_Currency +
                      '${packages['${i}']['price']} ${packages['${i}']['time']}',
                  trufalse: false,
                  packages: packages['${i}'],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Packages extends StatefulWidget {
  _Packages({
    super.key,
    required this.title,
    required this.price,
    required this.color,
    required this.trufalse,
    required this.packages,
    required this.desc,
  });
  final String title;
  final String price;
  final String color;
  final String desc;
  final packages;
  bool trufalse;

  @override
  State<_Packages> createState() => _PackagesState();
}

class _PackagesState extends State<_Packages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.90,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Container(
                width: Get.width * 0.90,
                height: Get.height * 0.15,
                decoration: ShapeDecoration(
                  color: Color(int.parse(widget.color.replaceAll('#', '0xff'))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              CircleAvatar(
                                maxRadius: 30,
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    widget.desc,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            child: Text(
                              widget.price,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                width: Get.width * 0.90,
                decoration: ShapeDecoration(
                  color: Color(int.parse(widget.color.replaceAll('#', '0xff'))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 30,
                              ),
                              Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Text(
                              widget.price,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        _ChekBox(
                          title: 'Featured member',
                          value: widget.packages['featured_member'] == '0'
                              ? false
                              : true,
                        ),
                        _ChekBox(
                          title: 'See profile visitors',
                          value: widget.packages['profile_visitors'] == '0'
                              ? false
                              : true,
                        ),
                        _ChekBox(
                          title: 'Show / Hide last seen',
                          value: widget.packages['last_seen'] == '0'
                              ? false
                              : true,
                        ),
                        _ChekBox(
                          title: 'Verified badge',
                          value: widget.packages['verified_badge'] == '0'
                              ? false
                              : true,
                        ),
                        _promotion(
                          title: 'Posts promotion',
                          promotion: widget.packages['posts_promotion'] == '0'
                              ? 'X'
                              : '${widget.packages['posts_promotion']} Posts',
                        ),
                        _promotion(
                          title: 'Pages promotion',
                          promotion: widget.packages['pages_promotion'] == '0'
                              ? 'X'
                              : '${widget.packages['pages_promotion']} Pages',
                        ),
                        _promotion(
                          title: 'Discount',
                          promotion: widget.packages['discount'] == '0'
                              ? 'X'
                              : '${widget.packages['discount']} Pages',
                        ),
                        _promotion(
                            title: 'Max upload size',
                            promotion:
                                '${int.parse(widget.packages['max_upload']) / 1000000} MB'),
                        _promotion(
                            title: 'Packages',
                            promotion: widget.packages['description']),
                      ],
                    ),
                    GetX<GetMyUserDataCont>(
                      init: GetMyUserDataCont(),
                      builder: (controller) {
                        return InkWell(
                          onTap: () async {
                            controller.isloding.value = true;
                            if (controller.data[controller.data.length - 1]
                                    .pro_type ==
                                widget.packages['id']) {
                              controller.isloding.value = false;
                            } else {
                              var pay = await ApiPayPro.pay(
                                  p: widget.packages[accounts[0]['is']]);
                              if (pay['api_status'] == '400') {
                                Get.snackbar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  'Error',
                                  'You do not have enough balance to purchase the package ${widget.packages['type']}',
                                  colorText: Colors.black,
                                );
                              } else if (pay['api_status'] == 200) {
                                print('done');
                                print(pay);
                                Get.snackbar('Done',
                                    ' upgraded to pro ${widget.packages['type']}');
                              }
                              controller.updi();
                              controller.isloding.value = false;
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200
                                                .withOpacity(0.5),
                                            blurRadius: 1,
                                            spreadRadius: 5)
                                      ]),
                                  child: controller.isloding.value
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            controller
                                                        .data[controller
                                                                .data.length -
                                                            1]
                                                        .pro_type ==
                                                    widget.packages['id']
                                                ? 'You are subscribed'
                                                : widget.packages[accounts[0]
                                                    ['is']],
                                            style: SafeGoogleFont(Fonts.font2,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChekBox extends StatelessWidget {
  const _ChekBox({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: SafeGoogleFont(Fonts.font1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Checkbox(autofocus: false, value: value, onChanged: (val) {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _promotion extends StatelessWidget {
  const _promotion({
    super.key,
    required this.title,
    required this.promotion,
  });

  final String title;
  final promotion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: SafeGoogleFont(Fonts.font1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  promotion.toString(),
                  style: SafeGoogleFont(Fonts.font1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
