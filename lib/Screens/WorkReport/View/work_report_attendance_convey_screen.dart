import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Attendance/View/admin_attendance_list_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/View/admin_conveyance_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../Attendance/View/admin_attendance_screen.dart';
import '../Controller/work_report_controller.dart';
import 'add_work_report_screen.dart';


class WorkReportAttendanceConveyScreen extends StatefulWidget {
  @override
  _WorkReportAttendanceConveyScreenState createState() => _WorkReportAttendanceConveyScreenState();
}

class _WorkReportAttendanceConveyScreenState extends State<WorkReportAttendanceConveyScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  WorkReportController workReportController = Get.put(WorkReportController());

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
          style: AppTextStyle.largeBold.copyWith(fontSize: 18
            , color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'Work Report',
                  style: AppTextStyle.largeBold.copyWith(fontSize: 16
                      , color: Colors.white),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(onTap: (){
                    Get.to(AdminAttendanceScreen());
                  },child: _buildGridItem("Attendance", Icons.event_available)),

                  SizedBox(height: 20,),

                  InkWell(onTap: (){
                    Get.to(AdminConveyanceScreen());
                  },
                  child:  _buildGridItem("Conveyance", Icons.conveyor_belt),)

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGridItem(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.all(30),
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
            style: AppTextStyle.largeBold.copyWith(fontSize: 14
                , color: color_secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
