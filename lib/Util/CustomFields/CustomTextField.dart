import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

CustomTextField(String fieldName, controller, icon, bool obscureText) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        obscureText: obscureText ? true : false,
        controller: controller,
        decoration: InputDecoration(
          labelText: fieldName.tr,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          border: OutlineInputBorder(
            // Border on all sides
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // Border when the TextField is not focused
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // Border when the TextField is focused
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
      ),
    ),
  );
}
