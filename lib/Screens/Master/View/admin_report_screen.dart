import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Attendance/View/admin_attendance_list_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Conveyance/View/admin_conveyance_list_screen.dart';
import 'package:valid_airtech/Screens/Head/Model/head_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/View/admin_work_report_list_screen.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import 'package:valid_airtech/Screens/attendance_screen.dart';

import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Allowance/View/admin_expnese_list_screen.dart';
import '../../Attendance/View/attendance_list_for_admin_report_screen.dart';
import '../../Attendance/View/site_attendance_list_for_admin_screen.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../../WorkmanProfile/Controller/workman_profile_controller.dart';

class AdminReportScreen extends StatefulWidget {
  @override
  _AdminReportScreenState createState() => _AdminReportScreenState();
}

class _AdminReportScreenState extends State<AdminReportScreen> {
  WorkmanProfileController workmanProfileController = Get.put(
      WorkmanProfileController());
  String? selectedWorkmanId;
  String? selectedWorkmanIdForConveyance;
  String? selectedWorkmanIdForExpense;
  String? selectedWorkmanIdForWorkReport;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Perform navigation or state updates after build completes

      await workmanProfileController.getLoginData();

      workmanProfileController.callWorkmanListForAdmin();
    });
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
          "Admin's Report",
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() =>
          Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                    ),


                    _buildSectionTitle("Attendance By Admin"),

                    SizedBox(
                      height: 4,
                    ),

                    _buildDropdown(
                        workmanProfileController.workmanList, selectedWorkmanId,
                            (val) => setState(() => selectedWorkmanId = val),
                        "Select Workman Name"),

                    SizedBox(
                      height: 16,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Find",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          String? empName = "";
                          if(selectedWorkmanId != null || selectedWorkmanId != "0"){
                            empName = getUserNameById(int.parse(selectedWorkmanId??"0"), workmanProfileController.workmanList);
                          }

                          Get.to(AttendanceListForAdminReportScreen(empId: (selectedWorkmanId == null ||
                              selectedWorkmanId == "0")
                              ? ""
                              : selectedWorkmanId ?? "",empName: empName??"",),);
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),


                    SizedBox(
                      height: 24,
                    ),


                    _buildSectionTitle("Conveyance"),

                    SizedBox(
                      height: 4,
                    ),

                    _buildDropdown(workmanProfileController.workmanList,
                        selectedWorkmanIdForConveyance,
                            (val) => setState(() =>
                        selectedWorkmanIdForConveyance = val),
                        "Select Workman Name"),

                    SizedBox(
                      height: 16,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Find",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          Get.to(AdminConveyanceListScreen(
                            empId: (selectedWorkmanIdForConveyance == null ||
                                selectedWorkmanIdForConveyance == "0")
                                ? ""
                                : selectedWorkmanIdForConveyance ?? "",));
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),


                    SizedBox(
                      height: 24,
                    ),


                    _buildSectionTitle("Expense"),

                    SizedBox(
                      height: 4,
                    ),

                    _buildDropdown(workmanProfileController.workmanList,
                        selectedWorkmanIdForExpense,
                            (val) =>
                            setState(() => selectedWorkmanIdForExpense = val),
                        "Select Workman Name"),

                    SizedBox(
                      height: 16,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Find",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          Get.to(AdminExpenseListScreen(
                            empId: (selectedWorkmanIdForExpense == null ||
                                selectedWorkmanIdForExpense == "0")
                                ? ""
                                : selectedWorkmanIdForExpense ?? "",));
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),


                    SizedBox(
                      height: 24,
                    ),


                    _buildSectionTitle("Work Report"),

                    SizedBox(
                      height: 4,
                    ),

                    _buildDropdown(workmanProfileController.workmanList,
                        selectedWorkmanIdForWorkReport,
                            (val) => setState(() =>
                        selectedWorkmanIdForWorkReport = val),
                        "Select Workman Name"),

                    SizedBox(
                      height: 16,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Find",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          Get.to(AdminWorkReportListScreen(
                            empId: (selectedWorkmanIdForWorkReport == null ||
                                selectedWorkmanIdForWorkReport == "0")
                                ? ""
                                : selectedWorkmanIdForWorkReport ?? "",));
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),


                  ],
                ),
              ),

              if(workmanProfileController.isLoading.value)Center(
                child: CircularProgressIndicator(),)
            ],
          )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
      AppTextStyle.largeBold.copyWith(fontSize: 20, color: color_hint_text),
    );
  }


  Widget _buildDropdownString(List<String> items, String? selectedValue,
      Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10),
        alignLabelWithHint: true,

        labelText: hint,
        // Moves up as a floating label when a value is selected
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when selecting
        hintText: hint,
        // Hint text
        hintStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        labelStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Bottom-only border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Bottom border on focus
        ),
      ),
      value: selectedValue,
      isExpanded: true,
      // Ensures dropdown takes full width
      items:
      items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
    ;
  }


  String? getUserNameById(int id, List<WorkmanData> items) {
    try {
      return items.firstWhere((item) => item.id == id).name;
    } catch (e) {
      return null; // Return null if not found
    }
  }

  Widget _buildDropdown(List<WorkmanData> items, String? selectedValue,
      Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10),
        alignLabelWithHint: true,

        labelText: hint,
        // Moves up as a floating label when a value is selected
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when selecting
        hintText: hint,
        // Hint text
        hintStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        labelStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Bottom-only border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Bottom border on focus
        ),
      ),
      value: selectedValue,
      isExpanded: true,
      // Ensures dropdown takes full width
      items:
      items.map((e) =>
          DropdownMenuItem(value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildTimePicker(String title, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (time != null) // Show label only when time is selected
            Text(
              title, // Floating label text
              style: TextStyle(
                fontSize: 12,
                color: color_hint_text, // Floating label color
              ),
            ),
          Container(
            padding: EdgeInsets.only(bottom: 4, right: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey), // Bottom-only border
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time == null ? title : time.format(context),
                  style: AppTextStyle.largeRegular.copyWith(
                    fontSize: 15,
                    color: time == null ? color_hint_text : Colors.black,
                  ),
                ),
                Icon(Icons.timer_outlined, color: Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0),
        alignLabelWithHint: true,
        labelText: hint,
        // Display hint as title when typing
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when typing
        border: UnderlineInputBorder(),
        hintStyle: AppTextStyle.largeRegular
            .copyWith(fontSize: 16, color: color_hint_text),

        labelStyle: AppTextStyle.largeRegular
            .copyWith(fontSize: 16, color: color_hint_text),

      ),
    );
  }


}
