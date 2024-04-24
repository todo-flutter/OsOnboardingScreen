import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';

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
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalDots,
          (index) => AnimatedContainer(
            duration: Durations.long1,
            margin: const EdgeInsets.symmetric(horizontal: InsetsHelper.i4),
            width: currentIndex == index ? InsetsHelper.i30 : inactiveSize,
            height: currentIndex == index ? activeSize : inactiveSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(InsetsHelper.i10),
              color: currentIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
