import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../Controller/work_report_controller.dart';
import 'edit_work_report_screen.dart';

class WorkReportDetailsScreen extends StatefulWidget {

  final String attendanceId;
  final String date;

  WorkReportDetailsScreen({
    Key? key,
    required this.attendanceId,
    required this.date
  }) : super(key: key);

  @override
  _WorkReportDetailsScreenState createState() => _WorkReportDetailsScreenState();
}

class _WorkReportDetailsScreenState extends State<WorkReportDetailsScreen> {
  WorkReportController workReportController = Get.find<WorkReportController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
          'Work Report',
          style: AppTextStyle.largeBold.copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: color_secondary),
            onPressed: () {
              Get.to(EditWorkReportScreen(attendanceId: widget.attendanceId,date: widget.date, siteId: workReportController.selectedWorkReportData.value.siteId.toString(),));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SectionHeader(title: 'Site Details')),
            SizedBox(height: 8.0),
            InfoRow(label: 'Work Report Date', value: widget.date),

            Center(child: SectionHeader(title: 'Remarks')),
            SizedBox(height: 8.0),

            for(int i=0; i<(workReportController.selectedWorkReportData.value.remark??[]).length;i++)
            InfoRow(label: 'Remark ${i+1}', value: workReportController.selectedWorkReportData.value.remark?[i].remark??""),

            SizedBox(height: 16.0),
            Center(child: SectionHeader(title: 'Expense Details')),
            SizedBox(height: 8.0),
            ExpenseRow(label: 'Train', value: workReportController.selectedWorkReportData.value.train??"0"),
            ExpenseRow(label: 'Bus', value: workReportController.selectedWorkReportData.value.bus??"0"),
            ExpenseRow(label: 'Auto', value: workReportController.selectedWorkReportData.value.auto??"0"),
            ExpenseRow(label: 'Fuel', value: workReportController.selectedWorkReportData.value.fuel??"0"),
            ExpenseRow(label: 'Food Amount', value: workReportController.selectedWorkReportData.value.foodAmount??"0"),
            ExpenseRow(label: 'Others', value:workReportController.selectedWorkReportData.value.other??"0"),
            // Divider(thickness: 1, color: Colors.black),
            // ExpenseRow(label: 'Total', value: '0.00', isBold: true),
            SizedBox(height: 8.0),
            InfoRow(label: 'Remark For Others', value: 'NA'),
            SizedBox(height: 16.0),

            for(int i=0; i<(workReportController.selectedWorkReportData.value.workReportExpensesBill??[]).length;i++)
              SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [
                Image.network(workReportController.selectedWorkReportData.value.workReportExpensesBill?[i].photo??"", width: 160, height: 160,),
                SizedBox(width: 22,)
              ],),),

            SizedBox(height: 22,),


            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 30),
            //       child: CommonButton(
            //         titleText: "Edit Work Report",
            //         textColor: Colors.white,
            //         onCustomButtonPressed: () async {
            //           Get.to(EditWorkReportScreen(attendanceId: widget.attendanceId,date: widget.date, siteId: workReportController.selectedWorkReportData.value.siteId.toString(),));
            //         },
            //         borderColor: color_primary,
            //         borderWidth: 0,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //       child: CommonButton(
            //         titleText: "Delete Work Report",
            //         textColor: Colors.white,
            //         onCustomButtonPressed: () async {
            //           // TODO: handle delete
            //         },
            //         borderColor: Colors.red,
            //         borderWidth: 0,
            //         buttonColor: Colors.red,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}


class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppTextStyle.largeBold.copyWith(fontSize: 18
          , color: color_primary),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(


        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.largeBold.copyWith(fontSize: 14
              , color: color_brown_title)),
          Text(value, style: AppTextStyle.largeRegular.copyWith(fontSize: 14
              , color: Colors.black54)),
        ],
      ),
    );
  }
}

class ExpenseRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  ExpenseRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold?AppTextStyle.largeBold.copyWith(fontSize: 14
          , color: Colors.black):AppTextStyle.largeRegular.copyWith(fontSize: 14
          , color: Colors.black)),
          Text(
            value,
            style: isBold?AppTextStyle.largeBold.copyWith(fontSize: 14
                , color: Colors.black54):AppTextStyle.largeRegular.copyWith(fontSize: 14
                , color: Colors.black54)
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  ActionButton({required this.label, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(label, style: TextStyle(color: Colors.white),),
    );
  }
}

