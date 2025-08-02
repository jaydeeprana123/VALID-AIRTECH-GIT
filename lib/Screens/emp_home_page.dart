import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valid_airtech/Screens/Allowance/View/emp_expense_screen.dart';
import 'package:valid_airtech/Screens/Appointment/View/appointment_screen.dart';
import 'package:valid_airtech/Screens/Attendance/View/emp_attendance_screen.dart';
import 'package:valid_airtech/Screens/Attendance/View/emp_site_attendance_calener_screen.dart';
import 'package:valid_airtech/Screens/Authentication/View/profile_screen_view.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/View/emp_leave_request_list_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_list_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_screen.dart';
import 'package:valid_airtech/Screens/Planning/View/emp_planning_screen.dart';
import 'package:valid_airtech/Screens/Planning/View/planning_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_screen.dart';
import 'package:valid_airtech/Screens/attendance_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/helper.dart';
import '../Styles/app_text_style.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_icons.dart';
import '../Widget/CommonButton.dart';
import 'AdminLeaveRequest/View/admin_leave_request_list_screen.dart';
import 'AdminLeaveRequest/View/select_workman_calender_leave_request_screen.dart';
import 'Attendance/Controller/attendance_controller.dart';
import 'Attendance/Model/create_attendance_in_request.dart';
import 'CalibrationCertificate/View/emp_calibration_list_screen.dart';
import 'Circular/View/circular_list_screen.dart';
import 'Circular/View/emp_circular_screen.dart';
import 'Master/View/employee_report_screen.dart';
import 'Master/View/master_index_screen.dart';
import 'Notes/View/notes_screen.dart';
import 'Offices/Model/office_list_response.dart';
import 'Sites/Model/site_list_response.dart';

