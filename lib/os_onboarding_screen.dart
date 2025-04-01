library;

import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/screens/simple_screen.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';
import 'package:os_onboarding_screen/onboarding_model.dart';
import 'package:os_onboarding_screen/onboarding_styles.dart';

// Exporting the `OnboardingModel` to allow reuse in other parts of the app.
export './onboarding_model.dart';

/// Defines the type of onboarding experience.
enum OnboardingType {
  simple, // Basic onboarding with skip and next buttons
  simpleWithProgressButton, // Onboarding with a progress indicator
}

/// A customizable Flutter onboarding screen widget.
///
/// This widget allows you to create onboarding experiences with multiple pages.
/// It uses a `PageController` to manage transitions between onboarding pages and
/// offers customizable attributes for button texts, styles, and background color.
///
/// The `OSOnboardingScreen` supports two types of onboarding:
/// - `simple`: Basic onboarding with skip and next buttons.
/// - `simpleWithProgressButton`: Onboarding with a circular progress button.
///
/// **Parameters**:
/// - [pages]: List of `OnboardingModel` representing the pages.
/// - [onDone]: Callback function triggered when onboarding is completed.
/// - [onboardingType]: The type of onboarding.
/// - [buttonSkipTitle]: Text for the "Skip" button. Defaults to "Skip".
/// - [buttonDoneTitle]: Text for the "Done" button. Defaults to "Get Started".
/// - [buttonNextTitle]: Text for the "Next" button. Defaults to "Next".
/// - [styles]: Customizable styles for onboarding.
///
/// **Usage**:
/// Create an `OSOnboardingScreen` with a list of `OnboardingModel` pages and an
/// `onDone` callback to handle when onboarding is completed. Customize styles
/// using the optional `OnboardingStyles` parameter.
class OSOnboardingScreen extends StatefulWidget {
  final List<OnboardingModel> pages; // List of onboarding pages
  final String buttonDoneTitle; // Text for the "Done" button
  final String buttonNextTitle; // Text for the "Next" button
  final String buttonSkipTitle; // Text for the "Skip" button
  final void Function() onDone; // Callback when onboarding is completed
  final OnboardingType onboardingType; // Type of onboarding experience
  final OnboardingStyles? styles; // Optional custom styles

  const OSOnboardingScreen({
    super.key,
    required this.pages,
    required this.onDone,
    required this.onboardingType,
    this.buttonSkipTitle = "Skip",
    this.buttonDoneTitle = "Get Started",
    this.buttonNextTitle = "Next",
    this.styles,
  });

  @override
  State<OSOnboardingScreen> createState() => _OSOnboardingScreenState();
}

/// State class for `OSOnboardingScreen`.
///
/// This class manages the page transitions and keeps track of the current page index.
/// It controls the logic for transitioning between onboarding pages, using a `PageController`.
class _OSOnboardingScreenState extends State<OSOnboardingScreen> {
  late final PageController _pageController; // Controls page transitions
  late final OnboardingStyles onboardingStyles; // Styles for onboarding
  int _currentIndex = 0; // Tracks the current page index

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    onboardingStyles = widget.styles ?? OnboardingStyles();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Properly dispose of the controller
    super.dispose();
  }

  /// Sets the current page and animates the transition if needed.
  ///
  /// - [index]: The index of the page to transition to.
  /// - [animate]: Whether to animate the page transition.
  void _setPage(int index, bool animate) {
    if (animate) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingStyles.backgroundColor,
      body: OnBoardingStateController(
        onDone: widget.onDone,
        currentIndex: _currentIndex,
        pageController: _pageController,
        setPage: _setPage,
        pages: widget.pages,
        styles: onboardingStyles,
        child: _buildOnboardingView(),
      ),
    );
  }

  /// Builds the view for the onboarding screen.
  Widget _buildOnboardingView() {
    return SimpleOnboardingView(
      isSimple: widget.onboardingType == OnboardingType.simple,
      buttonNextTitle: widget.buttonNextTitle,
      buttonSkipTitle: widget.buttonSkipTitle,
      buttonDoneTitle: widget.buttonDoneTitle,
    );
  }
}
