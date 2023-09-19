// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// The widget is used to customize the background of the weathers widget scene.
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.colors,
    required this.child,
    bool? isLeftCorner,
    bool? isBackgroundShown,
  })  : isLeftCorner = isLeftCorner ?? false,
        isBackgroundShown = isBackgroundShown ?? true,
        super(key: key);

  /// List of colors for creating a linear gradient.
  final List<Color> colors;

  /// Gradient direction.
  final bool isLeftCorner;

  /// the widget to display above the background
  final Widget child;

  /// Shows a static colored gradient as background (default: true)
  final bool isBackgroundShown;

  @override
  Widget build(BuildContext context) {
    if (isBackgroundShown == true) {
      final Widget widget = () {
        switch (colors.length) {
          case 0:
            return child;
          case 1:
            return ColoredBox(color: colors.first, child: child);
          case 2:
          default:
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: isLeftCorner ? Alignment.topRight : Alignment.topLeft,
                  end: isLeftCorner
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                ),
              ),
              child: child,
            );
        }
      }();

      return widget;
    } else {
      return child;
    }
  }
}
