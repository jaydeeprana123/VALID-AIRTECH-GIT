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
import '../../../Enums/select_date_enum.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../utils/helper.dart';
import '../../AdminLeaveRequest/View/leave_filter_dialog.dart';
import '../../Notes/View/edit_note_screen.dart';
import '../Controller/attendance_controller.dart';

class AttendanceListForAdminReportScreen extends StatefulWidget {

  final String empId;
  final String empName;
  AttendanceListForAdminReportScreen({
    Key? key,
    required this.empId,
    required this.empName,
  }) : super(key: key);

  @override
  _AttendanceListForAdminReportScreenState createState() => _AttendanceListForAdminReportScreenState();
}

class _AttendanceListForAdminReportScreenState extends State<AttendanceListForAdminReportScreen> {
  AttendanceController attendanceController = Get.put(AttendanceController());

  @override
  void initState() {
    super.initState();
    attendanceController.finalFilterAttendanceData.clear();
    _initializeData();
  }

  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "AttendanceListForAdminReportScreen");

    attendanceController.callAttendanceListForAdmin(widget.empId);
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
                        "${widget.empName}'s Attendance",
                        style: AppTextStyle.largeBold
                            .copyWith(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await Helper()
                                  .selectDateInYYYYMMDD(
                                  context, SelectDateEnum.all.outputVal);

                              setState(() {
                                attendanceController.fromDateEditingController.value.text =
                                    getDateFormatDDMMYYYYOnly((dateTime ?? DateTime(2023))
                                    );
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  )),
                              child: Text(attendanceController
                                  .fromDateEditingController.value.text.isNotEmpty
                                  ? attendanceController
                                  .fromDateEditingController.value.text
                                  : "From",
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await Helper()
                                  .selectDateInYYYYMMDD(
                                  context, SelectDateEnum.all.outputVal);

                              setState(() {
                                attendanceController
                                    .toDateEditingController.value.text =
                                    getDateFormatDDMMYYYYOnly((dateTime ?? DateTime(2023))
                                    );
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  )),
                              child: Text(attendanceController
                                  .toDateEditingController.value.text.isNotEmpty
                                  ? attendanceController
                                  .toDateEditingController.value.text
                                  : "To",
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            attendanceController.finalFilterAttendanceData.value =  attendanceController
                                .generateAttendanceWithAllDates(existingData: attendanceController.filterAttendanceData, fromDateStr: attendanceController.fromDateEditingController.value.text,
                            toDateStr: attendanceController.toDateEditingController.value.text);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 4, bottom: 4),
                            margin: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: color_primary,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey,
                                )),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

        attendanceController.finalFilterAttendanceData.isNotEmpty? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                    
                          SizedBox(height: 16,),
                    
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: List.generate(
                                attendanceController.finalFilterAttendanceData.length,
                                    (index) {
                                  final data = attendanceController.finalFilterAttendanceData[index];
                    
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Table(
                                      border: TableBorder.all(color: Colors.grey.shade300),
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FixedColumnWidth(100),
                                        1: FixedColumnWidth(100),
                                        2: FixedColumnWidth(100),
                                        3: FixedColumnWidth(100),
                                        4: FixedColumnWidth(100),
                                        5: FixedColumnWidth(130),
                                        6: FixedColumnWidth(130),
                                        7: FixedColumnWidth(130),
                                      },
                                      children: [
                    
                                        if(index == 0)TableRow(
                                          decoration: BoxDecoration(color: Colors.grey.shade200),
                                          children: [
                                            tableHeader('Date'),
                                            tableHeader('Office In'),
                                            tableHeader('Office Out'),
                                            tableHeader('Office Duration'),
                                            tableHeader('Site In'),
                                            tableHeader('Site Out'),

                                            tableHeader('Site Duration'),
                                            tableHeader('Attendance Status'),
                                          ],
                                        ),
                    
                                        TableRow(
                                          children: [
                                            tableCell(data.date ?? ''),
                                            tableCell(data.overallOfficeInTime ?? ''),
                                            tableCell(data.overallOfficeOutTime ?? ''),
                                            tableCell(data.officeDuration ?? ''),
                                            tableCell(data.overallSiteInTime ?? ''),
                                            tableCell(data.overallSiteOutTime ?? ''),

                                            tableCell(data.siteDuration ?? ''),
                                            tableCell(data.attendanceStatus ?? ''),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    
                    
                          // attendanceController.finalFilterAttendanceData.isNotEmpty
                          //     ? Expanded(
                          //         child: ListView.builder(
                          //           padding: const EdgeInsets.all(10),
                          //           itemCount: attendanceController.finalFilterAttendanceData.length,
                          //           itemBuilder: (context, index) {
                          //             final data = attendanceController.finalFilterAttendanceData[index];
                          //
                          //             return Card(
                          //               elevation: 2,
                          //               margin: const EdgeInsets.symmetric(vertical: 8),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(12),
                          //                 child: Table(
                          //                   border: TableBorder.all(color: Colors.grey.shade300),
                          //                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          //                   columnWidths: const {
                          //                     0: FixedColumnWidth(100),
                          //                     1: FixedColumnWidth(100),
                          //                     2: FixedColumnWidth(100),
                          //                     3: FixedColumnWidth(100),
                          //                     4: FixedColumnWidth(100),
                          //                     5: FixedColumnWidth(130),
                          //                     6: FixedColumnWidth(130),
                          //                   },
                          //                   children: [
                          //                     TableRow(
                          //                       decoration: BoxDecoration(color: Colors.grey.shade200),
                          //                       children: [
                          //                         tableHeader('Date'),
                          //                         tableHeader('Office In'),
                          //                         tableHeader('Office Out'),
                          //                         tableHeader('Site In'),
                          //                         tableHeader('Site Out'),
                          //                         tableHeader('Office Duration'),
                          //                         tableHeader('Site Duration'),
                          //                       ],
                          //                     ),
                          //                     TableRow(
                          //                       children: [
                          //                         tableCell(data.date ?? ''),
                          //                         tableCell(data.overallOfficeInTime ?? ''),
                          //                         tableCell(data.overallOfficeOutTime ?? ''),
                          //                         tableCell(data.overallSiteInTime ?? ''),
                          //                         tableCell(data.overallSiteOutTime ?? ''),
                          //                         tableCell(data.officeDuration ?? ''),
                          //                         tableCell(data.siteDuration ?? ''),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             );
                          //           },
                          //         )
                          //
                          //
                          //
                          //   // ListView.builder(
                          //         //   padding: const EdgeInsets.all(10),
                          //         //   itemCount:
                          //         //   attendanceController.attendanceList.length,
                          //         //   itemBuilder: (context, index) {
                          //         //     return Card(
                          //         //       elevation: 2,
                          //         //       margin:
                          //         //       const EdgeInsets.symmetric(vertical: 8),
                          //         //       child: Padding(
                          //         //         padding: const EdgeInsets.all(12),
                          //         //         child: Column(
                          //         //           crossAxisAlignment:
                          //         //           CrossAxisAlignment.start,
                          //         //           children: [
                          //         //             Row(
                          //         //               mainAxisAlignment: MainAxisAlignment.start,
                          //         //               children: [
                          //         //                 Expanded(
                          //         //                   child: Column(
                          //         //                     crossAxisAlignment: CrossAxisAlignment.start
                          //         //                     ,children: [
                          //         //                     Text(
                          //         //                       'Date',
                          //         //                       style: AppTextStyle.largeMedium
                          //         //                           .copyWith(
                          //         //                           fontSize: 12,
                          //         //                           color: color_brown_title),
                          //         //                     ),
                          //         //                     Text(
                          //         //                       "${attendanceController
                          //         //                           .attendanceList[index]
                          //         //                           .date ??
                          //         //                           ""} || ${attendanceController
                          //         //                           .attendanceList[index]
                          //         //                           .time ??
                          //         //                           ""}",
                          //         //                       style: AppTextStyle.largeRegular
                          //         //                           .copyWith(
                          //         //                           fontSize: 15,
                          //         //                           color: Colors.black),
                          //         //                     ),
                          //         //                   ],
                          //         //                   ),
                          //         //                 ),
                          //         //                 const SizedBox(height: 12),
                          //         //                 Column(
                          //         //                   children: [
                          //         //                     Text(
                          //         //                       'Status',
                          //         //                       style: AppTextStyle.largeMedium
                          //         //                           .copyWith(
                          //         //                           fontSize: 12,
                          //         //                           color: color_brown_title),
                          //         //                     ),
                          //         //                     Text(
                          //         //                       (attendanceController
                          //         //                           .attendanceList[index]
                          //         //                           .statusType ??
                          //         //                           "")
                          //         //                           .toString(),
                          //         //                       style: AppTextStyle.largeRegular
                          //         //                           .copyWith(
                          //         //                           fontSize: 15,
                          //         //                           color: Colors.black),
                          //         //                     ),
                          //         //                   ],
                          //         //                 ),
                          //         //               ],
                          //         //             ),
                          //         //
                          //         //
                          //         //             const SizedBox(height: 12),
                          //         //             Text(
                          //         //               (attendanceController
                          //         //                   .attendanceList[index]
                          //         //                   .officeName ??
                          //         //                   "").isNotEmpty?'Office Name':"Site Name",
                          //         //               style: AppTextStyle.largeMedium
                          //         //                   .copyWith(
                          //         //                   fontSize: 12,
                          //         //                   color: color_brown_title),
                          //         //             ),
                          //         //             Text(
                          //         //               (attendanceController
                          //         //                   .attendanceList[index]
                          //         //                   .officeName ??
                          //         //                   "").isNotEmpty?(attendanceController
                          //         //                   .attendanceList[index]
                          //         //                   .officeName ??
                          //         //                   ""):(attendanceController
                          //         //                   .attendanceList[index]
                          //         //                   .headName ??
                          //         //                   ""),
                          //         //               style: AppTextStyle.largeRegular
                          //         //                   .copyWith(
                          //         //                   fontSize: 15,
                          //         //                   color: Colors.black),
                          //         //             ),
                          //         //
                          //         //             const SizedBox(height: 12),
                          //         //             // InkWell(
                          //         //             //   onTap: () {
                          //         //             //     Get.to(WorkReportListScreen(
                          //         //             //         siteId: (attendanceController
                          //         //             //             .attendanceList[index]
                          //         //             //             .headName??"").isNotEmpty?attendanceController
                          //         //             //             .attendanceList[index]
                          //         //             //             .headId.toString():attendanceController
                          //         //             //             .attendanceList[index]
                          //         //             //             .officeId.toString(),
                          //         //             //         attendanceId:
                          //         //             //             attendanceController
                          //         //             //                 .attendanceList[index]
                          //         //             //                 .id
                          //         //             //                 .toString(),
                          //         //             //         date: attendanceController
                          //         //             //                 .attendanceList[index]
                          //         //             //                 .date ??
                          //         //             //             ""));
                          //         //             //   },
                          //         //             //   child: Row(
                          //         //             //     children: [
                          //         //             //       Icon(Icons.add_circle),
                          //         //             //       SizedBox(
                          //         //             //         width: 2,
                          //         //             //       ),
                          //         //             //       Text(
                          //         //             //         "Site Report",
                          //         //             //         style: AppTextStyle.largeBold
                          //         //             //             .copyWith(
                          //         //             //                 fontSize: 15,
                          //         //             //                 color: Colors.black),
                          //         //             //       ),
                          //         //             //     ],
                          //         //             //   ),
                          //         //             // ),
                          //         //
                          //         //
                          //         //
                          //         //             // const SizedBox(height: 12),
                          //         //             // attendanceController
                          //         //             //     .attendanceList[index].status ==
                          //         //             //     1? InkWell(
                          //         //             //   onTap: () {
                          //         //             //     attendanceController
                          //         //             //         .selectedAttendance.value =
                          //         //             //     attendanceController
                          //         //             //         .attendanceList[index];
                          //         //             //     Get.to(AddAttendanceOutScreen(isSite: (attendanceController
                          //         //             //         .attendanceList[index].headName??"").isNotEmpty?true:false,date: attendanceController
                          //         //             //         .attendanceList[index].date??""))
                          //         //             //         ?.then((value) {
                          //         //             //       attendanceController.isLoading.value =
                          //         //             //       false;
                          //         //             //       attendanceController.callAttendanceList();
                          //         //             //     });
                          //         //             //   },
                          //         //             //   child: Row(
                          //         //             //     children: [
                          //         //             //       Icon(Icons.add_circle),
                          //         //             //       SizedBox(
                          //         //             //         width: 2,
                          //         //             //       ),
                          //         //             //       Text(
                          //         //             //         "Sign Out",
                          //         //             //         style: AppTextStyle.largeBold
                          //         //             //             .copyWith(
                          //         //             //             fontSize: 15,
                          //         //             //             color: Colors.black),
                          //         //             //       ),
                          //         //             //     ],
                          //         //             //   ),
                          //         //             // ):SizedBox()
                          //         //
                          //         //
                          //         //           ],
                          //         //         ),
                          //         //       ),
                          //         //     );
                          //         //   },
                          //         // ),
                          //         )
                          //     : Expanded(
                          //         child: Center(
                          //         child: Text("No data found"),
                          //       )),
                        ],
                      ),
                    ),
                  ):Expanded(
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


  Widget tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Text(
        text,
        style: AppTextStyle.mediumRegular.copyWith(fontSize: 16
    , color:  Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
      child: Text(
        text,
        style: AppTextStyle.mediumRegular.copyWith(fontSize: 14
          , color:  text == "A"?Colors.red:text == "P"?Colors.green:Colors.black54),

        textAlign: TextAlign.center,

      ),
    );
  }

}
