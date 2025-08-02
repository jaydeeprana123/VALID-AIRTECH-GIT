import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Attendance/Controller/attendance_controller.dart';
import 'package:valid_airtech/Screens/Attendance/Model/admin_update_attendance_request.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../Model/admin_create_attendance_request.dart';


class AdminAttendanceUpdateScreen extends StatefulWidget {

  @override
  _AdminAttendanceUpdateScreenState createState() =>
      _AdminAttendanceUpdateScreenState();
}

class _AdminAttendanceUpdateScreenState
    extends State<AdminAttendanceUpdateScreen> {
  AttendanceController attendanceController = Get.find<AttendanceController>();


  String? selectedAttendanceStatus;


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "_initializeData");
   selectedAttendanceStatus = attendanceController.attendanceStatusList[(attendanceController
        .selectedAdminAttendanceData.value.attendenceStatus??0) - 1];

   for(int i =0; i<(attendanceController.selectedAdminAttendanceData.value.overTime??[]).length; i++){
     if(attendanceController.selectedAdminAttendanceData.value.overTime?[i].overTimeStatus == "1"){
       attendanceController.selectedAdminAttendanceData.value.isCheckedES = true;
       attendanceController.selectedAdminAttendanceData.value.idES = attendanceController.selectedAdminAttendanceData.value.overTime?[i].id;
     }

     if(attendanceController.selectedAdminAttendanceData.value.overTime?[i].overTimeStatus == "2"){
       attendanceController.selectedAdminAttendanceData.value.isCheckedPO = true;
       attendanceController.selectedAdminAttendanceData.value.idPO = attendanceController.selectedAdminAttendanceData.value.overTime?[i].id;

     }

     if(attendanceController.selectedAdminAttendanceData.value.overTime?[i].overTimeStatus == "3"){
       attendanceController.selectedAdminAttendanceData.value.isCheckedPH = true;
       attendanceController.selectedAdminAttendanceData.value.iddPH = attendanceController.selectedAdminAttendanceData.value.overTime?[i].id;

     }
   }

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
      body: Obx(() =>
          Stack(
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
                
                    // Container(
                    //   margin: EdgeInsets.only(top: 16),
                    //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: color_primary,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //         ),
                    //         onPressed: () {
                    //           Get.to(AddAllowanceScreen())?.then((value) {
                    //             allowanceController.isLoading.value = false;
                    //             allowanceController.callAllowanceList();
                    //           });
                    //         },
                    //         child: Text(
                    //           'Head +',
                    //           style:AppTextStyle.largeBold.copyWith(fontSize: 13
                    //               , color: Colors.white),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 12,
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                "Workman\nName",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.largeBold
                                    .copyWith(
                                    fontSize: 12, color: color_brown_title),
                              )),
                          Expanded(
                              child: Text(
                                "Attendance\nStatus",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.largeBold
                                    .copyWith(
                                    fontSize: 12, color: color_brown_title),
                              )),
                          Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Over Time\nStatus",
                                style: AppTextStyle.largeBold
                                    .copyWith(
                                    fontSize: 12, color: color_brown_title),
                              ))
                        ],
                      ),
                    ),



                    Card(
                      elevation: 2,
                      margin:
                      const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                attendanceController
                                    .selectedAdminAttendanceData.value.empName ??
                                    "",

                                style: AppTextStyle.largeMedium
                                    .copyWith(
                                    fontSize: 12,
                                    color: color_brown_title),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                              child: DropdownButton<String>(
                                value: attendanceController
                                    .attendanceStatusList
                                    .contains(
                                    selectedAttendanceStatus)
                                    ? selectedAttendanceStatus
                                    : null,
                                // Ensure valid value
                                hint: Text(
                                  "Status", textAlign: TextAlign.center,
                                  style: AppTextStyle.largeMedium
                                      .copyWith(
                                      fontSize: 12,
                                      color: color_brown_title),),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedAttendanceStatus = newValue;
                                  });
                                },
                                items: attendanceController
                                    .attendanceStatusList.map((
                                    String group) {
                                  return DropdownMenuItem<String>(
                                    value: group,
                                    child: Text(
                                      group, textAlign: TextAlign.center,
                                      style: AppTextStyle.largeMedium
                                          .copyWith(
                                          fontSize: 12,
                                          color: color_brown_title),),
                                  );
                                }).toList(),
                              ),),

                            SizedBox(width: 8,),

                            Expanded(
                                child:

                                Column(
                                  children: [

                                    selectedAttendanceStatus ==
                                        "P (Present)" ||
                                        selectedAttendanceStatus ==
                                            "O (Weekly Off)" ||
                                        selectedAttendanceStatus ==
                                            "H (Holiday)" ? Row(
                                      children: [
                                        Checkbox(value: attendanceController
                                            .selectedAdminAttendanceData.value.isCheckedES,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                attendanceController
                                                    .selectedAdminAttendanceData.value
                                                    .isCheckedES =
                                                    value ?? false;
                                              });
                                            }),

                                        Text('ES')
                                      ],
                                    ) : Text(
                                      "NA",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.largeMedium
                                          .copyWith(
                                          fontSize: 12,
                                          color: color_brown_title),
                                    ),

                                    selectedAttendanceStatus ==
                                        "O (Weekly Off)" ?
                                    Row(
                                      children: [
                                        Checkbox(value: attendanceController.
                                            selectedAdminAttendanceData.value.isCheckedPO,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                attendanceController
                                                    .selectedAdminAttendanceData.value
                                                    .isCheckedPO =
                                                    value ?? false;
                                              });
                                            }),

                                        Text('PO')
                                      ],
                                    ) : selectedAttendanceStatus == "H (Holiday)" ?
                                    Row(
                                      children: [
                                        Checkbox(value: attendanceController
                                            .selectedAdminAttendanceData.value.isCheckedPH,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                attendanceController
                                                    .selectedAdminAttendanceData.value
                                                    .isCheckedPH =
                                                    value ?? false;
                                              });
                                            }),

                                        Text('PH')
                                      ],
                                    ) : SizedBox()


                                  ],
                                )


                            ),
                          ],
                        ),
                      ),
                    ),
                
                
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                
                          attendanceController.adminUpdateAttendanceRequest
                              .value = AdminUpdateAttendanceRequest();
                          attendanceController.adminUpdateAttendanceRequest
                              .value.id = attendanceController.selectedAdminAttendanceData.value.id;

                          attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus = attendanceController
                              .attendanceStatusList.indexOf(
                              selectedAttendanceStatus) + 1;

                          attendanceController.adminUpdateAttendanceRequest
                              .value.overTime = [];

                          if(attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus == 1 || attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus == 3 || attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus == 4){
                            if(attendanceController.selectedAdminAttendanceData.value.isCheckedES){
                              attendanceController.adminUpdateAttendanceRequest
                                  .value.overTime?.add(UpdateOverTime(overTimeStatus: 1,id: attendanceController.selectedAdminAttendanceData.value.idES));
                            }
                          }

                          if(attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus == 3){
                            if(attendanceController.selectedAdminAttendanceData.value.isCheckedPO){
                              attendanceController.adminUpdateAttendanceRequest
                                  .value.overTime?.add(UpdateOverTime(overTimeStatus: 2,id: attendanceController.selectedAdminAttendanceData.value.idPO));
                            }
                          }

                          if(attendanceController.adminUpdateAttendanceRequest
                              .value.attendenceStatus == 4){
                            if(attendanceController.selectedAdminAttendanceData.value.isCheckedPH){
                              attendanceController.adminUpdateAttendanceRequest
                                  .value.overTime?.add(UpdateOverTime(overTimeStatus: 3,id: attendanceController.selectedAdminAttendanceData.value.iddPH));
                            }
                          }


                          attendanceController.callAdminUpdateAttendance();
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),
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
