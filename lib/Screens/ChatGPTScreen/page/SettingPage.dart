import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/utils/Config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/utils/Chatgpt.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/stores/AIChatStore.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver {
  bool isCopying = false;
  final TextEditingController _keyTextEditingController =
      TextEditingController();
  final TextEditingController _urlTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // TODO: Switch from background to foreground, the interface is visible.
        break;
      case AppLifecycleState.paused:

        /// TODO: Switch from foreground to background, the interface is not visible.
        break;
      case AppLifecycleState.inactive:

        /// TODO: Handle this case.
        break;
      case AppLifecycleState.detached:

        /// TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: Colors.white,
              highlightColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    SizedBox(width: 24),
                    Image(
                      width: 18,
                      image: AssetImage(images.back_icon),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Setting",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(
        color: const Color(0xffffffff),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // renderItemWidget('images/share_icon.png', Colors.green, 26, 'Share App', () {
                  //   Share.share(
                  //     Platform.isAndroid
                  //         ? 'https://play.google.com/store/apps/details?id=com.wewehao.aichat'
                  //         : "https://apps.apple.com/app/id***",
                  //   );
                  // },),

                  /// Empty storage
                  if (Config.isDebug)
                    renderItemWidget(
                      images.debug_icon,
                      Colors.indigo,
                      22,
                      'Debug: Clear Storage',
                      () {
                        ChatGPT.storage.erase();
                        final store =
                            Provider.of<AIChatStore>(context, listen: false);
                        store.syncStorage();
                        SpUtil.clear();
                        EasyLoading.showToast('Clear Storage Success!');
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget renderItemWidget(
    String iconPath,
    Color iconBgColor,
    double iconSize,
    String title,
    GestureTapCallback back, {
    String rightIconSrc = 'assets/ChatGPT/arrow_icon.png',
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: back,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: Image(
                          image: AssetImage(iconPath),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                if (rightIconSrc != '')
                  Row(
                    children: [
                      Image(
                        image: AssetImage(rightIconSrc),
                        width: 18,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