class EmpHomePage extends StatefulWidget {
  @override
  _EmpHomePageState createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage> {
  String? selectedBloodGroup;
  // List<String> visitPlace = ["Office", "Site"];


  AttendanceController attendanceController =  Get.put(AttendanceController());

  bool isAttendanceFilled = false;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await attendanceController.getLoginData();
      await attendanceController.callAttendanceListByDate(DateFormat('dd-MM-yyyy').format(DateTime.now()));
      await attendanceController.callSiteList();
      await attendanceController.callOfficeList();


    });


  }


  void _initializeData() async {
    await attendanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    attendanceController.callAttendanceList([]);
  }

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

          // IconButton(
          //     icon:Icon(Icons.calendar_month, color: color_secondary, size: 36),
          // onPressed: (){
          //
          // },),
        ],
      ),
      body:  Obx(() => Stack(
        children: [
          Column(
            children: [
              // SizedBox(height: 10),
              // Center(
              //   child: Row(
              //     children: [
              //       SizedBox(width: 52),
              //       Expanded(
              //         child: Image.asset(
              //           iconLogo,
              //           height: 80,
              //         ),
              //       ),
              //       Icon(Icons.calendar_month, color: color_secondary, size: 36),
              //       SizedBox(width: 16),
              //     ],
              //   ),
              // ),
              SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: color_primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // 👈 Rounded corners here
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSectionTitle("Today's Attendance"),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<String>(
                                    value: 'Site',
                                    groupValue: attendanceController.selectedPlace,
                                    onChanged: (value) {
                                      setState(() {
                                        attendanceController.selectedPlace = value!;
                                        isAttendanceFilled = false;
                                        attendanceController.selectedOffice = null;
                                        attendanceController.selectedSite = null;
                                        attendanceController.statusOfAttendance = null;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Site',
                                    style: AppTextStyle.largeBold.copyWith(
                                      fontSize: 16,
                                      color: color_secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<String>(
                                    value: 'Office',
                                    groupValue: attendanceController.selectedPlace,
                                    onChanged: (value) {
                                      setState(() {
                                        attendanceController.selectedPlace = value!;
                                        isAttendanceFilled = false;
                                        attendanceController.selectedOffice = null;
                                        attendanceController.selectedSite = null;
                                        attendanceController.statusOfAttendance = null;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Office',
                                    style: AppTextStyle.largeBold.copyWith(
                                      fontSize: 16,
                                      color: color_secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 12),
                        attendanceController.selectedPlace == "Office"? Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: _buildDropdownOfficeList(attendanceController.officeList, attendanceController.selectedOffice,
                                  (val) {

                                setState(() {
                                  attendanceController.selectedOffice = val;
                                  attendanceController.statusOfAttendance = null;
                                  isAttendanceFilled = false;

                                  if(!isAttendanceFilled) {
                                    for (int i = 0; i <
                                        attendanceController.attendanceList
                                            .length; i++) {
                                      if (attendanceController.attendanceList[i]
                                          .officeId.toString() ==
                                          attendanceController.selectedOffice) {
                                        attendanceController.attendanceId =
                                            attendanceController.attendanceList[i].id
                                                .toString();
                                        attendanceController.statusOfAttendance =
                                            attendanceController
                                                .attendanceList[i].status.toString();

                                        if (attendanceController
                                            .attendanceList[i].status == 2) {
                                          isAttendanceFilled = true;
                                          setState(() {

                                          });

                                          snackBar(
                                              context, "Attendance already filled");
                                        }
                                      }
                                    }
                                  }


                                });

                              } , "Select Office"),
                        ):
                        attendanceController.selectedPlace == "Site"? Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: _buildDropdownSite(attendanceController.siteList, attendanceController.selectedSite,
                                  (val) {

                                setState(() {
                                  attendanceController.selectedSite = val;
                                  attendanceController.statusOfAttendance = null;
                                  isAttendanceFilled = false;

                                  if(!isAttendanceFilled){
                                    for(int i=0; i<attendanceController.attendanceList.length; i++){
                                      if(attendanceController.attendanceList[i].headId.toString() == attendanceController.selectedSite){
                                        attendanceController.attendanceId = attendanceController.attendanceList[i].id.toString();
                                        attendanceController.statusOfAttendance = attendanceController
                                            .attendanceList[i].status.toString();

                                        if(attendanceController
                                            .attendanceList[i].status == 2){
                                          isAttendanceFilled = true;

                                          snackBar(context, "Attendance already filled");
                                          setState(() {

                                          });



                                        }
                                      }


                                    }
                                  }


                                });

                              } , "Select Site"),
                        ):SizedBox(),

                        SizedBox(height: 8),
                        // Login Button
                        (attendanceController.selectedSite != null || attendanceController.selectedOffice != null) && attendanceController.statusOfAttendance == null? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: CommonButton(
                            titleText: "Sign In",
                            textColor: Colors.white,
                            onCustomButtonPressed: () async {

                              attendanceController.createAttendanceInRequest.value = CreateAttendanceInRequest();
                              attendanceController.createAttendanceInRequest.value.empId = attendanceController.loginData.value.id.toString();
                              attendanceController.createAttendanceInRequest.value.headId = attendanceController.selectedSite;
                              attendanceController.createAttendanceInRequest.value.officeId = attendanceController.selectedOffice;
                              attendanceController.createAttendanceInRequest.value.date = DateFormat('dd-MM-yyyy').format(DateTime.now());
                              DateTime now = DateTime.now();
                              String formattedTime = DateFormat('HH:mm:ss').format(now); // 24-hour format
                              attendanceController.createAttendanceInRequest.value.time = formattedTime;
                              attendanceController.createAttendanceInRequest.value.status = "1";
                              attendanceController.createAttendanceInRequest.value.typeLocation = attendanceController.selectedSite != null?"2":"1";

                              (await attendanceController.callCreateAttendanceIn());

                              setState(() {

                              });

                            },
                            borderColor: color_primary,
                            borderWidth: 0,
                          ),
                        ):SizedBox(),

                       attendanceController.statusOfAttendance =="1" && !isAttendanceFilled? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: CommonButton(
                            titleText: "Sign Out",
                            textColor: Colors.white,
                            onCustomButtonPressed: () async {

                              attendanceController.createAttendanceInRequest.value = CreateAttendanceInRequest();
                              attendanceController.createAttendanceInRequest.value.empId = attendanceController.loginData.value.id.toString();
                              attendanceController.createAttendanceInRequest.value.headId = attendanceController.selectedSite;
                              attendanceController.createAttendanceInRequest.value.officeId = attendanceController.selectedOffice;
                              attendanceController.createAttendanceInRequest.value.date = DateFormat('dd-MM-yyyy').format(DateTime.now());
                              DateTime now = DateTime.now();
                              String formattedTime = DateFormat('HH:mm:ss').format(now); // 24-hour format
                              attendanceController.createAttendanceInRequest.value.time = formattedTime;
                              attendanceController.createAttendanceInRequest.value.status = "1";
                              attendanceController.createAttendanceInRequest.value.typeLocation = attendanceController.selectedSite != null?"2":"1";

                             await attendanceController.callCreateAttendanceOut();

                             setState(() {

                             });


                            },
                            borderColor: color_primary,
                            borderWidth: 0,
                          ),
                        ):SizedBox(),


                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(height: 12,),


              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(EmpPlanningScreen());
                        },
                        child: _buildGridItem('Planning', Icons.schedule)),

                    // InkWell(
                    //     onTap: () {
                    //       Get.to(WorkReportListScreen());
                    //     },
                    //     child:
                    //     _buildGridItem('Site Report', Icons.work_history_outlined)),
                    InkWell(
                        onTap: () {
                          Get.to(EmpSiteAttendanceCalenderScreen())?.then((value)async{
                            await attendanceController.callAttendanceListByDate(DateFormat('dd-MM-yyyy').format(DateTime.now()));
                            attendanceController.selectedPlace = null;
                            isAttendanceFilled = false;
                            attendanceController.selectedOffice = null;
                            attendanceController.selectedSite = null;
                            attendanceController.statusOfAttendance = null;
                          });
                        },
                        child:
                        _buildGridItem('Site Report', Icons.event_note)),

                    InkWell(
                        onTap: () {
                          Get.to(EmpCalibrationListScreen());
                        },
                        child: _buildGridItem(
                            'Calibration Certificates', Icons.compass_calibration)),
                    // InkWell(
                    //     onTap: () {
                    //       Get.to(EmpExpenseScreen());
                    //     },
                    //     child: _buildGridItem('Expense', Icons.event_note)),
                    InkWell(
                        onTap: () {
                          Get.to(EmplLeaveRequestListScreen());
                        },
                        child:
                        _buildGridItem('Leave Request', Icons.note_add_outlined)),
                    // InkWell(
                    //     onTap: () {
                    //       Get.to(NotesScreen());
                    //     },
                    //     child: _buildGridItem('Note', Icons.note_alt)),
                    InkWell(
                        onTap: () {
                          Get.to(EmployeeCircularScreen());
                        },
                        child: _buildGridItem('Circular', Icons.newspaper)),
                    _buildGridItem('Help/Query', Icons.contact_support),
                  ],
                ),
              ),
              SizedBox(height: 20),


              InkWell(
                onTap: (){
                  Get.to(EmployeeReportScreen())?.then((value)async{
                    await attendanceController.callAttendanceListByDate(DateFormat('dd-MM-yyyy').format(DateTime.now()));
                    attendanceController.selectedPlace = null;
                    isAttendanceFilled = false;
                    attendanceController.selectedOffice = null;
                    attendanceController.selectedSite = null;
                    attendanceController.statusOfAttendance = null;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 24, left: 24),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade600,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "My Report",
                      style: AppTextStyle.largeBold
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )



            ],
          ),

         if(attendanceController.isLoading.value) Center(child: CircularProgressIndicator(),)

        ],
      )),
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return SizedBox(
      height: 80,
      child: Container(
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
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
      AppTextStyle.largeBold.copyWith(fontSize: 20, color: color_brown_title),
    );
  }

  Widget _buildDropdownOfficeList(List<OfficeData> items, String? selectedValue,
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
      items: items
          .map((e) => DropdownMenuItem(
          value: e.id.toString(), child: Text(e.title ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownSite(List<SiteData> items, String? selectedValue,
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
      items: items
          .map((e) => DropdownMenuItem(
          value: e.id.toString(), child: Text(e.headName ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }


}
