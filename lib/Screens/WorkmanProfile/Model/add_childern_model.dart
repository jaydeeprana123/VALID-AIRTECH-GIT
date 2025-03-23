// To parse this JSON data, do
//
//     final addSiteRequest = addSiteRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AddChildrenModel {
  String? id;

  TextEditingController textEditingControllerName = TextEditingController();

  AddChildrenModel({
    this.id,
  });


}
