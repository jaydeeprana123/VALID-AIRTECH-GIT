import 'dart:developer';

import 'package:intl/intl.dart';
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
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import 'package:valid_airtech/Widget/CommonButton.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../AdminLeaveRequest/View/leave_filter_dialog.dart';
import '../../Notes/View/edit_note_screen.dart';
import '../../Sites/Model/site_list_response.dart';
import '../Controller/attendance_controller.dart';

class SiteAttendanceListScreen extends StatefulWidget {

  final String startDate;
  final String endDate;

  SiteAttendanceListScreen({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);


  @override
  _SiteAttendanceListScreenState createState() =>
      _SiteAttendanceListScreenState();
}

class _SiteAttendanceListScreenState
    extends State<SiteAttendanceListScreen> {
  AttendanceController attendanceController = Get.find<AttendanceController>();
  WorkReportController workReportController = Get.find<WorkReportController>();
  String? selectedSite;
  @override
  void initState() {
    super.initState();
    attendanceController.attendanceList.clear();
    attendanceController.filterSiteAttendanceData.clear();
    attendanceController.filterSiteAttendanceData.clear();
    _initializeData();
  }

  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    attendanceController.callAttendanceList(workReportController.workReportListByDates);
    attendanceController.callSiteList();
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


          IconButton(
            icon: Icon(Icons.filter_alt_sharp, color: color_secondary),
            onPressed: () {

              List<SiteData> modifiedSiteList = [
                SiteData(id: 0, headName: "All"),
                ...attendanceController.siteList,
              ];

              _showSiteSelectionDialog(
                context,
                modifiedSiteList,
                selectedSite,
                    (val) {
                  setState(() {
                    selectedSite = val;
                    attendanceController.filterAttendanceListBySite(selectedSite ?? "0");
                  });
                },
                'Select Site',
              );

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
                        'Site Report',
                        style: AppTextStyle.largeBold
                            .copyWith(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  attendanceController.filterSiteAttendanceData.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount:
                              attendanceController.filterSiteAttendanceData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Site Date & Day',
                                                    style: AppTextStyle.largeMedium
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: color_brown_title),
                                                  ),
                                                  Text(

                                                    getDateWithDay( attendanceController
                                                        .filterSiteAttendanceData[index]
                                                        .dateOfAttendance ??
                                                        ""),

                                                    style: AppTextStyle.largeRegular
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            if(attendanceController
                                                .filterSiteAttendanceData[index].headId != null)  Container(
                                              width: 120,
                                              height: 40,
                                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                              child: CommonButton(
                                                titleText: attendanceController
                                                    .filterSiteAttendanceData[index].isWorkReportAvail?"View":"+ Add",
                                                textColor: Colors.white,
                                                onCustomButtonPressed: () async {

                                                  await workReportController.getLoginData();

                                                  if (attendanceController
                                                      .filterSiteAttendanceData[index]
                                                      .headId !=
                                                      null) {
                                                    workReportController.callWorkReportList(
                                                        attendanceController
                                                            .filterSiteAttendanceData[
                                                        index]
                                                            .headId
                                                            .toString(),
                                                        attendanceController
                                                            .filterSiteAttendanceData[
                                                        index]
                                                            .dateOfAttendance ??
                                                            "", widget.startDate, widget.endDate,attendanceController
                                                        .filterSiteAttendanceData[
                                                    index]
                                                        .siteName??"");
                                                  }else{
                                                    workReportController.callWorkReportList(
                                                        attendanceController
                                                            .filterSiteAttendanceData[
                                                        index]
                                                            .officeId
                                                            .toString(),
                                                        attendanceController
                                                            .filterSiteAttendanceData[
                                                        index]
                                                            .dateOfAttendance ??
                                                            "", widget.startDate, widget.endDate,attendanceController
                                                        .filterSiteAttendanceData[
                                                    index]
                                                        .siteName??"");
                                                  }
                                                },
                                                borderColor: color_primary,
                                                borderWidth: 0,
                                              ),
                                            ),


                                          ],
                                        ),



                                        Text(
                                          'Site Name',
                                          style: AppTextStyle.largeMedium
                                              .copyWith(
                                              fontSize: 12,
                                              color: color_brown_title),
                                        ),

                                        Text(
                                          attendanceController
                                                  .filterSiteAttendanceData[index]
                                                  .siteName ??
                                              "",
                                          style: AppTextStyle.largeSemiBold
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Site In Time : ',
                                                    style: AppTextStyle
                                                        .largeMedium
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                color_brown_title),
                                                  ),
                                                  Text(
                                                    attendanceController
                                                            .filterSiteAttendanceData[
                                                                index]
                                                            .inTime ??
                                                        "",
                                                    style: AppTextStyle
                                                        .largeRegular
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Site Out Time : ',
                                                    style: AppTextStyle
                                                        .largeMedium
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                color_brown_title),
                                                  ),
                                                  Text(
                                                    attendanceController
                                                            .filterSiteAttendanceData[
                                                                index]
                                                            .outTime ??
                                                        "",
                                                    style: AppTextStyle
                                                        .largeRegular
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 12,
                                    ),

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
                        )

                          // ListView.builder(
                          //   padding: const EdgeInsets.all(10),
                          //   itemCount:
                          //   attendanceController.attendanceList.length,
                          //   itemBuilder: (context, index) {
                          //     return Card(
                          //       elevation: 2,
                          //       margin:
                          //       const EdgeInsets.symmetric(vertical: 8),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(12),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //           CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               mainAxisAlignment: MainAxisAlignment.start,
                          //               children: [
                          //                 Expanded(
                          //                   child: Column(
                          //                     crossAxisAlignment: CrossAxisAlignment.start
                          //                     ,children: [
                          //                     Text(
                          //                       'Date',
                          //                       style: AppTextStyle.largeMedium
                          //                           .copyWith(
                          //                           fontSize: 12,
                          //                           color: color_brown_title),
                          //                     ),
                          //                     Text(
                          //                       "${attendanceController
                          //                           .attendanceList[index]
                          //                           .date ??
                          //                           ""} || ${attendanceController
                          //                           .attendanceList[index]
                          //                           .time ??
                          //                           ""}",
                          //                       style: AppTextStyle.largeRegular
                          //                           .copyWith(
                          //                           fontSize: 15,
                          //                           color: Colors.black),
                          //                     ),
                          //                   ],
                          //                   ),
                          //                 ),
                          //                 const SizedBox(height: 12),
                          //                 Column(
                          //                   children: [
                          //                     Text(
                          //                       'Status',
                          //                       style: AppTextStyle.largeMedium
                          //                           .copyWith(
                          //                           fontSize: 12,
                          //                           color: color_brown_title),
                          //                     ),
                          //                     Text(
                          //                       (attendanceController
                          //                           .attendanceList[index]
                          //                           .statusType ??
                          //                           "")
                          //                           .toString(),
                          //                       style: AppTextStyle.largeRegular
                          //                           .copyWith(
                          //                           fontSize: 15,
                          //                           color: Colors.black),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //
                          //
                          //             const SizedBox(height: 12),
                          //             Text(
                          //               (attendanceController
                          //                   .attendanceList[index]
                          //                   .officeName ??
                          //                   "").isNotEmpty?'Office Name':"Site Name",
                          //               style: AppTextStyle.largeMedium
                          //                   .copyWith(
                          //                   fontSize: 12,
                          //                   color: color_brown_title),
                          //             ),
                          //             Text(
                          //               (attendanceController
                          //                   .attendanceList[index]
                          //                   .officeName ??
                          //                   "").isNotEmpty?(attendanceController
                          //                   .attendanceList[index]
                          //                   .officeName ??
                          //                   ""):(attendanceController
                          //                   .attendanceList[index]
                          //                   .headName ??
                          //                   ""),
                          //               style: AppTextStyle.largeRegular
                          //                   .copyWith(
                          //                   fontSize: 15,
                          //                   color: Colors.black),
                          //             ),
                          //
                          //             const SizedBox(height: 12),
                          //             // InkWell(
                          //             //   onTap: () {
                          //             //     Get.to(WorkReportListScreen(
                          //             //         siteId: (attendanceController
                          //             //             .attendanceList[index]
                          //             //             .headName??"").isNotEmpty?attendanceController
                          //             //             .attendanceList[index]
                          //             //             .headId.toString():attendanceController
                          //             //             .attendanceList[index]
                          //             //             .officeId.toString(),
                          //             //         attendanceId:
                          //             //             attendanceController
                          //             //                 .attendanceList[index]
                          //             //                 .id
                          //             //                 .toString(),
                          //             //         date: attendanceController
                          //             //                 .attendanceList[index]
                          //             //                 .date ??
                          //             //             ""));
                          //             //   },
                          //             //   child: Row(
                          //             //     children: [
                          //             //       Icon(Icons.add_circle),
                          //             //       SizedBox(
                          //             //         width: 2,
                          //             //       ),
                          //             //       Text(
                          //             //         "Site Report",
                          //             //         style: AppTextStyle.largeBold
                          //             //             .copyWith(
                          //             //                 fontSize: 15,
                          //             //                 color: Colors.black),
                          //             //       ),
                          //             //     ],
                          //             //   ),
                          //             // ),
                          //
                          //
                          //
                          //             // const SizedBox(height: 12),
                          //             // attendanceController
                          //             //     .attendanceList[index].status ==
                          //             //     1? InkWell(
                          //             //   onTap: () {
                          //             //     attendanceController
                          //             //         .selectedAttendance.value =
                          //             //     attendanceController
                          //             //         .attendanceList[index];
                          //             //     Get.to(AddAttendanceOutScreen(isSite: (attendanceController
                          //             //         .attendanceList[index].headName??"").isNotEmpty?true:false,date: attendanceController
                          //             //         .attendanceList[index].date??""))
                          //             //         ?.then((value) {
                          //             //       attendanceController.isLoading.value =
                          //             //       false;
                          //             //       attendanceController.callAttendanceList();
                          //             //     });
                          //             //   },
                          //             //   child: Row(
                          //             //     children: [
                          //             //       Icon(Icons.add_circle),
                          //             //       SizedBox(
                          //             //         width: 2,
                          //             //       ),
                          //             //       Text(
                          //             //         "Sign Out",
                          //             //         style: AppTextStyle.largeBold
                          //             //             .copyWith(
                          //             //             fontSize: 15,
                          //             //             color: Colors.black),
                          //             //       ),
                          //             //     ],
                          //             //   ),
                          //             // ):SizedBox()
                          //
                          //
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          )
                      :(!attendanceController.isLoading.value && !workReportController.isLoading.value)?Expanded(child: Center(child: Text("No data found"),)):SizedBox(),
                ],
              ),
              if (attendanceController.isLoading.value || workReportController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          )),
    );
  }


  // Step 1: Show the dropdown dialog on IconButton press
  void _showSiteSelectionDialog(
      BuildContext context,
      List<SiteData> items,
      String? selectedValue,
      Function(String?) onChanged,
      String title,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.headName ?? ""),
                  trailing: selectedValue == item.id.toString()
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    onChanged(item.id.toString());
                    Navigator.pop(context); // close dialog
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  String getDateWithDay(String dateString) {
    try {
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(dateString);
      return '${DateFormat('dd/MM/yyyy').format(date)} (${DateFormat('EEEE').format(date)})';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
