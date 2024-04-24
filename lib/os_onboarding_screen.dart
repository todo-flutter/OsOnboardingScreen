library os_onboarding_screen;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:os_onboarding_screen/@core/screens/simple_screen.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';
import 'package:os_onboarding_screen/onboarding_model.dart';

export './onboarding_model.dart';

// Enum para tipos de onboarding
enum OnboardingType { simple, simpleWithProgressButton }

// Clase principal del widget de onboarding
class OSOnboardingScreen extends StatefulWidget {
  final List<OnboardingModel> pages;
  final Color? backgroundColor;
  final String buttonDoneTitle;
  final TextStyle buttonDoneStyle;
  final String buttonSkipTitle;
  final TextStyle buttonSkipStyle;
  final String buttonNextTitle;
  final TextStyle buttonNextStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final void Function() onDone;
  final OnboardingType onboardingType;

  const OSOnboardingScreen({
    super.key,
    required this.pages,
    this.backgroundColor,
    this.buttonSkipTitle = "Skip",
    this.buttonSkipStyle = const TextStyle(),
    this.buttonNextTitle = "Next",
    this.buttonNextStyle = const TextStyle(),
    this.titleStyle = const TextStyle(
      fontSize: InsetsHelper.i20,
      fontWeight: FontWeight.w400,
    ),
    this.subTitleStyle = const TextStyle(
      fontSize: InsetsHelper.i12,
      fontWeight: FontWeight.w400,
    ),
    required this.onDone,
    required this.onboardingType,
    this.buttonDoneTitle = "Get Started",
    this.buttonDoneStyle = const TextStyle(),
  });

  @override
  State<OSOnboardingScreen> createState() => _OSOnboardingScreenState();
}

// Estado para el widget de onboarding
class _OSOnboardingScreenState extends State<OSOnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  // Inicialización de controladores y estado
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  // Limpiar recursos en la destrucción del widget
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Configurar la página activa
  void _setPage(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.background;

    return SafeArea(
      child: Material(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            color: backgroundColor,
            child: OnBoardingStateController(
              onDone: widget.onDone,
              index: _currentIndex,
              pageController: _pageController,
              setPage: _setPage,
              pages: widget.pages,
              child: _buildOnboardingView(),
            ),
          ),
        ),
      ),
    );
  }

  // Construir la vista de onboarding
  Widget _buildOnboardingView() {
    return SimpleOnboardingView(
      title: widget.titleStyle,
      subTitle: widget.subTitleStyle,
      isSimple:
          widget.onboardingType == OnboardingType.simpleWithProgressButton,
      buttonNextStyle: widget.buttonNextStyle,
      buttonNextTitle: widget.buttonNextTitle,
      buttonSkipStyle: widget.buttonSkipStyle,
      buttonSkipTitle: widget.buttonSkipTitle,
      buttonDoneStyle: widget.buttonDoneStyle,
      buttonDoneTitle: widget.buttonDoneTitle,
    );
  }
}
