import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/OnePostScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/AgoraCalls.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


void OneSignalNotf() async {
  await OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
  await OneSignal.shared.setAppId(onesignalKey);
  await OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
  final status = await OneSignal.shared.getDeviceState();
  await Permission.notification.request();
  SharedP.Save(
    'onsin',
    status == null ? '' : status.userId.toString(),
  );

  // print(status.userId.toString());
}

open() async {
  OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult openedResult) async {
    var ameen = await openedResult.notification;

    print(
        'ameenjawadhamed333 ${openedResult.notification.additionalData?['type']}');
    print('ameenjawadhamed33331   ${openedResult.notification.additionalData}');
    if (openedResult.notification.additionalData?['type'] == 'comment')
      Get.to(OnePostScreenGo(
          title: openedResult.notification.additionalData?['type'],
          post_id: openedResult.notification.additionalData?['post_id']));
    if (openedResult.notification.additionalData?['type'] == 'reaction')
      Get.to(OnePostScreenGo(
          title: openedResult.notification.additionalData?['type'],
          post_id: openedResult.notification.additionalData?['post_id']));

    final room_name = openedResult.notification.additionalData;
    final ro = room_name!['call_type'];
    // final title = openedResult.notification.title;
    print('ameenjawadhamed2223333111 ${ro}');
    if (ro.toString().isNotEmpty) {
      print('ameenjawadhamed2223333111 ${room_name['call_type']}');
      AgoraCallApi.call();
    } else if (ro == 'audio') {
      print('ameenjawadhamed2223333111 ${room_name['call_type']}');
      AgoraCallApi.call();
    }
    print('kaljsdkljsakldjsalkdjaskldj $ameen');
  });
}
