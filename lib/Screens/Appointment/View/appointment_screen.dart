import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/View/add_appointment_screen.dart';
import 'package:valid_airtech/Screens/Appointment/View/appointment_list_by_date_screen.dart';
import 'package:valid_airtech/Screens/Appointment/View/appointment_list_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/common_widget.dart';


class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  AppointmentController appointmentController = Get.put(AppointmentController());

  late DateTime _startOfMonth;
  late DateTime _endOfMonth;

  late String startFormatted;
  late String endFormatted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAPI();
  }

  Future<void> initAPI() async {

    await appointmentController.getLoginData();

    // Set selectedDay to today initially
    _selectedDay = _focusedDay;

    // Calculate start and end of month
    _startOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    _endOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);

    // Optional: format and print
    startFormatted = DateFormat('dd-MM-yyyy').format(_startOfMonth);
    endFormatted = DateFormat('dd-MM-yyyy').format(_endOfMonth);

    appointmentController.callAppointmentListByMonth(startFormatted, endFormatted);

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
      body: Obx(() =>Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Appointment',
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
                        Get.to(AppointmentListScreen());
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

                        Get.to(AddAppointmentScreen())?.then((value) {
                          appointmentController.isLoading.value = false;
                          appointmentController.callAppointmentListByMonth(startFormatted, endFormatted);
                        });

                      },
                      child: Text(
                        '+Add',
                        style: AppTextStyle.largeBold.copyWith(fontSize: 13
                            , color: Colors.white),
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

                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;

                        // Calculate start and end of current month
                        DateTime startDate = DateTime(focusedDay.year, focusedDay.month, 1);
                        DateTime endDate = DateTime(focusedDay.year, focusedDay.month + 1, 0);

                        startFormatted = DateFormat('dd-MM-yyyy').format(startDate);
                        endFormatted = DateFormat('dd-MM-yyyy').format(endDate);

                        appointmentController.callAppointmentListByMonth(startFormatted, endFormatted);

                      });
                    },

                    eventLoader: (day) {
                      return appointmentController.appointmentList.where((item) {
                        // Parse item.date (dd-MM-yyyy) to DateTime
                        DateTime? itemDate;
                        try {
                          itemDate = DateFormat('dd-MM-yyyy').parse(item.date ?? '');
                        } catch (_) {
                          return false;
                        }

                        // Match by day (ignoring time)
                        return isSameDay(itemDate, day);
                      }).toList();
                    },


                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;

                        String formattedDate =
                        DateFormat('dd-MM-yyyy').format(selectedDay);
                        printData("selected day", formattedDate);

                        Get.to(AppointmentListByDateScreen(
                          date: formattedDate,
                        ))?.then((value) {
                          appointmentController.isLoading.value = false;
                          appointmentController.callAppointmentListByMonth(startFormatted, endFormatted);
                        });

                      });
                    },
                    calendarStyle: CalendarStyle(
                      markerDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      markersAlignment: Alignment.topCenter,
                      markersMaxCount: 1,
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
            ],
          ),

          if(appointmentController.isLoading.value)const Center(child: CircularProgressIndicator(),)
        ],
      )),
    );
  }
}
