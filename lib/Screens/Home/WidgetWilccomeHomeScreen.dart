import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class WidgetWilcomeHomeScreen extends StatelessWidget {
  const WidgetWilcomeHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<GetMyUserDataCont>(
              init: GetMyUserDataCont(),
              builder: ((cont) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Container(
                      // width: Get.width * 0.96,
                      // height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < cont.data.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  maxRadius: 25,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Image(
                                        image: AssetImage(
                                            getGreetingImages(getGreeting()))),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getGreeting() + ', ' + cont.data[i].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Container(
                                      width: Get.width * 0.78,
                                      child: Text(
                                        getAdditionalMessage(getGreeting()),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
