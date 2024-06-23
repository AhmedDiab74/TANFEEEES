import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogHome.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetWebViewRequst.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogCategoryScreen.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    BlogHome(),
    CategoriesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorTheme,
        onTap: _onItemTapped,
      ),
    );
  }
}
