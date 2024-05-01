import 'package:flutter/material.dart';

/// A model representing the content and styling for an onboarding page.
///
/// The `OnboardingModel` class is used to define the content and appearance of
/// an individual onboarding page. It includes attributes for an image, title,
/// subtitle, and optional text styles. This class is typically used to supply
/// data to onboarding screens or similar multi-step UI flows.
///
/// **Parameters**:
/// - [imageUrl]: The URL or asset path for the page's image. This is typically used
///   to display the main image for the onboarding page.
/// - [title]: The main title or heading for the onboarding page.
/// - [subTitle]: The subtitle or description text for the onboarding page.
/// - [imageSize]: The size of the image on the page. Default is `Size(250, 250)`.
/// - [titleTextStyle]: The text style for the title. Default is an empty `TextStyle`.
/// - [subTitleTextStyle]: The text style for the subtitle. Default is an empty `TextStyle`.
/// - [backgroundColor]: The background color for the onboarding page. This is optional.
///
/// **Usage**:
/// You can create instances of `OnboardingModel` to define the content and styling
/// for each page in an onboarding sequence. This model is typically passed to an
/// onboarding screen to provide the data for rendering each page.
class OnboardingModel {
  final String imageUrl; // URL or asset path for the image
  final String title; // Title or heading for the page
  final String subTitle; // Subtitle or description for the page
  final Size imageSize; // Size of the image, default is `Size(250, 250)`
  final TextStyle titleTextStyle; // Text style for the title
  final TextStyle subTitleTextStyle; // Text style for the subtitle
  final Color? backgroundColor; // Optional background color for the page

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.imageSize = const Size(250, 250),
    this.titleTextStyle = const TextStyle(),
    this.subTitleTextStyle = const TextStyle(),
    this.backgroundColor,
  });
}
