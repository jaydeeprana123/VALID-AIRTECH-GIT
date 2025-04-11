import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/View/emp_add_leave_request_screen.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/View/emp_edit_leave_request_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../Controller/emp_leave_request_controller.dart';

class EmplLeaveRequestListScreen extends StatefulWidget {
  @override
  _EmplLeaveRequestListScreenState createState() =>
      _EmplLeaveRequestListScreenState();
}

class _EmplLeaveRequestListScreenState
    extends State<EmplLeaveRequestListScreen> {
  EmpLeaveRequestController empLeaveRequestController =
      Get.put(EmpLeaveRequestController());

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await empLeaveRequestController.getLoginData();

    printData("_initializeData", "_initializeData");

    empLeaveRequestController.callEmployeeLeaveRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: color_secondary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Valid Airtech',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: color_primary,
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        'Leave Request',
                        style: AppTextStyle.largeBold
                            .copyWith(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color_primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {

                      Get.to(EmpAddLeaveRequestScreen())?.then((value) {
                        empLeaveRequestController.isLoading.value = false;
                        empLeaveRequestController.callEmployeeLeaveRequestList();
                      });

                    },
                    child: Text(
                      '+ Add',
                      style: AppTextStyle.largeBold
                          .copyWith(fontSize: 13, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount:
                          empLeaveRequestController.empLeaveRequestList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            empLeaveRequestController.selectedEmpLeaveRequest.value = empLeaveRequestController.empLeaveRequestList[index];
                            Get.to(EmpEditLeaveRequestScreen())?.then((value) {
                              empLeaveRequestController.isLoading.value = false;
                              empLeaveRequestController.callEmployeeLeaveRequestList();
                            });
                          },
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Leave Request Date',
                                              style: AppTextStyle.largeMedium
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: color_brown_title),
                                            ),
                                            Text(
                                              empLeaveRequestController
                                                      .empLeaveRequestList[
                                                          index]
                                                      .leaveRequestDate ??
                                                  "",
                                              style: AppTextStyle.largeRegular
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Status',
                                            style: AppTextStyle.largeMedium
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: color_brown_title),
                                          ),
                                          Text(
                                            empLeaveRequestController
                                                    .empLeaveRequestList[index]
                                                    .statusType ??
                                                "",
                                            style: AppTextStyle.largeRegular
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: empLeaveRequestController
                                                                .empLeaveRequestList[
                                                                    index]
                                                                .status ==
                                                            0
                                                        ? Colors.yellow.shade900
                                                        : empLeaveRequestController
                                                                    .empLeaveRequestList[
                                                                        index]
                                                                    .status ==
                                                                1
                                                            ? Colors.green
                                                            : Colors.red),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'From Date',
                                    style: AppTextStyle.largeMedium.copyWith(
                                        fontSize: 12, color: color_brown_title),
                                  ),
                                  Text(
                                    empLeaveRequestController
                                            .empLeaveRequestList[index]
                                            .fromDate ??
                                        "",
                                    style: AppTextStyle.largeRegular.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'No Of Leave Days',
                                    style: AppTextStyle.largeMedium.copyWith(
                                        fontSize: 12, color: color_brown_title),
                                  ),
                                  Text(
                                    empLeaveRequestController
                                            .empLeaveRequestList[index]
                                            .numberOfLeaveDays ??
                                        "",
                                    style: AppTextStyle.largeRegular.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (empLeaveRequestController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          )),
    );
  }
}
