import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/View/add_work_report_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';


class WorkReportListScreen extends StatefulWidget {
  final String attendanceId;
  final String date;
  final String siteId;

  WorkReportListScreen({
    Key? key,
    required this.attendanceId,
    required this.date,
    required this.siteId
  }) : super(key: key);



  @override
  _WorkReportListScreenState createState() => _WorkReportListScreenState();
}

class _WorkReportListScreenState extends State<WorkReportListScreen> {



  WorkReportController workReportController = Get.put(WorkReportController());

  @override
  void initState() {
    super.initState();
    initData();

  }

  initData()async{
   await workReportController.getLoginData();
    workReportController.callWorkReportList(widget.attendanceId);
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
          'All Work Report',
          style: AppTextStyle.largeBold.copyWith(fontSize: 18
              , color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: color_secondary),
            onPressed: () {

              Get.to(AddWorkReportScreen(attendanceId: widget.attendanceId, date: widget.date,siteId: widget.siteId,))?.then((value) {
                workReportController.callWorkReportList(widget.attendanceId);
              });
            },
          ),
        ],
      ),
      body: Obx(() =>Stack(
        children: [
          workReportController.workReportList.isNotEmpty? ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: workReportController.workReportList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  workReportController.selectedWorkReportData.value = workReportController.workReportList[index];
                  Get.to(WorkReportDetailsScreen(date: widget.date,attendanceId: widget.attendanceId,))?.then((value) {
                    workReportController.callWorkReportList(widget.attendanceId);
                  });;
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Work Report Date',
                          style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                              , color: color_brown_title),
                        ),
                        Text(
                          widget.date,
                          style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                              , color: Colors.black),
                        ),

                        const SizedBox(height: 12),

                         Text(
                          'Contact Name',
                          style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                              , color: color_brown_title),
                        ),
                        Text(
                          workReportController.workReportList[index].contactName??"",
                          style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                              , color: Colors.black),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ):Center(child: Text("No data found"),),

          if(workReportController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ''),
        ],
      ),
    );
  }
}

