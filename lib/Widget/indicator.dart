import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Styles/my_colors.dart';

class Indicator extends StatelessWidget {
  Indicator({
    required this.controller,
    this.itemCount = 0,
  }) : assert(controller != null);

  /// PageView Controller
  final PageController controller;

  /// Number of indicators
  final int itemCount;
  
  /// Ordinary colours
  final Color normalColor = Color(0x50199a8e);

  /// Selected color
  final Color selectedColor = Colors.red;

  /// Size of points
  final double size = 6.0;

  /// Spacing of points
  final double spacing = 4.0;

  /// Point Widget
  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    // Is the current page selected?
    bool isCurrentPageSelected = index ==
        (controller.page != null ? controller.page!.round() % pageCount : 0);

    return SizedBox(
      height: size,
      width: size + (3 * spacing),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: isCurrentPageSelected ? selectedColor : normalColor,
          type: MaterialType.canvas,
          child: SizedBox(
            width: isCurrentPageSelected?13:dotSize,
            height: dotSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}
