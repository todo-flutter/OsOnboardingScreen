import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/components/display_image.dart';
import 'package:os_onboarding_screen/@core/components/indicators/dot_indicator.dart';
import 'package:os_onboarding_screen/@core/components/indicators/simple_progress_round_button.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';

/// A simple onboarding view with optional skip, next, and done buttons.
///
/// This widget is designed for onboarding screens and provides flexibility
/// for different onboarding experiences. It supports two types of navigation:
/// - Simple dot-based navigation to indicate the current page.
/// - A circular progress button for step-by-step navigation.
///
/// [isSimple] determines the type of navigation (dot-based or circular progress button).
/// [buttonSkipTitle], [buttonNextTitle], and [buttonDoneTitle] define the text for the skip, next, and done buttons, respectively.
class SimpleOnboardingView extends StatelessWidget {
  final bool isSimple;
  final String buttonSkipTitle;
  final String buttonNextTitle;
  final String buttonDoneTitle;

  /// Creates a simple onboarding view.
  ///
  /// - [isSimple]: If true, uses dot-based navigation; otherwise, uses a circular progress button.
  /// - [title]: Text style for the page titles.
  /// - [subTitle]: Text style for the page subtitles.
  /// - [buttonSkipTitle]: Text for the skip button.
  /// - [buttonSkipStyle]: Style for the skip button.
  /// - [buttonNextTitle]: Text for the next button.
  /// - [buttonNextStyle]: Style for the next button.
  /// - [buttonDoneTitle]: Text for the done button.
  /// - [buttonDoneStyle]: Style for the done button.
  const SimpleOnboardingView({
    super.key,
    required this.isSimple,
    required this.buttonSkipTitle,
    required this.buttonNextTitle,
    required this.buttonDoneTitle,
  });

  @override
  Widget build(BuildContext context) {
    final state = OnBoardingStateController.of(context);

    final padding = MediaQuery.of(context).padding;

    return Stack(
      children: [
        // Page view with onboarding content
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: state.pageController,
                onPageChanged: (index) => state.setPage(index, false),
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final pageData = state.pages[index];
                  return Stack(
                    children: [
                      Positioned(
                        bottom: InsetsHelper.i0,
                        top: InsetsHelper.i0,
                        right: InsetsHelper.i0,
                        left: InsetsHelper.i0,
                        child: DisplayImage(
                          imageUrl: pageData.imageUrl,
                          size: pageData.imageSize,
                          backgroundColor: pageData.backgroundColor,
                          boxFit: pageData.imageFit,
                        ),
                      ),
                      Positioned(
                        bottom: InsetsHelper.i56 +
                            padding.bottom +
                            (isSimple ? InsetsHelper.i0 : innerCircleSize),
                        left: InsetsHelper.i0,
                        right: InsetsHelper.i0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pageData.title,
                              style: state.styles.titleStyle,
                            ),
                            Text(
                              pageData.subTitle,
                              style: state.styles.subTitleStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),

        // // Navigation controls and indicators
        Positioned(
          bottom: padding.bottom,
          right: InsetsHelper.i10,
          left: InsetsHelper.i10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: state.currentIndex > 0,
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                child: IconButton(
                    onPressed: () => state.prev(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: state.styles.indicatorColor,
                    )),
              ),
              isSimple
                  ? Expanded(
                      child: CustomDotIndicator(
                        currentIndex: state.currentIndex,
                        totalDots: state.length,
                      ),
                    )
                  : const SimpleProgressRoundButtonWidget(),
              Visibility(
                visible: !state.isLastIndex,
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                child: IconButton(
                    onPressed: () => state.next(),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: state.styles.indicatorColor,
                    )),
              )
            ],
          ),
        ),

        // Skip button
        Positioned(
          right: InsetsHelper.i10,
          top: padding.top < InsetsHelper.i10 ? InsetsHelper.i10 : padding.top,
          child: Row(
            children: [
              Visibility(
                visible: state.isLastIndex && isSimple,
                maintainAnimation: false,
                maintainSize: false,
                maintainState: false,
                child: TextButton(
                  onPressed: state.onDone,
                  child: Text(
                    buttonDoneTitle,
                    style: state.styles.buttonDoneStyle,
                  ),
                ),
              ),
              Visibility(
                visible: !state.isLastIndex,
                maintainAnimation: false,
                maintainSize: false,
                maintainState: false,
                child: TextButton(
                  onPressed: state.skip,
                  child: Text(
                    buttonSkipTitle,
                    style: OnBoardingStateController.of(context)
                        .styles
                        .buttonSkipStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
