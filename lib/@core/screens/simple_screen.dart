import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/components/indicators/dot_indicator.dart';
import 'package:os_onboarding_screen/@core/components/indicators/simple_progress_round_button.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';
import 'package:os_onboarding_screen/onboarding_controller.dart';

class SimpleOnboardingView extends StatelessWidget {
  final bool isSimple;
  final TextStyle title;
  final TextStyle subTitle;
  final String buttonSkipTitle;
  final TextStyle buttonSkipStyle;
  final String buttonNextTitle;
  final TextStyle buttonNextStyle;
  final String buttonDoneTitle;
  final TextStyle buttonDoneStyle;
  const SimpleOnboardingView(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.isSimple,
      required this.buttonSkipTitle,
      required this.buttonSkipStyle,
      required this.buttonNextTitle,
      required this.buttonNextStyle,
      required this.buttonDoneTitle,
      required this.buttonDoneStyle});

  @override
  Widget build(BuildContext context) {
    final state = OnBoardingStateController.of(context);

    return Column(
      children: [
        Visibility(
          visible: !state.isLastIndex,
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: state.skip,
              child: Text(
                buttonSkipTitle,
                style: buttonSkipStyle,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: PageView.builder(
              controller: state.pageController,
              onPageChanged: state.setPage,
              itemCount: state.length,
              itemBuilder: (BuildContext context, index) {
                final pageData = state.pages[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(pageData.imageUrl),
                      ),
                      const SizedBox(
                        height: InsetsHelper.i10,
                      ),
                      Text(pageData.title, style: title),
                      Text(
                        pageData.subTitle,
                        style: subTitle,
                      )
                    ],
                  ),
                );
              }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: state.isLastIndex && isSimple,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: TextButton(
                onPressed: state.onDone,
                child: Text(
                  buttonDoneTitle,
                  style: buttonDoneStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: InsetsHelper.i10),
              child: isSimple
                  ? CustomDotIndicator(
                      currentIndex: OnBoardingStateController.of(context).index,
                      totalDots:
                          OnBoardingStateController.of(context).pages.length)
                  : const SimpleProgressRoundButtonWidget(),
            )
          ],
        ),
      ],
    );
  }
}
