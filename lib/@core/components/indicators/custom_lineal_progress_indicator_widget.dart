import 'package:flutter/material.dart';
import 'package:os_onboarding_screen/@core/utils/inserts_helper.dart';

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
            Text(
              text!,
              style: textStyle,
            )
        ],
      ),
    );
  }
}
