// To parse this JSON data, do
//
//     final addSiteRequest = addSiteRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AddContactModel {
  String? type;
  String? number;
  TextEditingController textEditingControllerNum = TextEditingController();

  AddContactModel({
    this.type,
    this.number
  });


}
