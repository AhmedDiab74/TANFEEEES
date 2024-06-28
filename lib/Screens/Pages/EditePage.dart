import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/ChannelAdmin.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/DeleteChannel.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/EditeAvatarCover.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/GeneralSetting.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/ProfileSeeting.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/Edite/SocialLinksPages.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class EditePage extends StatefulWidget {
  final String page_id;
  final updat;
  const EditePage({super.key, required this.page_id, required this.updat});

  @override
  State<EditePage> createState() => _EditePageState();
}

class _EditePageState extends State<EditePage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: 6, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  void dispose() {
    widget.updat();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            TextAppar(_selectedIndex),
            style:
                TextStyle(color: _selectedIndex == 5 ? Colors.redAccent : null),
          ),
          bottom: TabBar(controller: _controller, tabs: [
            Icon(
              Icons.settings,
              color: _selectedIndex == 0 ? ColorTheme : null,
            ),
            Icon(
              Icons.precision_manufacturing_outlined,
              color: _selectedIndex == 1 ? ColorTheme : null,
            ),
            Icon(
              Icons.social_distance,
              color: _selectedIndex == 2 ? ColorTheme : null,
            ),
            Icon(
              Icons.image,
              color: _selectedIndex == 3 ? ColorTheme : null,
            ),
            Icon(
              Icons.admin_panel_settings,
              color: _selectedIndex == 4 ? ColorTheme : null,
            ),
            Icon(
              Icons.delete,
              color: _selectedIndex == 5 ? Colors.redAccent : null,
            ),
          ]),
          elevation: 0,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            GeneralSetting(
              page_id: widget.page_id,
            ),
            ProfileSeeting(
              page_id: widget.page_id,
            ),
            SocialLinksPages(
              page_id: widget.page_id,
            ),
            EditeAvatarCover(page_id: widget.page_id),
            ChannelAdmin(),
            DeleteChannel(
              page_id: widget.page_id,
            ),
          ],
        ),
      ),
    );
  }

  String TextAppar(val) {
    if (val == 0) {
      return 'General Setting';
    } else if (val == 1) {
      return 'Profile Setting';
    } else if (val == 2) {
      return 'Social Links';
    } else if (val == 3) {
      return 'Avatar & Cover';
    } else if (val == 4) {
      return 'Channel Admin';
    } else if (val == 5) {
      return 'Delete Channel';
    }
    return '';
  }
}
