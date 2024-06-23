import 'dart:convert';
import 'dart:collection';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class WidgetWebViewRequst extends StatefulWidget {
  WidgetWebViewRequst({
    super.key,
    required this.urls,
    required this.token,
    required this.appBar,
  });
  String urls;
  String token;
  bool appBar;

  @override
  State<WidgetWebViewRequst> createState() => _WidgetWebViewRequstState();
}

class _WidgetWebViewRequstState extends State<WidgetWebViewRequst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.appBar
          ? null
          : AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Get.isDarkMode ? Colors.black : ColorTheme,
            ),
      body: InAppWebView(
        androidOnPermissionRequest:
            (webViewController, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: true,
                javaScriptEnabled: true),
            ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
                allowsAirPlayForMediaPlayback: true)),
        initialUserScripts: UnmodifiableListView([
          UserScript(source: """
                window.addEventListener('DOMContentLoaded', function(event) {
                  var header = document.querySelector('.elementor-location-header'); // use here the correct CSS selector for your use case
                  if (header != null) {
                    header.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
                  }
                  var footer = document.querySelector('.elementor-location-footer'); // use here the correct CSS selector for your use case
                  if (footer != null) {
                    footer.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use footer.style.display = 'none';
                  }
                });
                """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
        ]),
        initialUrlRequest: URLRequest(
            url: Uri.parse(accounts[0]['lives'] + widget.token),
            method: 'POST',
            body: Uint8List.fromList(utf8.encode(
                "${accounts[0]['sm1']}=${accounts[0]['sm2']}&urls=${accounts[0]['sm0']}/${widget.urls}")),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
        onWebViewCreated: (controller) {},
        onLoadStart: (controller, url) {

          if (url.toString() != "${accounts[0]['sm0']}/${widget.urls}") {


          }
        },
      ),
    );
  }
}
