import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/Controller/admin_leave_request_controller.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/View/admin_leave_request_pending_list_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Service/View/add_service_screen.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'leave_filter_dialog.dart';


class AdminLeaveRequestListScreen extends StatefulWidget {
  @override
  _AdminLeaveRequestListScreenState createState() => _AdminLeaveRequestListScreenState();
}

class _AdminLeaveRequestListScreenState extends State<AdminLeaveRequestListScreen> {

  AdminLeaveRequestController adminLeaveRequestController = Get.put(AdminLeaveRequestController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await adminLeaveRequestController.getLoginData();

    printData("_initializeData", "_initializeData");

    adminLeaveRequestController.callAdminLeaveRequestList();
    adminLeaveRequestController.callWorkmanList();
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
          style: AppTextStyle.largeBold.copyWith(fontSize: 18
              , color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(() =>Stack(
        children: [
          Column(
            children: [

              Container(
                width: double.infinity,
                color: color_primary,
                padding: const EdgeInsets.all(12),
                child:  Center(
                  child: Text(
                    'Leave Request',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color_primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showLeaveFilterDialog();
                          },
                          child: Row(
                            children: [
                              Text(
                                'Filter',
                                style:AppTextStyle.largeBold.copyWith(fontSize: 13
                                    , color: Colors.white),
                              ),
                              SizedBox(width: 4,),

                              Icon(Icons.filter_alt_sharp, color: Colors.white,)

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color_primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.to(AdminLeaveRequestPendingListScreen());
                          },
                          child: Text(
                            'Pending Request',
                            style:AppTextStyle.largeBold.copyWith(fontSize: 13
                                , color: Colors.white),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: adminLeaveRequestController.adminLeaveRequestList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                      //  Get.to(WorkReportDetailsScreen());
                      },
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Workman Name',
                                          style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                              , color: color_brown_title),
                                        ),
                                        Text(
                                          adminLeaveRequestController.adminLeaveRequestList[index].employeeName??"",
                                          style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                              , color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Status',
                                        style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                            , color: color_brown_title),
                                      ),
                                      Text(
                                        adminLeaveRequestController.adminLeaveRequestList[index].statusType??"",
                                        style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                            , color: adminLeaveRequestController.adminLeaveRequestList[index].status == 0?Colors.yellow.shade900:
                                            adminLeaveRequestController.adminLeaveRequestList[index].status == 1?Colors.green:Colors.red),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              const SizedBox(height: 12),
                               Text(
                                'From Date',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                adminLeaveRequestController.adminLeaveRequestList[index].fromDate??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'No Of Leave Days',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                adminLeaveRequestController.adminLeaveRequestList[index].numberOfLeaveDays??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          if(adminLeaveRequestController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }

  void showLeaveFilterDialog() {
    Get.bottomSheet(
      LeaveFilterDialog(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }


}

