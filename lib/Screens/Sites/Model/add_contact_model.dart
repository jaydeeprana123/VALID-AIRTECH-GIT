// To parse this JSON data, do
//
//     final addSiteRequest = addSiteRequestFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AddContactModel {
  String? id;
  String? type;
  String? number;
  TextEditingController textEditingControllerNum = TextEditingController();

  AddContactModel({
    this.id,
    this.type,
    this.number
  });


}
