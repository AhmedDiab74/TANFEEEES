import 'package:get/get.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'onBoridngTitle1'.tr,
    desc: 'onBoridngTitle2'.tr,
    image: "assets/images/image1.png",
  ),
  OnboardingContents(
    title: 'onBoridngTitle3'.tr,
    desc: 'onBoridngTitle4'.tr,
    image: "assets/images/image2.png",
  ),
  OnboardingContents(
    title: 'onBoridngTitle5'.tr,
    desc: 'onBoridngTitle6'.tr,
    image: "assets/images/image3.png",
  ),
];
