import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';

/// A custom linear progress indicator with optional text.
///
/// This widget displays a linear progress indicator with an optional
/// text label below it. It is useful for showing the progress of a
/// task or operation while providing additional information to the user.
///
/// [text] is the optional text displayed below the progress bar.
/// [textStyle] defines the style for the text (default is 12-point font).
///
class CustomLinealProgressIndicator extends StatelessWidget {
  final String? text;
  final TextStyle textStyle;

  const CustomLinealProgressIndicator({
    super.key,
    this.text,
    this.textStyle = const TextStyle(fontSize: InsetsHelper.i12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: InsetsHelper.i5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(
                  top: 8), // Space between indicator and text
              child: Text(
                text!,
                style: textStyle,
              ),
            ),
        ],
      ),
    );
  }
}
