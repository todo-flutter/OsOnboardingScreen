import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:os_onboarding_screen/onboarding_controller.dart';

const double _circleSize = 80.0;
const double _innerCircleSize = 55.0;
const double _iconSize = 15.0;

/// A round button widget with a progress indicator used in onboarding screens.
///
/// The `SimpleProgressRoundButtonWidget` shows a circular progress bar with a
/// central button. The button can change its appearance and functionality
/// depending on whether it's the last step of the onboarding process or not.
/// This widget typically resides at the bottom of the screen and helps users
/// navigate through onboarding steps.
class SimpleProgressRoundButtonWidget extends StatelessWidget {
  const SimpleProgressRoundButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = OnBoardingStateController.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: _circleSize,
          height: _circleSize,
          child: CircleProgressBar(
            backgroundColor: Colors.white,
            foregroundColor: state.isLastIndex
                ? Colors.green
                : Theme.of(context).primaryColor,
            value: (state.currentIndex + 1) / state.length.toDouble(),
          ),
        ),
        _buildInnerCircle(state, context),
      ],
    );
  }

  Widget _buildInnerCircle(
      OnBoardingStateController state, BuildContext context) {
    final color = state.isLastIndex
        ? Colors.green
        : OnBoardingStateController.of(context).styles.indicatorColor ??
            Theme.of(context).primaryColor;

    return Container(
      height: _innerCircleSize,
      width: _innerCircleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: TextButton(
          onPressed: state.next,
          child: !state.isLastIndex
              ? Text(
                  '${state.currentIndex + 1}',
                  style: const TextStyle(color: Colors.white),
                )
              : const Icon(
                  Icons.check,
                  color: Colors.white,
                )),
    );
  }
}

class CircleProgressBar extends StatefulWidget {
  final Duration? animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? value;

  const CircleProgressBar({
    super.key,
    this.animationDuration = const Duration(seconds: 1),
    this.backgroundColor = const Color(0x00000000),
    required this.foregroundColor,
    this.value = 0,
  });

  @override
  State<CircleProgressBar> createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  late Tween<double>? _valueTween;
  Tween<Color?>? _backgroundColorTween;
  Tween<Color?>? _foregroundColorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration!,
      vsync: this,
    );

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _initTweens();
    _controller.forward();
  }

  void _initTweens() {
    _valueTween = Tween<double>(begin: 0, end: widget.value);
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      double beginValue = _valueTween?.evaluate(_curve) ?? oldWidget.value!;
      _valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value,
      );

      _updateColorTweens(oldWidget);

      _controller
        ..value = 0
        ..forward();
    }
  }

  void _updateColorTweens(CircleProgressBar oldWidget) {
    if (widget.backgroundColor != oldWidget.backgroundColor) {
      _backgroundColorTween = ColorTween(
        begin: oldWidget.backgroundColor,
        end: widget.backgroundColor,
      );
    } else {
      _backgroundColorTween = null;
    }

    if (widget.foregroundColor != oldWidget.foregroundColor) {
      _foregroundColorTween = ColorTween(
        begin: oldWidget.foregroundColor,
        end: widget.foregroundColor,
      );
    } else {
      _foregroundColorTween = null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) {
          final backgroundColor =
              _backgroundColorTween?.evaluate(_curve) ?? widget.backgroundColor;
          final foregroundColor =
              _foregroundColorTween?.evaluate(_curve) ?? widget.foregroundColor;

          return CustomPaint(
            foregroundPainter: _CircleProgressBarPainter(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              percentage: _valueTween!.evaluate(_curve),
            ),
            child: child,
          );
        },
        child: Container(),
      ),
    );
  }
}

class _CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color foregroundColor;

  _CircleProgressBarPainter({
    this.backgroundColor,
    required this.foregroundColor,
    required this.percentage,
    double? strokeWidth,
  }) : strokeWidth = strokeWidth ?? 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (math.min(size.width, size.height) / 2) - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor ?? Colors.transparent
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (backgroundColor != null) {
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    const startAngle = -(2 * math.pi * 0.25); // start at 12 o'clock.
    final sweepAngle = 2 * math.pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as _CircleProgressBarPainter;
    return oldPainter.percentage != percentage ||
        oldPainter.backgroundColor != backgroundColor ||
        oldPainter.foregroundColor != foregroundColor ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
