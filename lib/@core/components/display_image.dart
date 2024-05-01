import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget for displaying images from various sources and formats.
///
/// The `DisplayImage` class is a versatile widget that can display images from
/// either network sources or local assets. It supports common image formats, such as
/// `SVG`, `PNG`, `JPEG`, `JPG`, and `GIF`. The widget determines the appropriate
/// rendering method based on the image URL's prefix and extension.
///
/// **Parameters**:
/// - [imageUrl]: The URL or asset path of the image to display.
/// - [backgroundColor]: An optional background color to apply to the image (used as a `ColorFilter` for `SVG` and as a tint for other formats).
/// - [size]: The desired size of the image, specified as a `Size` object.
///
/// **Usage**:
/// ```dart
/// DisplayImage(
///   imageUrl: "https://example.com/image.png",
///   size: Size(100, 100),
/// ),
/// ```
///
/// The widget handles different image formats and sources:
/// - **SVG Images**: Uses `flutter_svg` to render `SVG` images from network or asset sources.
/// - **Raster Images**: For `PNG`, `JPEG/JPG`, and `GIF`, it uses `Image.network` or `Image.asset` depending on the source.
///
/// If the image extension is not recognized or the URL does not indicate a network-based source, it returns an error icon as a fallback.
class DisplayImage extends StatelessWidget {
  final String imageUrl; // The URL or asset path of the image
  final Color?
      backgroundColor; // Optional background color (used as a tint or filter)
  final Size size; // Desired size of the image

  const DisplayImage({
    super.key,
    required this.imageUrl,
    this.backgroundColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the image comes from a network source
    final isNetworkImage = imageUrl.toLowerCase().startsWith('http://') ||
        imageUrl.toLowerCase().startsWith('https://');

    // Extract the file extension
    final RegExp extensionPattern = RegExp(r'\.(\w+)$');
    final match = extensionPattern.firstMatch(imageUrl.toLowerCase());

    if (match != null) {
      final extension = match.group(1);

      if (extension == 'svg') {
        // Handle SVG images
        return isNetworkImage
            ? SvgPicture.network(
                imageUrl,
                height: size.height,
                width: size.width,
                colorFilter: backgroundColor != null
                    ? ColorFilter.mode(backgroundColor!, BlendMode.srcIn)
                    : null,
              )
            : SvgPicture.asset(
                imageUrl,
                height: size.height,
                width: size.width,
                colorFilter: backgroundColor != null
                    ? ColorFilter.mode(backgroundColor!, BlendMode.srcIn)
                    : null,
              );
      }

      if (extension == 'png' ||
          extension == 'jpeg' ||
          extension == 'jpg' ||
          extension == 'gif') {
        // Handle raster images (PNG, JPEG/JPG, GIF)
        return isNetworkImage
            ? Image.network(
                imageUrl,
                height: size.height,
                width: size.width,
                color: backgroundColor,
              )
            : Image.asset(
                imageUrl,
                height: size.height,
                width: size.width,
                color: backgroundColor,
              );
      }
    }

    // Fallback widget for unknown image formats
    return Icon(
      Icons.error,
      size: size.height,
    );
  }
}
