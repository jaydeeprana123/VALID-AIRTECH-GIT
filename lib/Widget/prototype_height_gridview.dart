import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';

class PrototypeHeightGridView extends StatelessWidget {
  final Widget prototype;
  final GridView listView;

  const PrototypeHeightGridView({
    Key? key,
    required this.prototype,
    required this.listView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0.0,
            child: prototype,
          ),
        ),
        const SizedBox(width: double.infinity),
        Positioned.fill(child: listView),
      ],
    );
  }
}


