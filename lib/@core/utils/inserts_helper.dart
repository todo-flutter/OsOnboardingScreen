import 'package:flutter/material.dart';

/// A helper class for common inset values.
///
/// The `InsetsHelper` class provides a set of constant double values for
/// commonly used insets, padding, margins, or other spacing-related measurements.
/// These constants can be used to maintain consistent spacing across a Flutter
/// application, reducing the need for hardcoding values and promoting reusability.
///
/// **Usage**:
/// Instead of hardcoding inset values throughout your Flutter code, use constants
/// from `InsetsHelper` for more maintainable and consistent code. This can be
/// especially useful for padding and margin insets, ensuring consistent spacing
/// throughout your app.
///
/// **Common Values**:
/// - [i0] through [i100]: A set of predefined constants for common inset values.
/// - Can be used for padding, margins, spacing, or any other layout-related purposes.
///
/// Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(InsetsHelper.i8),
///   child: Text("Hello, World!"),
/// )
/// ```
@immutable
class InsetsHelper {
  static const double i0 = 0;
  static const double i1 = 1;
  static const double i2 = 2;
  static const double i4 = 4;
  static const double i5 = 5;
  static const double i6 = 6;
  static const double i7 = 7;
  static const double i8 = 8;
  static const double i10 = 10;
  static const double i11 = 11;
  static const double i12 = 12;
  static const double i13 = 13;
  static const double i14 = 14;
  static const double i15 = 15;
  static const double i16 = 16;
  static const double i17 = 17;
  static const double i18 = 18;
  static const double i19 = 19;
  static const double i20 = 20;
  static const double i24 = 24;
  static const double i25 = 25;
  static const double i30 = 30;
  static const double i32 = 32;
  static const double i45 = 45;
  static const double i48 = 48;
  static const double i56 = 56;
  static const double i80 = 80;
  static const double i100 = 100;
}
