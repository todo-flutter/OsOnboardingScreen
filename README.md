# OS Onboarding Screen

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev/)

OS Onboarding Screen is a Flutter package that makes it easy to create onboarding screens for apps. Includes controllers and visual components to create onboarding experiences with different styles, such as progress buttons and point indicators.

## Characteristics

- Onboarding screens with configurable design.
- Support for different types of navigation controls.
- Controller to manage the onboarding logic.
- Reusable components for progress, buttons, and more.

## Getting Started

Add it to your `pubspec.yaml` file:

```yaml
dependencies:
  os_onboarding_screen: ^1.0.0
```

## Usage

To use this widget

1. import 'package:os_onboarding_screen/os_onboarding_screen.dart'; 
inside your dart file
2. Utilize the widget as bellow:

## Onboarding Views

OS Onboarding Screen offers two distinct onboarding views to suit different needs: `SimpleOnboardingView` and `SimpleOnboardingViewWithButton`. Here's a brief overview of each, along with visual examples.

### Simple Onboarding View

This is a basic onboarding view with simple page transitions. It displays an image and text content for each onboarding step. It is suitable for straightforward onboarding processes without additional navigation controls.

Example configuration for a simple onboarding view:

```dart
OSOnboardingScreen(
  onboardingType: OnboardingType.simple,
  pages: [
    OnboardingModel(
      imageUrl: 'assets/simple1.png',
      title: 'Welcome to our app',
      subTitle: 'A brief introduction to get started.',
    ),
    OnboardingModel(
      imageUrl: 'assets/simple2.png',
      title: 'Key Features',
      subTitle: 'Here are some features you might like.',
    ),
  ],
  onDone: () {
    // Action when onboarding is completed
  },
)
```
### Simple Onboarding View with Progress Button

This view includes additional navigation controls, such as a progress button, allowing users to progress through the onboarding steps by interacting with a button. It's ideal for more interactive onboarding processes where users have control over page transitions.

Example configuration for an onboarding view with a progress button:

```dart
OSOnboardingScreen(
  onboardingType: OnboardingType.simpleWithProgressButton,
  pages: [
    OnboardingModel(
      imageUrl: 'assets/button1.png',
      title: 'Getting Started',
      subTitle: 'Click the button to proceed to the next step.',
    ),
    OnboardingModel(
      imageUrl: 'assets/button2.png',
      title: 'Discover Features',
      subTitle: 'Learn about the features of our app.',
    ),
  ],
  onDone: () {
    // Action when onboarding is completed
  },
)
```
