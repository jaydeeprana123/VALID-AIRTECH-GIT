import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valid_airtech/Screens/Authentication/View/login_screen_view.dart';
import 'package:valid_airtech/utils/preference_utils.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../Enums/select_date_enum.dart';
import '../Styles/my_colors.dart';
import 'package:get/get.dart';

class Helper {


  /// Get difference between current time and added time
  /// dateTime - Date and time which will be add when user will do comment
  getTimeDifference(DateTime dateTime) {
    DateTime dt1 = dateTime;
    DateTime dt2 = DateTime.now();

    Duration diff = dt2.difference(dt1);

    var difference = "";

    if (diff.inDays > 0) {
      difference = "${diff.inDays} Days";
    } else if (diff.inHours > 0) {
      difference = "${diff.inHours} Hours";
    } else if (diff.inMinutes > 0) {
      difference = "${diff.inMinutes} Minutes";
    } else if (diff.inSeconds > 0) {
      difference = "${diff.inSeconds} Seconds";
    } else {
      difference = "${diff.inSeconds} Seconds";
    }

    return difference;
  }


  /// Convert 24 hours time into 12 hours
  String convert24To12HoursFormat(DateTime? dateTime) {
    String timeIn12Hours = "";
    if (dateTime != null) {
      final dateFormat = DateFormat('h:mm a');
      timeIn12Hours = dateFormat.format(dateTime);
    }

    return timeIn12Hours;
  }




  Future<String> selectDate(BuildContext context,int selectDateFor) async {

    String dateFromDatePicker = "";

    DateTime? newDate = await showDatePicker(
      locale:  const Locale('en','IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      helpText: "Select Date",
      cancelText: "CANCEL",
      confirmText: "GO",
      fieldHintText: 'dd/mm/yyyy',
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: selectDateFor == SelectDateEnum.Past.outputVal?_decideWhichDayToEnable:null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: color_primary, // <-- SEE HERE
              onPrimary: color_primary, // <-- SEE HERE
              onSurface: color_primary, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
                 // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {

        dateFromDatePicker = DateFormat('dd/MM/yyyy').format(value);

      }
      return null;
    });


    return dateFromDatePicker;
  }

  Future<DateTime?> selectDateInYYYYMMDD(BuildContext context,int selectDateFor) async {

    DateTime? dateFromDatePicker;

    DateTime? newDate = await showDatePicker(
       locale:  const Locale('en','IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      helpText: "Select Date",
      cancelText: "CANCEL",
      confirmText: "GO",
       fieldHintText: 'dd/mm/yyyy',
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: selectDateFor == SelectDateEnum.Past.outputVal?_decideWhichDayToEnable:null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: color_secondary, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: color_primary, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.white), // button text color
              ),
            ),


          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        dateFromDatePicker = value;
       // dateFromDatePicker = DateFormat('dd/mm/yyyy').format(value) as DateTime?;

      }
      return null;
    });


    return dateFromDatePicker;
  }
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 36500))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 0))))) {
      return true;
    }
    return false;
  }

  bool _futureToEnable(DateTime day) {
    if ((day.isBefore(DateTime.now().subtract(const Duration(days: 36500))) &&
        day.isAfter(DateTime.now().add(const Duration(days: 0))))) {
      return true;
    }
    return false;
  }


  convertDatedIndMMMyyyy(DateTime originalDate) {
    String result;
    result = DateFormat("d MMM yyyy").format(originalDate);
    return result;
  }


  logout(){
    MySharedPref().clearData(SharePreData.keySaveLoginModel);
    Get.offAll(LoginScreenView());
  }



}
