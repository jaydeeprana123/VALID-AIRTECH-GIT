import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/Controller/admin_leave_request_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Head/Model/head_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Model/create_instrument_request.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Service/Model/create_service_request.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Sites/Model/add_contact_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveFilterDialog extends StatefulWidget {
  @override
  _LeaveFilterDialogState createState() => _LeaveFilterDialogState();
}

class _LeaveFilterDialogState extends State<LeaveFilterDialog> {
  final AdminLeaveRequestController controller = Get.find<AdminLeaveRequestController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => controller.callWorkmanList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Leave Request Filter",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          buildDropdown("Select Month-Year", controller.monthYearOptions, controller.selectedMonthYear),
          buildDropdownWorkman("Select Workman Name", controller.workmanList, controller.selectedWorkman),
          buildDropdown("Select Status", controller.statusOptions, controller.selectedStatus),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar("Filters Applied",
                "Month: ${controller.selectedMonthYear}, Workman: ${controller.selectedWorkman}, Status: ${controller.selectedStatus}",
                snackPosition: SnackPosition.BOTTOM,
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, RxString selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        Obx(() => DropdownButton<String>(
          value: selectedValue.value,
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              selectedValue.value = newValue!;
            });
          },
          items: items.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildDropdownWorkman(String label, List<WorkmanData> items, RxString selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        Obx(() => DropdownButton<String>(
          value: selectedValue.value,
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              selectedValue.value = newValue!;
            });
          },
          items: items.map((value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(value.name??""),
            );
          }).toList(),
        )),
        SizedBox(height: 10),
      ],
    );
  }}