import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/utils/Chatgpt.dart';

class Config {
  static late Config _instance = Config._();
  factory Config() => _getInstance();
  static Config get instance => _getInstance();
  Config._() {}

  static Config _getInstance() {
    if (_instance == null) {
      _instance = Config._();
    }
    return _instance;
  }

  static bool get isDebug => !const bool.fromEnvironment('dart.vm.product');
  // static bool get isDebug => true;

  static bool isInfiniteNumberVersion =
      true; // Unlimited frequency. Development and use
  static String appName = nameApp + ' AI';
  static int watchAdApiCount = 3;
  static int appUserAdCount =
      20; // Do not actively display advertisements if the number of times exceeds (redemption page)
}
