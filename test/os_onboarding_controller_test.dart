import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';
import 'package:os_onboarding_screen/onboarding_model.dart';
import 'package:os_onboarding_screen/onboarding_styles.dart';

void main() {
  group('OnBoardingStateController Tests', () {
    OnBoardingStateController createController({
      required List<OnboardingModel> pages,
      required int index,
      required Function(int, bool) setPage,
      required void Function() onDone,
    }) {
      return OnBoardingStateController(
        pages: pages,
        currentIndex: index,
        setPage: setPage,
        pageController: PageController(),
        onDone: onDone,
        styles: OnboardingStyles(),
        child: Container(),
      );
    }

    test('Initial state should be as expected', () {
      final pages = [
        OnboardingModel(
          imageUrl: 'assets/image1.png',
          title: 'Page 1',
          subTitle: 'Welcome to Page 1',
        ),
        OnboardingModel(
          imageUrl: 'assets/image2.png',
          title: 'Page 2',
          subTitle: 'Welcome to Page 2',
        ),
      ];

      void setPage(int index, bool update) {}

      void onDone() {}

      final controller = createController(
        pages: pages,
        index: 0,
        setPage: setPage,
        onDone: onDone,
      );

      expect(controller.length, pages.length);
      expect(controller.isLastIndex, false);
      expect(controller.currentIndex, 0);
    });

    test('Next should move to the next page', () {
      final pages = [
        OnboardingModel(
          imageUrl: 'assets/image1.png',
          title: 'Page 1',
          subTitle: 'Welcome to Page 1',
        ),
        OnboardingModel(
          imageUrl: 'assets/image2.png',
          title: 'Page 2',
          subTitle: 'Welcome to Page 2',
        ),
      ];

      int currentIndex = 0;
      void setPage(int index, bool update) {
        currentIndex = index;
      }

      bool onDoneCalled = false;
      void onDone() {
        onDoneCalled = true;
      }

      final controller = createController(
        pages: pages,
        index: 0,
        setPage: setPage,
        onDone: onDone,
      );

      controller.next();

      expect(currentIndex, 1);
      expect(onDoneCalled, false);
    });

    test('Next should call onDone when on the last page', () {
      final pages = [
        OnboardingModel(
          imageUrl: 'assets/image1.png',
          title: 'Page 1',
          subTitle: 'Welcome to Page 1',
        ),
        OnboardingModel(
          imageUrl: 'assets/image2.png',
          title: 'Page 2',
          subTitle: 'Welcome to Page 2',
        ),
      ];

      int currentIndex = 1;
      void setPage(int index, bool update) {
        currentIndex = index;
      }

      bool onDoneCalled = false;
      void onDone() {
        onDoneCalled = true;
      }

      final controller = createController(
        pages: pages,
        index: 1,
        setPage: setPage,
        onDone: onDone,
      );

      controller.next();

      expect(currentIndex, 1);
      expect(onDoneCalled, true);
    });

    test('Prev should move to the previous page', () {
      final pages = [
        OnboardingModel(
          imageUrl: 'assets/image1.png',
          title: 'Page 1',
          subTitle: 'Welcome to Page 1',
        ),
        OnboardingModel(
          imageUrl: 'assets/image2.png',
          title: 'Page 2',
          subTitle: 'Welcome to Page 2',
        ),
      ];

      int currentIndex = 1;
      void setPage(int index, bool update) {
        currentIndex = index;
      }

      final controller = createController(
        pages: pages,
        index: 1,
        setPage: setPage,
        onDone: () {},
      );

      controller.prev();

      expect(currentIndex, 0);
    });
  });
}
