import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/Controller/admin_leave_request_controller.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/View/admin_leave_request_list_screen.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/View/admin_leave_request_pending_list_screen.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/View/add_appointment_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/common_widget.dart';
import '../../WorkmanProfile/Model/workman_list_response.dart';
import 'admin_leave_request_by_date_workman_list_screen.dart';


class SelectWorkmanLeaveRequestScreen extends StatefulWidget {
  @override
  _SelectWorkmanLeaveRequestScreenState createState() => _SelectWorkmanLeaveRequestScreenState();
}

class _SelectWorkmanLeaveRequestScreenState extends State<SelectWorkmanLeaveRequestScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  AdminLeaveRequestController leaveRequestController = Get.put(AdminLeaveRequestController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeData();
  }


  void _initializeData() async {
    await leaveRequestController.getLoginData();
    printData("_initializeData", "_initializeData");
    leaveRequestController.callWorkmanList();
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
                'Leave Request',
                  style: AppTextStyle.largeBold.copyWith(fontSize: 16
                      , color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.to(AdminLeaveRequestListScreen());
                  },
                  child: Text(
                    'View All >',
                    style:AppTextStyle.largeBold.copyWith(fontSize: 13
                        , color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {

                    Get.to(AdminLeaveRequestPendingListScreen());

                  },
                  child: Text(
                    'Pending Request',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 13
                        , color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: buildDropdownWorkman("Select Workman Name", leaveRequestController.workmanList, leaveRequestController.selectedWorkman),
          ),
          leaveRequestController.selectedWorkman.value != "0"?Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);
                      printData("selected day", formattedDate);
              
                      Get.to(adminLeaveRequestListByDateWorkman(empId: leaveRequestController.selectedWorkman.value,date: formattedDate,));
              
                    });
                  },
                  calendarStyle: CalendarStyle(
              
                    // todayDecoration: BoxDecoration(
                    //
                    //   color: Colors.green,
                    //   shape: BoxShape.circle,
                    // ),
                    selectedDecoration: BoxDecoration(
                      color: color_secondary,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(color: Colors.black),
                    weekendTextStyle: TextStyle(color: Colors.black),
              
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color_secondary,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: color_secondary),
                    rightChevronIcon:
                    Icon(Icons.chevron_right, color: color_secondary),
                  ),
                ),
              ),
            ),
          ):SizedBox(),
        ],
      ),
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
  }
}
