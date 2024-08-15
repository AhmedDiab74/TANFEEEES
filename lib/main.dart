import 'dart:io';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/SetValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/notifi_service.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/Widget/Unfous.dart';
import 'package:wowondertimelineflutterapp/Util/Cont/Cont.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wowondertimelineflutterapp/Util/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSetGen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/utils/Chatgpt.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/stores/AIChatStore.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/providers/chats_provider.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/providers/models_provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: ".env");

  await GetStorage.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? tok = prefs.getString('tok');

  open();
  performEncryption();
  configLoading();
  await ApiSetGen.fetchData();
  if(dashB){
 await ApiListDash.fetchData();
  };
 
  await SocketNew.socket;
  await newnewSok.socketss;
  await newnewSok.onncteSokets();
  final onsIn = await OnsingalNotfi.code();
  await ChatGPT.initChatGPT();
  if (onsIn) {
  } else {
    GetSetList.clear();
  }
  print(tok);
  runApp(MyApp(
    onsIn: onsIn,
    tok: tok,
  ));
}

//test

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.tok, required this.onsIn});
  final tok;
  final onsIn;

  @override
  Widget build(BuildContext context) {
    print(tok);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AIChatStore(),
        ),
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: GetMetre(tok: tok, onsIn: onsIn),
    );
  }
}

List accounts = [];

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

WidgetsBinding ensureInitialized() {
  return WidgetsBinding.instance;
}

void Hindall(child) {
  Unfous(child: child);
}

List GetSetList = [];

OfffLineNet() async {
  return await InternetConnectionChecker().hasConnection;
}

Future<void> configLoading() async {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.none
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..displayDuration = const Duration(milliseconds: 1000)
    ..userInteractions = false;
}
List dashSettings = [];

final siteConfig = dashSettings[0];


final mydata = Get.put<GetMyUserDataCont>(GetMyUserDataCont(), permanent: true);
