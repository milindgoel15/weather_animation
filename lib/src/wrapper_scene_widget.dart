// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'background_widget.dart';

/// A very handy wrapper for positioning the scene and placing weather widgets
/// on it. Applies smart scaling so that your weather widgets are placed evenly
/// across the screen parameters provided.
class WrapperScene extends StatelessWidget {
  const WrapperScene({
    Key? key,
    this.sizeCanvas = const Size(350.0, 540.0),
    this.clip = Clip.antiAlias,
    this.decoration = const BoxDecoration(),
    required this.children,
    this.isLeftCornerGradient,
    required this.colors,
    required this.alignmentGeometry,
    required this.tempWidget,
    required this.dateWidget,
    required this.locWidget,
    required this.mainAxisAlignment,
    this.isBackgroundShown = true,
  }) : super(key: key);

  /// Widget size. Default to [Size(350.0, 540.0)].
  ///
  /// Specify this size to determine the size of this widget (canvas).
  final Size sizeCanvas;

  /// Cropping parts that go beyond the contours [sizeCanvas].
  final Clip clip;

  /// Apply decorations to shape your scene.
  final Decoration decoration;

  /// Provide weather widgets [SunWidget], [CloudWidget], [SnowWidget] or others.
  ///
  /// Any other widgets can be presented to your liking.
  final List<Widget> children;

  /// Specify whether the gradient starts on the left side.
  final bool? isLeftCornerGradient;

  /// Scene background colors. See [BackgroundWidget] for more details.
  final List<Color> colors;

  final AlignmentGeometry alignmentGeometry;

  final Widget tempWidget;
  final Widget dateWidget;
  final Widget locWidget;
  final MainAxisAlignment mainAxisAlignment;

  /// Shows a static colored gradient as background (default: true)
  final bool? isBackgroundShown;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(sizeCanvas),
      clipBehavior: clip,
      decoration: decoration,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size sizeConstraints = constraints.biggest;

          final double scaleTrue = math.min(
            sizeConstraints.height / sizeCanvas.height,
            sizeConstraints.width / sizeCanvas.width,
          );

          return BackgroundWidget(
            colors: colors,
            isLeftCorner: isLeftCornerGradient,
            isBackgroundShown: isBackgroundShown,
            child: Column(
              children: [
                dateWidget,
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      SizedBox(
                        height: 128,
                        width: 128,
                        child: Transform.scale(
                          alignment: alignmentGeometry,
                          scale: scaleTrue,
                          child: Stack(
                            children: children,
                          ),
                        ),
                      ),
                      tempWidget
                    ],
                  ),
                ),
                locWidget,
              ],
            ),
          );
        },
      ),
    );
  }
}
