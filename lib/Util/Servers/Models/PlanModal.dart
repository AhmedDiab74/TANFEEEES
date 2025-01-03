import 'dart:ui';

import 'package:flutter/material.dart';

class PlanModal {
  String? id;
  String? title;
  String? color;
  String? description;
  String? subTitle;
  String? currency;
  String? price;
  String? period;
  bool? isAvailable;
  bool? isImportant;
  String? image;
  String? planPriceSubTitle;
  Color? containerColor;
  Color? iconColor;
  bool? isVisible;
  Color? planTitleColor;
  String? priceLinthroughTitle;

  List<PlanModal>? optionList;

  IconData? icon;

  PlanModal(
      {
        this.id,
        this.title,
        this.color,
      this.description,
      this.subTitle,
      this.currency,
      this.price,
      this.period,
      this.planPriceSubTitle,
      this.isAvailable,
      this.isImportant,
      this.image,
      this.containerColor,
      this.iconColor,
      this.isVisible,
      this.planTitleColor,
      this.optionList,
      this.icon,
      this.priceLinthroughTitle});
}
