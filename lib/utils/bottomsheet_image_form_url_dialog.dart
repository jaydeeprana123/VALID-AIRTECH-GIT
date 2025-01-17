import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../Styles/my_colors.dart';

import '../../../../Styles/my_icons.dart';



class BottomSheetImageForUrlDialog extends StatefulWidget {
  final String imageUrl;

  BottomSheetImageForUrlDialog({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  State<BottomSheetImageForUrlDialog> createState() => _BottomSheetImageForUrlDialogState();
}

class _BottomSheetImageForUrlDialogState extends State<BottomSheetImageForUrlDialog> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: PhotoView(
      //   imageProvider:
      //   Image.network(widget.imageUrl),
      // ),
    );
  }


  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails?.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position!.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }
}
