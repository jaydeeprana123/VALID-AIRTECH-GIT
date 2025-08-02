import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/edit_allowance_screen.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/View/edit_appointment_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/edit_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_filter_dialog.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Notes/Controller/notes_controller.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/View/edit_plannig_screen.dart';
import 'package:valid_airtech/Screens/Planning/View/plannig_details_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../AdminLeaveRequest/View/leave_filter_dialog.dart';
import '../../Notes/View/edit_note_screen.dart';
import '../../Sites/Model/site_list_response.dart';


class EmpPlanningListByDateScreen extends StatefulWidget {

  final String date;
  EmpPlanningListByDateScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _EmpPlanningListByDateScreenState createState() => _EmpPlanningListByDateScreenState();
}

class _EmpPlanningListByDateScreenState extends State<EmpPlanningListByDateScreen> {

  PlanningController planningController = Get.find<PlanningController>();
  String? selectedSite;
  @override
  void initState() {
    super.initState();
    planningController.filterPlanningList.clear();
    _initializeData();
  }

  void _initializeData() async {
    await planningController.getLoginData();

    printData("_initializeData", "_initializeData");

    planningController.callPlanningListByDate(widget.date);
    planningController.callSiteList();
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
            onPressed: () {
              Get.back();
            },


          ),


          IconButton(
            icon: Icon(Icons.filter_alt_sharp, color: color_secondary),
            onPressed: () {

              List<SiteData> modifiedSiteList = [
                SiteData(id: 0, headName: "All"),
                ...planningController.siteList,
              ];

              _showSiteSelectionDialog(
                context,
                modifiedSiteList,
                selectedSite,
                    (val) {
                  setState(() {
                    selectedSite = val;
                    planningController.filterPlanningListBySite(selectedSite ?? "0");
                  });
                },
                'Select Site',
              );

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
                    'Planning',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),


              SizedBox(height: 12,),

              planningController.filterPlanningList.isNotEmpty?Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: planningController.filterPlanningList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        planningController.selectedPlanning.value = planningController.filterPlanningList[index];
                        Get.to(PlanningDetailsScreen())?.then((value) {
                          planningController.isLoading.value = false;
                          planningController.callPlanningListByDate(widget.date);
                        });
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
                                          'Planning Date',
                                          style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                              , color: color_brown_title),
                                        ),
                                        Text(
                                          getDateWithDay(planningController.filterPlanningList[index].date??""),
                                          style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                              , color: Colors.black),
                                        ),
                                      ],
                                    ),



                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Planning No.',
                                        style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                            , color: color_brown_title),
                                      ),
                                      Text(
                                        (planningController.filterPlanningList[index].workman??[]).isNotEmpty?(planningController.filterPlanningList[index].planning?[0].planningId??0).toString():"",
                                        style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                            , color: Colors.black),
                                      ),
                                    ],
                                  )

                                ],
                              ),


                              const SizedBox(height: 12),
                               Text(
                                'Site Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                "${planningController.filterPlanningList[index].headName??""}, ${planningController.filterPlanningList[index].siteHeadAddress??""}",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Workman Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (planningController.filterPlanningList[index].workman??[]).isNotEmpty? (planningController.filterPlanningList[index].workman?[0].workmanName??"").toString():"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),


                              // const SizedBox(height: 12),
                              // Text(
                              //   'Conveyance Name',
                              //   style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                              //       , color: color_brown_title),
                              // ),
                              // Text(
                              //   (planningController.filterPlanningList[index].conveyance?[0].conveyanceName??"").toString(),
                              //   style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                              //       , color: Colors.black),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ):(!planningController.isLoading.value)?Expanded(child: Center(child: Text("No data found"),)):SizedBox(),
            ],
          ),

          if(planningController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }

  void showLeaveFilterDialog() {
    Get.bottomSheet(
      HomeAllowanceFilterDialog(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }

  // Step 1: Show the dropdown dialog on IconButton press
  void _showSiteSelectionDialog(
      BuildContext context,
      List<SiteData> items,
      String? selectedValue,
      Function(String?) onChanged,
      String title,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.headName ?? ""),
                  trailing: selectedValue == item.id.toString()
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    onChanged(item.id.toString());
                    Navigator.pop(context); // close dialog
                  },
                );
              },
            ),
          ),
        );
      },
    );
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
}

