import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'network_controller.dart';

Future<bool> checkNet(BuildContext context) async {
  final liveInternet = Get.put(NetworkController(),permanent: true);
  return !liveInternet.checkConnectivityResult.value;
}
