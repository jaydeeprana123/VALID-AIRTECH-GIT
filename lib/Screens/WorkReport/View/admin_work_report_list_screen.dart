import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/View/add_work_report_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/edit_work_report_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import '../../../Enums/select_date_enum.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/common_widget.dart';
import '../../../utils/helper.dart';


class AdminWorkReportListScreen extends StatefulWidget {
  final String empId;

  AdminWorkReportListScreen({
    Key? key,
    required this.empId,
  }) : super(key: key);



  @override
  _AdminWorkReportListScreenState createState() => _AdminWorkReportListScreenState();
}

class _AdminWorkReportListScreenState extends State<AdminWorkReportListScreen> {
  WorkReportController workReportController = Get.put(WorkReportController());

  @override
  void initState() {
    super.initState();
    initData();

  }

  initData()async{
    await workReportController.getLoginData();
    workReportController.callAdminWorkReportList(widget.empId);
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
          // IconButton(
          //   icon: Icon(Icons.add_circle, color: color_secondary),
          //   onPressed: () {
          //
          //     Get.to(AddWorkReportScreen())?.then((value) {
          //       workReportController.callWorkReportList();
          //     });
          //   },
          // ),
        ],
      ),
      body: Obx(() =>Stack(
        children: [
          Column(
            children: [

              Container(
                margin: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          DateTime? dateTime = await Helper()
                              .selectDateInYYYYMMDD(
                              context, SelectDateEnum.all.outputVal);

                          setState(() {
                            workReportController.fromDateEditingController.value.text =
                                getDateFormatDDMMYYYYOnly((dateTime ?? DateTime(2023))
                                );
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              )),
                          child: Text(workReportController
                              .fromDateEditingController.value.text.isNotEmpty
                              ? workReportController
                              .fromDateEditingController.value.text
                              : "From",
                            style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                , color: color_brown_title),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          DateTime? dateTime = await Helper()
                              .selectDateInYYYYMMDD(
                              context, SelectDateEnum.all.outputVal);

                          setState(() {
                            workReportController
                                .toDateEditingController.value.text =
                                getDateFormatDDMMYYYYOnly((dateTime ?? DateTime(2023))
                                );
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              )),
                          child: Text(workReportController
                              .toDateEditingController.value.text.isNotEmpty
                              ? workReportController
                              .toDateEditingController.value.text
                              : "To",
                            style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                , color: color_brown_title),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        workReportController
                            .callAdminWorkReportList(widget.empId);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: 12, right: 12, top: 4, bottom: 4),
                        margin: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: color_primary,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            )),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              workReportController.adminWorkReportList.isNotEmpty? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: workReportController.adminWorkReportList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        workReportController.selectedWorkReportData.value = workReportController.adminWorkReportList[index];
                        Get.to(WorkReportDetailsScreen())?.then((value) {
                          workReportController.callAdminWorkReportList(widget.empId);
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
                                workReportController.adminWorkReportList[index].date??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                                    , color: Colors.black),
                              ),
                
                              const SizedBox(height: 12),
                
                              Text(
                                'Driver Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                                    , color: color_brown_title),
                              ),
                              Text(
                                workReportController.adminWorkReportList[index].conveyanceName??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                                    , color: Colors.black),
                              ),
                
                              const SizedBox(height: 12),
                
                              Text(
                                'Contact Person',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                                    , color: color_brown_title),
                              ),
                              Text(
                                workReportController.adminWorkReportList[index].contactPerson??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 13
                                    , color: Colors.black),
                              ),
                
                              const SizedBox(height: 12),
                
                              Text(
                                'Witness Person',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                                    , color: color_brown_title),
                              ),
                              Text(
                                workReportController.adminWorkReportList[index].witnessPerson??"",
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
              ):Center(child: Text("No data found"),),
            ],
          ),

          if(workReportController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ''),
      //   ],
      // ),
    );
  }
}

