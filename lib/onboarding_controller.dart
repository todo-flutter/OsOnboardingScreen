import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/os_onboarding_screen.dart';

class OnBoardingStateController extends InheritedWidget {
  final PageController pageController;
  final Function(int, bool updatePage) setPage;
  final void Function() onDone;
  final List<OnboardingModel> pages;
  final int index;

  const OnBoardingStateController({
    required this.onDone,
    required this.index,
    required this.setPage,
    required this.pageController,
    super.key,
    required super.child,
    required this.pages,
  });

  bool get isLastIndex => index == pages.length - 1;

  int get length => pages.length;

  static OnBoardingStateController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OnBoardingStateController>()!;

  @override
  bool updateShouldNotify(covariant OnBoardingStateController oldWidget) {
    return oldWidget.index != index;
  }

  OnboardingModel getPage() {
    return pages[index];
  }

  void next() {
    final next = index + 1;

    if (_validateOnPageChange(next)) {
      setPage(next, true);
    } else {
      onDone();
    }
  }

  void prev() {
    final next = index - 1;
    if (_validateOnPageChange(next)) {
      setPage(next, false);
    }
  }

  void skip() {
    setPage(pages.length - 1, true);
  }

  bool _validateOnPageChange(int next) {
    if (next < 0) {
      return false;
    }

    if (next > (pages.length - 1)) {
      return false;
    }

    return true;
  }
}
