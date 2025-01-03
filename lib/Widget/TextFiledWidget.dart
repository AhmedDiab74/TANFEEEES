import 'package:flutter/material.dart';

class TextFiledWidget extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final bool obscureText;
  final Key? keey;
  final TextEditingController controller;
  final Widget suffixIcon;
  final Function validato;
  TextFiledWidget(
      {Key? key,
      required this.suffixIcon,
      required this.validato,
      required this.hintText,
      this.keey,
      required this.icon,
      required this.obscureText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        key: keey,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: suffixIcon,
            hintText: hintText,
            suffixIconColor: Colors.black),
        validator: ((value) => validato(value)),
      ),
    );
  }
}
