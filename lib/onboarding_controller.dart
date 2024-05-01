import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/onboarding_styles.dart';
import 'package:os_onboarding_screen/os_onboarding_screen.dart';

/// A state controller for managing onboarding page navigation.
///
/// This class controls the state and navigation within an onboarding sequence.
/// It uses a `PageController` to manage page transitions and provides functions
/// to navigate between pages, validate transitions, and trigger actions when the
/// onboarding is completed.
///
/// As an `InheritedWidget`, `OnBoardingStateController` allows child widgets to
/// access its state and functions through context-based lookups. This makes it
/// easy to manage onboarding state across multiple widgets.
///
/// **Attributes**:
/// - [pageController]: The `PageController` used to manage page transitions.
/// - [setPage]: A function to set the current page, optionally animating the transition.
/// - [onDone]: A callback function triggered when onboarding is completed.
/// - [pages]: A list of `OnboardingModel` representing the pages in the sequence.
/// - [currentIndex]: The index of the current page.
/// - [styles]: The styling options for the onboarding sequence, defined by `OnboardingStyles`.
///
/// **Usage**:
/// The `OnBoardingStateController` is typically used within an onboarding screen
/// to control the state and manage transitions between pages. It provides functions
/// to navigate through the onboarding sequence and triggers an `onDone` callback
/// when the onboarding is completed.
///
/// **Methods**:
/// - [isLastIndex]: Returns `true` if the current page is the last in the sequence.
/// - [length]: Returns the total number of pages in the sequence.
/// - [next()]: Moves to the next page.
/// - [prev()]: Moves to the previous page.
/// - [skip()]: Skips to the last page in the sequence.
/// - [getPage()]: Returns the data for the current page.
/// - [_validateOnPageChange(index)]: Validates whether the given page index is within valid bounds.
class OnBoardingStateController extends InheritedWidget {
  final PageController pageController; // Controls page transitions
  final Function(int, bool) setPage; // Function to set the current page
  final void Function() onDone; // Callback when onboarding is completed
  final List<OnboardingModel> pages; // List of onboarding pages
  final int currentIndex; // Tracks the current page index
  final OnboardingStyles styles; // Styling for the onboarding sequence

  const OnBoardingStateController({
    required this.onDone,
    required this.currentIndex,
    required this.setPage,
    required this.pageController,
    required this.pages,
    required super.child,
    required this.styles,
    super.key,
  });

  /// Returns the current [OnBoardingStateController] instance from the widget tree.
  static OnBoardingStateController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OnBoardingStateController>()!;

  /// Determines if the current page is the last in the sequence.
  bool get isLastIndex => currentIndex == pages.length - 1;

  /// Returns the total number of pages in the sequence.
  int get length => pages.length;

  /// Moves to the next page in the sequence.
  void next() {
    final nextIndex = currentIndex + 1;
    if (_validateOnPageChange(nextIndex)) {
      setPage(nextIndex, true); // Animate to the next page
    } else {
      onDone(); // If at the last page, trigger the `onDone` callback
    }
  }

  /// Moves to the previous page in the sequence.
  void prev() {
    final prevIndex = currentIndex - 1;
    if (_validateOnPageChange(prevIndex)) {
      setPage(prevIndex, true); // Move to the previous page without animation
    }
  }

  /// Skips to and done sequence.
  void skip() => onDone();

  /// Validates whether the given page index is within valid bounds.
  bool _validateOnPageChange(int index) {
    return index >= 0 && index < pages.length; // Check index boundaries
  }

  /// Returns the current page's data.
  OnboardingModel getPage() {
    return pages[currentIndex];
  }

  @override
  bool updateShouldNotify(covariant OnBoardingStateController oldWidget) {
    return oldWidget.currentIndex !=
        currentIndex; // Update when the current index changes
  }
}
