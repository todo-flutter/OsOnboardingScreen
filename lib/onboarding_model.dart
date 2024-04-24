import 'package:flutter/material.dart';

class OnboardingModel {
  final String imageUrl;
  final String title;
  final String subTitle;
  final Size? imageSize;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.imageSize,
    this.titleTextStyle = const TextStyle(),
    this.subTitleTextStyle = const TextStyle(),
  });
}
