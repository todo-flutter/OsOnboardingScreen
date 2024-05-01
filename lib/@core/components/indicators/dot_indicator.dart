import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';

/// A custom dot indicator for showing progress through multiple steps.
///
/// This widget is commonly used in onboarding screens or step-based wizards
/// to indicate the current step or page. It displays a row of dots, with the
/// active dot styled differently from the inactive ones.
///
/// [currentIndex] specifies the current active step.
/// [totalDots] is the total number of steps or pages.
/// [activeSize] and [inactiveSize] define the size of the dots.
///
class CustomDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;
  final double activeSize;
  final double inactiveSize;

  const CustomDotIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
    this.activeSize = InsetsHelper.i10,
    this.inactiveSize = InsetsHelper.i8,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorColor =
        OnBoardingStateController.of(context).styles.indicatorColor ??
            Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalDots,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Animation duration
            margin: const EdgeInsets.symmetric(horizontal: InsetsHelper.i4),
            width: currentIndex == index ? InsetsHelper.i30 : inactiveSize,
            height: currentIndex == index ? activeSize : inactiveSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(InsetsHelper.i10),
              color: currentIndex == index
                  ? indicatorColor
                  : indicatorColor.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
