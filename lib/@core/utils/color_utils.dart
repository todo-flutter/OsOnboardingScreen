import 'package:flutter/material.dart';

/// A custom `Color` subclass that allows creating `Color` instances from hexadecimal color codes.
///
/// The `HexColor` class provides a convenient way to create a `Color` from a hexadecimal string.
/// It handles hex color codes with or without a leading '#', and ensures that codes with six characters
/// are properly converted to eight characters (adding a default alpha value).
///
/// **Usage**:
/// ```dart
/// final myColor = HexColor.fromHex("#FF5733"); // Using a leading '#'
/// final myColor2 = HexColor.fromHex("FF5733");  // Without a leading '#'
/// final myColor3 = HexColor.fromHex("5733");    // Automatically adds default alpha
/// ```
///
/// You can use `HexColor` anywhere a `Color` is expected, providing a flexible way to work with
/// hexadecimal color codes in Flutter.
class HexColor extends Color {
  /// Converts a hexadecimal color string to an integer value.
  ///
  /// This method removes any leading '#' and ensures the hexadecimal string
  /// is properly formatted to convert to an integer. If the string has only
  /// six characters, it adds 'FF' at the beginning to represent full opacity.
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add full alpha if only six characters
    }
    return int.parse(hexColor, radix: 16); // Convert to integer
  }

  /// Creates a `HexColor` instance from a hexadecimal color code.
  ///
  /// This constructor allows you to create a `HexColor` from an integer value,
  /// typically obtained by converting a hexadecimal color code.
  const HexColor(super.value);

  /// Creates a `HexColor` instance from a hexadecimal color string.
  ///
  /// This factory method accepts a hexadecimal color string, converts it to an
  /// integer using `_getColorFromHex`, and returns a `HexColor` instance.
  factory HexColor.fromHex(String hexColor) {
    final value = _getColorFromHex(hexColor);
    return HexColor(value); // Create `HexColor` from converted value
  }
}
