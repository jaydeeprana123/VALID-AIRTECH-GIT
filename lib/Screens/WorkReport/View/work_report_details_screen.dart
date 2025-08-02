import 'dart:developer';
import 'package:intl/intl.dart';
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

  WorkReportDetailsScreen({
    Key? key,

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
          'Site Report Details',
          style: AppTextStyle.largeBold.copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: color_secondary),
            onPressed: () {
              Get.to(EditWorkReportScreen());
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

            _buildSectionTitle('Site Details'),

            SizedBox(height: 12,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reporting Date & Day",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                    , color: color_brown_title)),

                Text(getDateWithDay(workReportController.selectedWorkReportData.value.date??""),style: AppTextStyle.largeBold.copyWith(fontSize: 16
                    , color: Colors.black)),

                SizedBox(height: 16,),


                Text("Site Name",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                    , color: color_brown_title)),

                Text(workReportController.selectedWorkReportData.value.siteName??"",style: AppTextStyle.largeBold.copyWith(fontSize: 16
                    , color: Colors.black)),

                SizedBox(height: 16,),


                Text("Site Suffix",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                    , color: color_brown_title)),

                Text(workReportController.selectedWorkReportData.value.siteSuffixName??"",style: AppTextStyle.largeBold.copyWith(fontSize: 16
                    , color: Colors.black)),
              ],
            ),



            SizedBox(height: 8.0),
            InfoRow(label: 'Site Report Date & Day', value: getDateWithDay(workReportController.selectedWorkReportData.value.date??"")),

            SizedBox(height: 8.0),
            InfoRow(label: 'Conveyance Name', value: workReportController.selectedWorkReportData.value.conveyanceName??""),

            SizedBox(height: 8.0),
            InfoRow(label: 'Conveyance Through Name', value: workReportController.selectedWorkReportData.value.convenyenceThroughName??""),

            SizedBox(height: 8.0),
            InfoRow(label: 'Conveyance Through Other', value: workReportController.selectedWorkReportData.value.convenyenceThroughOther??""),

            SizedBox(height: 8.0),
            InfoRow(label: 'Service Nature', value: workReportController.selectedWorkReportData.value.serviceNatureName??""),


            SizedBox(height: 8.0),
            InfoRow(label: 'Contact Person', value: workReportController.selectedWorkReportData.value.contactPerson??""),

            SizedBox(height: 8.0),
            InfoRow(label: 'Witness Person', value: workReportController.selectedWorkReportData.value.witnessPerson??""),


            SizedBox(height: 16.0),
            Center(child: SectionHeader(title: 'Remarks')),
            SizedBox(height: 8.0),

            for(int i=0; i<(workReportController.selectedWorkReportData.value.remark??[]).length;i++)
            InfoRow(label: 'Remark ${i+1}', value: workReportController.selectedWorkReportData.value.remark?[i].remark??""),


            SizedBox(height: 16.0),
            Center(child: SectionHeader(title: 'Site Attend By')),
            SizedBox(height: 8.0),

            for(int i=0; i<(workReportController.selectedWorkReportData.value.siteAttendBy??[]).length;i++)
              InfoRow(label: 'User ${i+1}', value: workReportController.selectedWorkReportData.value.siteAttendBy?[i].userName??""),

            SizedBox(height: 16.0),
            Center(child: SectionHeader(title: 'Service Status')),
            SizedBox(height: 8.0),

            for(int i=0; i<(workReportController.selectedWorkReportData.value.serviceStatus??[]).length;i++)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.grey.shade300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(label: 'Test Location :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].testLocation??""),
                    InfoRow(label: 'Room Equipment :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].roomEquipment??""),
                    InfoRow(label: 'Test Performed By :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].testPerfomedName??""),
                    InfoRow(label: 'Head Instrument :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].headInstrumentName??""),
                    InfoRow(label: 'Remark :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].remark??""),
                    InfoRow(label: 'Status :', value: workReportController.selectedWorkReportData.value.serviceStatus?[i].statusType??""),

                  ],
                ),
              ),



            SizedBox(height: 16.0),
            // Center(child: SectionHeader(title: 'Expense Details')),
            // SizedBox(height: 8.0),
            // ExpenseRow(label: 'Train', value: workReportController.selectedWorkReportData.value.train??"0"),
            // ExpenseRow(label: 'Bus', value: workReportController.selectedWorkReportData.value.bus??"0"),
            // ExpenseRow(label: 'Auto', value: workReportController.selectedWorkReportData.value.auto??"0"),
            // ExpenseRow(label: 'Fuel', value: workReportController.selectedWorkReportData.value.fuel??"0"),
            // ExpenseRow(label: 'Food Amount', value: workReportController.selectedWorkReportData.value.foodAmount??"0"),
            // ExpenseRow(label: 'Others', value:workReportController.selectedWorkReportData.value.other??"0"),
            // Divider(thickness: 1, color: Colors.black),
            // ExpenseRow(label: 'Total', value: '0.00', isBold: true),
            SizedBox(height: 8.0),
            InfoRow(label: 'Remark For Others', value: 'NA'),
            SizedBox(height: 16.0),


            // GridView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //   ),
            //   itemCount: (workReportController.selectedWorkReportData.value.workReportExpensesBill??[]).length,
            //   itemBuilder: (context, index) {
            //     return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            //
            //       Container(child: Image.network(workReportController.selectedWorkReportData.value.workReportExpensesBill?[index].photo??"", width: 160, height: 160,)),
            //       SizedBox(height: 2,),
            //       Text(workReportController.selectedWorkReportData.value.workReportExpensesBill?[index].billName??"", style: AppTextStyle.largeRegular.copyWith(fontSize: 14
            //           , color: Colors.black54)),
            //
            //       SizedBox(height: 8,),
            //     ],);
            //   },
            // ),
            //
            //
            //
            // SizedBox(height: 22,),


            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 30),
            //       child: CommonButton(
            //         titleText: "Edit Site Report",
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
            //         titleText: "Delete Site Report",
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


Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style:
    AppTextStyle.largeBold.copyWith(fontSize: 20, color: color_hint_text),
  );
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

String getDateWithDay(String dateString) {
  try {
    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    DateTime date = inputFormat.parse(dateString);
    return '${DateFormat('dd/MM/yyyy').format(date)} (${DateFormat('EEEE').format(date)})';
  } catch (e) {
    return 'Invalid Date';
  }
}

