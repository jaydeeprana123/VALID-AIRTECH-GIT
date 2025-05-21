import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/emp_expnese_list_by_date_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/emp_expnese_list_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_list_by_date_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Notes/Controller/notes_controller.dart';
import 'package:valid_airtech/Screens/Notes/View/add_note_screen.dart';
import 'package:valid_airtech/Screens/Notes/View/note_list_by_date_screen.dart';
import 'package:valid_airtech/Screens/Notes/View/notes_list_screen.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/View/add_plannig_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_list_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/common_widget.dart';


class EmpExpenseScreen extends StatefulWidget {
  @override
  _EmpExpenseScreenState createState() => _EmpExpenseScreenState();
}

class _EmpExpenseScreenState extends State<EmpExpenseScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  AllowanceController allowanceController =
      Get.put(AllowanceController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allowanceController.getLoginData();
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
          'Valid Airtech',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'Expense',
                style: AppTextStyle.largeBold
                    .copyWith(fontSize: 16, color: Colors.white),
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
                    Get.to(EmpExpenseListScreen(empId: allowanceController.loginData.value.id.toString()));
                  },
                  child: Text(
                    'View All >',
                    style: AppTextStyle.largeBold
                        .copyWith(fontSize: 13, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
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

                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(selectedDay);
                    printData("selected day", formattedDate);

                    Get.to(EmpExpenseListByDateScreen(
                      empId: allowanceController.loginData.value.id.toString(),
                      date: formattedDate,
                    ));
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
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: color_secondary),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: color_secondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
