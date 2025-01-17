import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';


class WorkReportListScreen extends StatefulWidget {
  @override
  _WorkReportListScreenState createState() => _WorkReportListScreenState();
}

class _WorkReportListScreenState extends State<WorkReportListScreen> {
  final List<Map<String, String>> workReports = [
    {'date': '09/07/2024 (Tuesday)', 'site': 'Office_Valid Airtech'},
    {'date': '08/07/2024 (Monday)', 'site': 'Raks Pharma Pvt. Ltd.'},
    {'date': '07/07/2024 (Sunday)', 'site': 'Not Applicable'},
    {'date': '06/07/2024 (Saturday)', 'site': 'Aleor Dermaceuticals Ltd.'},
    {'date': '05/07/2024 (Friday)', 'site': 'Not Available'},
  ];

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
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: workReports.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(WorkReportDetailsScreen());
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
                      workReports[index]['date']!,
                      style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                          , color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                     Text(
                      'Site Name',
                      style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                          , color: color_brown_title),
                    ),
                    Text(
                      workReports[index]['site']!,
                      style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                          , color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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

