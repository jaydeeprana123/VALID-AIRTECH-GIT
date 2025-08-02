import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/edit_allowance_screen.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/View/edit_appointment_screen.dart';
import 'package:valid_airtech/Screens/Attendance/View/add_attendance_out_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/edit_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_filter_dialog.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Notes/Controller/notes_controller.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../AdminLeaveRequest/View/leave_filter_dialog.dart';
import '../../Notes/View/edit_note_screen.dart';
import '../Controller/attendance_controller.dart';

class AttendanceListByDateScreen extends StatefulWidget {
  final String date;

  AttendanceListByDateScreen({
    Key? key,
   
    required this.date,
  }) : super(key: key);
  
  @override
  _AttendanceListByDateScreenState createState() => _AttendanceListByDateScreenState();
}

class _AttendanceListByDateScreenState extends State<AttendanceListByDateScreen> {
  AttendanceController attendanceController = Get.find<AttendanceController>();

  @override
  void initState() {
    super.initState();
    attendanceController.attendanceList.clear();
    _initializeData();
  }

  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    attendanceController.callAttendanceListByDate(widget.date);
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
          'Valid Services',
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
                        'Attendance',
                        style: AppTextStyle.largeBold
                            .copyWith(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  attendanceController.attendanceList.isNotEmpty
                      ? Expanded(
                          child:  ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount:
                            attendanceController.attendanceList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                margin:
                                const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start
                                              ,children: [
                                              Text(
                                                'Date',
                                                style: AppTextStyle.largeMedium
                                                    .copyWith(
                                                    fontSize: 12,
                                                    color: color_brown_title),
                                              ),
                                              Text(
                                                  "${attendanceController
                                                      .attendanceList[index]
                                                      .date ??
                                                      ""} || ${attendanceController
                                                      .attendanceList[index]
                                                      .time ??
                                                      ""}",
                                                style: AppTextStyle.largeRegular
                                                    .copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Column(
                                            children: [
                                              Text(
                                                'Status',
                                                style: AppTextStyle.largeMedium
                                                    .copyWith(
                                                    fontSize: 12,
                                                    color: color_brown_title),
                                              ),
                                              Text(
                                                (attendanceController
                                                    .attendanceList[index]
                                                    .statusType ??
                                                    "")
                                                    .toString(),
                                                style: AppTextStyle.largeRegular
                                                    .copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),


                                      const SizedBox(height: 12),
                                      Text(
                                        (attendanceController
                                            .attendanceList[index]
                                            .officeName ??
                                            "").isNotEmpty?'Office Name':"Site Name",
                                        style: AppTextStyle.largeMedium
                                            .copyWith(
                                            fontSize: 12,
                                            color: color_brown_title),
                                      ),
                                      Text(
                                        (attendanceController
                                            .attendanceList[index]
                                            .officeName ??
                                            "").isNotEmpty?(attendanceController
                                            .attendanceList[index]
                                            .officeName ??
                                            ""):(attendanceController
                                            .attendanceList[index]
                                            .headName ??
                                            ""),
                                        style: AppTextStyle.largeRegular
                                            .copyWith(
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),

                                      const SizedBox(height: 12),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Get.to(WorkReportListScreen(
                                      //         siteId: (attendanceController
                                      //             .attendanceList[index]
                                      //             .headName??"").isNotEmpty?attendanceController
                                      //             .attendanceList[index]
                                      //             .headId.toString():attendanceController
                                      //             .attendanceList[index]
                                      //             .officeId.toString(),
                                      //         attendanceId:
                                      //             attendanceController
                                      //                 .attendanceList[index]
                                      //                 .id
                                      //                 .toString(),
                                      //         date: attendanceController
                                      //                 .attendanceList[index]
                                      //                 .date ??
                                      //             ""));
                                      //   },
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.add_circle),
                                      //       SizedBox(
                                      //         width: 2,
                                      //       ),
                                      //       Text(
                                      //         "Site Report",
                                      //         style: AppTextStyle.largeBold
                                      //             .copyWith(
                                      //                 fontSize: 15,
                                      //                 color: Colors.black),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),



                                      // const SizedBox(height: 12),
                                      // attendanceController
                                      //     .attendanceList[index].status ==
                                      //     1? InkWell(
                                      //   onTap: () {
                                      //     attendanceController
                                      //         .selectedAttendance.value =
                                      //     attendanceController
                                      //         .attendanceList[index];
                                      //     Get.to(AddAttendanceOutScreen(isSite: (attendanceController
                                      //         .attendanceList[index].headName??"").isNotEmpty?true:false,date: attendanceController
                                      //         .attendanceList[index].date??""))
                                      //         ?.then((value) {
                                      //       attendanceController.isLoading.value =
                                      //       false;
                                      //       attendanceController.callAttendanceList();
                                      //     });
                                      //   },
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.add_circle),
                                      //       SizedBox(
                                      //         width: 2,
                                      //       ),
                                      //       Text(
                                      //         "Sign Out",
                                      //         style: AppTextStyle.largeBold
                                      //             .copyWith(
                                      //             fontSize: 15,
                                      //             color: Colors.black),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ):SizedBox()


                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: Text("No data found"),
                        )),
                ],
              ),
              if (attendanceController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          )),
    );
  }
}
