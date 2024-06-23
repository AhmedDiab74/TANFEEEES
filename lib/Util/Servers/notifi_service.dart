import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:encrypt/encrypt.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiVoteUp.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:ffi';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:wowondertimelineflutterapp/Screens/Notification/NotificationScreen.dart';
// import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

// class NotifcationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   Future<void> initNotfiaction() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('flutter_logo');

//     var initializationSerringsIos = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? paylod) async {});
//     var initalizationSettigs = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSerringsIos);
//     await notificationsPlugin.initialize(initalizationSettigs,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notFicationresponse) async {});
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max),
//         iOS: DarwinNotificationDetails());
//   }

//   Future showNotfication(
//       {int id = 0, String? title, String? body, String? playLoad}) async {
//     return notificationsPlugin.show(
//         id, title, body, await notificationDetails());
//   }
// }


class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('background');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

class newnewSok {
  static Socket socketss = io(
      accounts[0]['hosts'],
      OptionBuilder()
          .setPath('/socket.io')
          .setTransports(['websocket']).build());

  static onncteSokets() async {
    socketss.connect();
  }
}
