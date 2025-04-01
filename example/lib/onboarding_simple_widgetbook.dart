import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/os_onboarding_screen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const mockDashboardImage = 'assets/1.jpg';

@widgetbook.UseCase(name: 'Default', type: OSOnboardingScreen)
Widget buildSimpleOSOnboardingScreenUseCase(BuildContext context) {
  return OSOnboardingScreen(
    onboardingType: OnboardingType.simple,
    pages: [
      OnboardingModel(
        imageUrl: mockDashboardImage,
        title: 'Welcome to our app',
        subTitle: 'A brief introduction to get started. ',
      ),
      OnboardingModel(
        imageUrl: mockDashboardImage,
        title: 'Key Features',
        subTitle: 'Here are some features you might like.',
      ),
    ],
    onDone: () {},
  );
}

@widgetbook.UseCase(name: 'With Round Button', type: OSOnboardingScreen)
Widget buildSimpleWithProgressButton(BuildContext context) {
  return OSOnboardingScreen(
    onboardingType: OnboardingType.simpleWithProgressButton,
    pages: [
      OnboardingModel(
        imageUrl: mockDashboardImage,
        title: 'Welcome to our app',
        subTitle: 'A brief introduction to get started. ',
      ),
      OnboardingModel(
        imageUrl: mockDashboardImage,
        title: 'Key Features',
        subTitle: 'Here are some features you might like.',
      ),
    ],
    onDone: () {},
  );
}
