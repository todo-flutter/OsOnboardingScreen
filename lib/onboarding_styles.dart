import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';

/// Defines styling options for the onboarding screen.
///
/// The `OnboardingStyles` class provides a way to customize the visual
/// appearance of the onboarding screen. This includes settings for text styles,
/// background color, indicator color, and more.
///
/// You can pass an instance of `OnboardingStyles` to `OSOnboardingScreen` to
/// customize the onboarding experience. If not provided, default styles are used.
///
/// **Parameters**:
/// - [backgroundColor]: Color to use as the background for the onboarding screen.
/// - [indicatorColor]: Color for the progress indicator on the onboarding screen.
/// - [buttonDoneStyle]: Text style for the "Done" button. Default is an empty `TextStyle`.
/// - [buttonSkipStyle]: Text style for the "Skip" button. Default is an empty `TextStyle`.
/// - [buttonNextStyle]: Text style for the "Next" button. Default is an empty `TextStyle`.
/// - [titleStyle]: Text style for the title text. Default font size is 20, with `FontWeight.w400`.
/// - [subTitleStyle]: Text style for the subtitle text. Default font size is 12, with `FontWeight.w400`.
///
/// **Usage**:
/// When creating an instance of `OSOnboardingScreen`, you can pass an instance
/// of `OnboardingStyles` to customize the look and feel of the screen. You can
/// specify individual text styles for various components, set the background
/// color, and define the color of the progress indicator.
class OnboardingStyles {
  final Color? backgroundColor; // Background color of the screen
  final Color? indicatorColor; // Color for the progress indicator
  final TextStyle buttonDoneStyle; // Style for the "Done" button
  final TextStyle buttonSkipStyle; // Style for the "Skip" button
  final TextStyle buttonNextStyle; // Style for the "Next" button
  final TextStyle titleStyle; // Style for the title text
  final TextStyle subTitleStyle; // Style for the subtitle text

  OnboardingStyles({
    this.backgroundColor,
    this.indicatorColor,
    this.buttonDoneStyle = const TextStyle(),
    this.buttonSkipStyle = const TextStyle(),
    this.buttonNextStyle = const TextStyle(),
    this.titleStyle = const TextStyle(
      fontSize: InsetsHelper.i20,
      fontWeight: FontWeight.w400,
    ),
    this.subTitleStyle = const TextStyle(
      fontSize: InsetsHelper.i12,
      fontWeight: FontWeight.w400,
    ),
  });
}
