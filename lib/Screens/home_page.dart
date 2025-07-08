import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valid_airtech/Screens/Appointment/View/appointment_screen.dart';
import 'package:valid_airtech/Screens/Attendance/View/admin_attendance_screen.dart';
import 'package:valid_airtech/Screens/Authentication/View/profile_screen_view.dart';
import 'package:valid_airtech/Screens/CalibrationCertificate/View/calibration_list_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_list_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_screen.dart';
import 'package:valid_airtech/Screens/Master/View/admin_report_screen.dart';
import 'package:valid_airtech/Screens/Planning/View/planning_screen.dart';
import 'package:valid_airtech/Screens/TestPerform/View/test_perform_list_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/helper.dart';
import '../Styles/app_text_style.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_icons.dart';
import 'AdminLeaveRequest/View/admin_leave_request_list_screen.dart';
import 'AdminLeaveRequest/View/select_workman_calender_leave_request_screen.dart';
import 'Allowance/View/admin_expnese_list_screen.dart';
import 'Circular/View/circular_list_screen.dart';
import 'Master/View/master_index_screen.dart';
import 'Notes/View/notes_screen.dart';
import 'WorkReport/View/admin_work_report_list_screen.dart';
import 'WorkReport/View/work_report_attendance_convey_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person_2_outlined, color: color_secondary),
          onPressed: () {
            Get.to(ProfileScreen());
          },
        ),
        title: Text(
          'Profile',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: color_secondary),
            onPressed: () {
              Helper().logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: 52,
                ),
                Expanded(
                  child: Image.asset(
                    iconLogo, // Replace with your logo path
                    height: 80,
                  ),
                ),
                Icon(Icons.calendar_month, color: color_secondary, size: 36),
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.6, // Adjust aspect ratio for rectangle shape
              children: [

                InkWell(
                    onTap: () {
                      Get.to(AppointmentScreen());
                    },
                    child: _buildGridItem('Appointment', Icons.event_note)),
                InkWell(
                    onTap: () {
                      Get.to(PlanningScreen());
                    },
                    child: _buildGridItem('Planning', Icons.schedule)),
                // InkWell(
                //     onTap: () {
                //       Get.to(AdminWorkReportListScreen(empId: empId));
                //     },
                //     child: _buildGridItem(
                //         'Work Report', Icons.work_history_outlined)),
                InkWell(
                    onTap: () {
                      Get.to(CalibrationListScreen());
                    },
                    child: _buildGridItem(
                        'Calibration Certificates', Icons.compass_calibration)),
                InkWell(
                    onTap: () {
                      Get.to(HomeAllowanceScreen());
                    },
                    child: _buildGridItem(
                        'Allowance', Icons.monetization_on_sharp)),
                InkWell(
                    onTap: () {
                      Get.to(SelectWorkmanLeaveRequestScreen());
                    },
                    child: _buildGridItem(
                        'Leave Request', Icons.note_add_outlined)),
                InkWell(
                    onTap: () {
                      Get.to(NotesScreen());
                    },
                    child: _buildGridItem('Note', Icons.note_alt)),
                InkWell(
                    onTap: () {
                      Get.to(CircularListScreen());
                    },
                    child: _buildGridItem('Circular', Icons.newspaper)),
                _buildGridItem('Query', Icons.contact_support),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Get.to(MasterIndexScreen());
                        },
                        child: _buildFooterButton('Master /\nIndex'))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Get.to(AdminReportScreen());
                          printData("AdminExpenseListScreen",
                              "AdminExpenseListScreen");
                        },
                        child: _buildFooterButton('Admin\nReport'))),
                Expanded(
                    child: InkWell(
                        onTap: () {},
                        child: _buildFooterButton('Workman\nRecord'))),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: color_primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color_secondary, size: 26),
          SizedBox(height: 2),
          Text(
            title,
            style: AppTextStyle.largeBold
                .copyWith(fontSize: 14, color: color_secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(String title) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade600,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
