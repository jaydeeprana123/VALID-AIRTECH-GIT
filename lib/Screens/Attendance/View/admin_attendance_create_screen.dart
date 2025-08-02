import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Attendance/Controller/attendance_controller.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../Model/admin_create_attendance_request.dart';


class AdminAttendanceCreateScreen extends StatefulWidget {


  @override
  _AdminAttendanceCreateScreenState createState() =>
      _AdminAttendanceCreateScreenState();
}

class _AdminAttendanceCreateScreenState
    extends State<AdminAttendanceCreateScreen> {
  AttendanceController attendanceController = Get.put(AttendanceController());
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    attendanceController.callWorkmanList();
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
                
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _buildDatePicker(),
                    ),
                
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
                
                    
                    
                    attendanceController.workmanList.isNotEmpty
                        ? Expanded(
                          child: ListView.builder(
                                                padding: const EdgeInsets.all(10),
                                                itemCount: attendanceController.workmanList.length,
                                                itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
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
                                            .workmanList[index].name ??
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
                                            attendanceController.workmanList[index]
                                                .attendanceStatus)
                                            ? attendanceController
                                            .workmanList[index].attendanceStatus
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
                                            attendanceController.workmanList[index]
                                                .attendanceStatus = newValue;
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
                                          
                                            attendanceController.workmanList[index]
                                                .attendanceStatus ==
                                                "P (Present)" ||
                                                attendanceController
                                                    .workmanList[index]
                                                    .attendanceStatus ==
                                                    "O (Weekly Off)" ||
                                                attendanceController
                                                    .workmanList[index]
                                                    .attendanceStatus ==
                                                    "H (Holiday)" ? Row(
                                              children: [
                                                Checkbox(value: attendanceController
                                                    .workmanList[index].isCheckedES,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        attendanceController
                                                            .workmanList[index]
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
                                          
                                            attendanceController.workmanList[index]
                                                .attendanceStatus ==
                                                "O (Weekly Off)" ?
                                            Row(
                                              children: [
                                                Checkbox(value: attendanceController
                                                    .workmanList[index].isCheckedPO,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        attendanceController
                                                            .workmanList[index]
                                                            .isCheckedPO =
                                                            value ?? false;
                                                      });
                                                    }),
                                          
                                                Text('PO')
                                              ],
                                            ) : attendanceController
                                                .workmanList[index]
                                                .attendanceStatus == "H (Holiday)" ?
                                            Row(
                                              children: [
                                                Checkbox(value: attendanceController
                                                    .workmanList[index].isCheckedPH,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        attendanceController
                                                            .workmanList[index]
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
                          );
                                                },
                                              ),
                        )
                        : Expanded(
                          child: Center(
                                                child: Text("No data found"),
                                              ),
                        ),
                
                
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                
                          if(selectedDate == null){
                            snackBar(context, "Please select date first!");
                            return;
                          }
                
                          attendanceController.adminCreateAttendanceRequest
                              .value = AdminCreateAttendanceRequest();
                          attendanceController.adminCreateAttendanceRequest.value
                              .attendence = [];
                
                          bool isDataFilled = true;
                
                          for (int i = 0; i <
                              attendanceController.workmanList.length; i++) {
                            Attendence attendance = Attendence();
                            attendance.empId =
                                attendanceController.workmanList[i].id ?? 0;
                            attendance.date =
                                DateFormat('dd-MM-yyyy').format(selectedDate!);
                
                            if ((attendanceController.workmanList[i]
                                .attendanceStatus ?? "").isNotEmpty) {
                              attendance.attendenceStatus = attendanceController
                                  .attendanceStatusList.indexOf(
                                  attendanceController.workmanList[i]
                                      .attendanceStatus ?? "") + 1;
                
                              attendance.overTime = [];
                              
                              if(attendance.attendenceStatus == 1 || attendance.attendenceStatus == 3 || attendance.attendenceStatus == 4){
                                if(attendanceController.workmanList[i].isCheckedES){
                                  attendance.overTime?.add(OverTime(overTimeStatus: 1));
                                }
                              }
                
                              if(attendance.attendenceStatus == 3){
                                if(attendanceController.workmanList[i].isCheckedPO){
                                  attendance.overTime?.add(OverTime(overTimeStatus: 2));
                                }
                              }
                
                              if(attendance.attendenceStatus == 4){
                                if(attendanceController.workmanList[i].isCheckedPH){
                                  attendance.overTime?.add(OverTime(overTimeStatus: 3));
                                }
                              }
                              
                            }else{
                              isDataFilled = false;
                              snackBar(context, "Select Status for ${attendanceController.workmanList[i].name??""}");
                              break;
                            }
                
                            attendanceController.adminCreateAttendanceRequest
                                .value.attendence?.add(attendance);
                          }
                
                          if(isDataFilled){
                            attendanceController.callAdminCreateAttendance();
                          }
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

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // Bottom-only border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                selectedDate == null
                    ? 'Select Date'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
                style: AppTextStyle.largeMedium.copyWith(
                    fontSize: 15,
                    color:
                    selectedDate == null ? color_hint_text : Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
