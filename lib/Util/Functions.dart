import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wowondertimelineflutterapp/Images.dart';


String ConverttoTimeDay(int timestamp) {
  return convertTimestampToAgo(timestamp).contains('day')
      ? convertAgoToDateTime(convertTimestampToAgo(timestamp), timestamp)
      : convertTimestampToAgo(timestamp);
}

String convertTimestampToAgo(int timestamp) {
  if (timestamp == 0) {
    return 'Delivered';
  }

  var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var now = DateTime.now();
  var difference = now.difference(dateTime);

  if (difference.inDays >= 7) {
    return DateFormat('MMM dd,yyyy').format(dateTime) +
        ' ' +
        'at' +
        ' ' +
        DateFormat('hh:mma').format(dateTime);
  } else if (difference.inDays > 1) {
    return DateFormat('E').format(dateTime);
  } else if (difference.inDays == 1) {
    return 'Yesterday at ' + DateFormat('hh:mma').format(dateTime);
    ;
  } else if (difference.inHours >= 1) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Just Now';
  }
}

String convertAgoToDateTime(String formattedTime, int timestamp) {
  return formattedTime;
}

String formatBytes(int bytes) {
  if (bytes < 0) {
    return "Invalid";
  } else if (bytes < 1000000) {
    // Convert to KB
    double kb = bytes / 1000;
    return "${kb.toInt()}KB ";
  } else if (bytes < 1000000000) {
    // Convert to MB
    double mb = bytes / 1000000;
    return "${mb.toInt()}MB ";
  } else if (bytes < 1000000000000) {
    // Convert to GB
    double gb = bytes / 1000000000;
    return "${gb.toInt()}GB ";
  } else {
    // If value is in TB, return "Unlimited"
    return "Unlimited ".tr;
  }
}

String convertDate(String dateString) {
  DateTime now = DateTime.now();
  DateTime parsedDate = DateFormat('MM.dd.yy').parse(dateString);
  Duration difference = now.difference(parsedDate);

  if (difference.inDays < 7) {
    return DateFormat('EEEE').format(parsedDate);
  } else {
    return DateFormat('MM.dd.yy').format(parsedDate);
  }
}

String convertTime(String timeString) {
  DateTime now = DateTime.now();
  DateTime parsedTime = DateFormat('HH:mm').parse(timeString);
  Duration difference = now.difference(DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute));

  if (difference.inMinutes > 1) {
    // return 'Just now';
    String formattedTime = DateFormat('hh:mm a').format(parsedTime);
    return formattedTime;
  } else {
    String formattedTime = DateFormat('hh:mm a').format(parsedTime);
    return formattedTime;
  }
}

enum Type { Date, Time, Neither }

Type checkDateTimeType(String input) {
  final dateRegex = r'^\d{2}\.\d{2}\.\d{2}$';
  final timeRegex = r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$';

  if (RegExp(dateRegex).hasMatch(input)) {
    return Type.Date;
  } else if (RegExp(timeRegex).hasMatch(input)) {
    return Type.Time;
  } else {
    return Type.Neither;
  }
}

String TimeStamp(String Value) {
  return checkDateTimeType(Value).toString() == 'Type.Time'
      ? convertTime(Value)
      : convertDate(Value);
}

String TextTimeStamp(String Value) {
  return checkDateTimeType(Value).toString() == 'Type.Time'
      ? convertTime(Value)
      : convertDate(Value);
}

String ConverttoTimeDayOnline(int timestamp) {
  return convertTimestampToOnlineAgo(timestamp).contains('day')
      ? convertAgoToDateTime(convertTimestampToOnlineAgo(timestamp), timestamp)
      : convertTimestampToOnlineAgo(timestamp);
}

String convertTimestampToOnlineAgo(int timestamp) {
  if (timestamp == 0) {
    return 'Delivered'.tr;
  }

  var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var now = DateTime.now();
  var difference = now.difference(dateTime);

  if (difference.inDays == 1) {
    return "1 day";
  } else if (difference.inDays > 1 && difference.inDays < 7) {
    return "${difference.inDays} days";
  } else if (difference.inDays >= 7 && difference.inDays < 30) {
    return "${(difference.inDays / 7).floor()} week";
  } else if (difference.inDays >= 30) {
    return "${(difference.inDays / 30).floor()} mon";
  } else if (difference.inHours > 0) {
    return "${difference.inHours} hrs";
  } else if (difference.inMinutes > 0) {
    return "${difference.inMinutes} min";
  } else {
    return "Just Now".tr;
  }
}

// Function to get the appropriate greeting message
String getGreeting() {
  var now = DateTime.now();
  var currentTime = now.hour;

  if (currentTime >= 5 && currentTime < 12) {
    return 'Good Morning'.tr;
  } else if (currentTime >= 12 && currentTime < 17) {
    return 'Good Afternoon'.tr;
  } else {
    return 'Good Evening'.tr;
  }
}

// Function to get the appropriate greeting message
String getAdditionalMessage(String greeting) {
  if (greeting == 'Good Morning'.tr) {
    return 'Every new day is a chance to change your life.'.tr;
  } else if (greeting == 'Good Afternoon'.tr) {
    return 'May this afternoon be light, blessed, enlightened, productive and happy.'
        .tr;
  } else if (greeting == 'Good Evening'.tr) {
    return 'Evenings are life\'s way of saying that you are closer to your dreams.'
        .tr;
  } else {
    return '';
  }
}

// Function to get the appropriate greeting message
String getGreetingImages(String greeting) {
  if (greeting == 'Good Morning'.tr) {
    return SvgImages.GoodMorning;
  } else if (greeting == 'Good Afternoon'.tr) {
    return SvgImages.GoodAfternoon;
  } else if (greeting == 'Good Evening'.tr) {
    return SvgImages.GoodEvening;
  } else {
    return '';
  }
}


sizedwidth(context) {
  return MediaQuery.of(context).size.width;
}

sizedHeight(context) {
  return MediaQuery.of(context).size.height;
}

extension UriString on String {
  Uri get toUri => Uri.parse(this);
}



   bool isAudio(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".mp3") ||
        ext.endsWith(".wav") ||
        ext.endsWith(".wma") ||
        ext.endsWith(".amr") ||
             ext.endsWith(".m4a") ||
        ext.endsWith(".ogg");
  }