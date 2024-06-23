import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:quickalert/quickalert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReportUser.dart';

class WidgetReportUser extends StatelessWidget {
  WidgetReportUser({
    required this.user_id,
    required this.name,
    required this.Report,
  });
  String user_id;
  String name;
  String Report;
  @override
  Widget build(BuildContext context) {
    TextEditingController commentsReport = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Report '.tr + Report),
        backgroundColor: ColorTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          child: Column(
            children: [
              Text(
                'Comments Report'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorTheme),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(170, 205, 202, 202),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    maxLength: 150,
                    maxLines: 4,
                    controller: commentsReport,
                    decoration: InputDecoration(
                      hintText: 'Report Message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: Get.width * 0.40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              'Cancel'.tr,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: colorTextBoardingDark1,
                        borderRadius: BorderRadius.circular(6)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // var report = await ApiReportUser.reportUser(
                          //     user_id, 'Report message== ${commentsReport.text}');
                          // print(report);

                          QuickAlert.show(
                            onConfirmBtnTap: () async {
                              var report = await ApiReportUser.reportUser(
                                  user_id, Report + commentsReport.text);
                              print(report);
                              Get.back();
                              Get.back();
                              if (report['code'] == 1)
                                Get.snackbar('Report', 'Successfully Reported');
                            },
                            context: context,
                            type: QuickAlertType.confirm,
                            text: 'Do you want to Report ${name}',
                            confirmBtnText: 'Yes'.tr,
                            cancelBtnText: 'No'.tr,
                            confirmBtnColor: Colors.red,
                          );
                        },
                        child: Container(
                          width: Get.width * 0.40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              'Report'.tr,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
