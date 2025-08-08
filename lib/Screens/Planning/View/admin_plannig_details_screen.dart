import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/add_planning_request.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Service/Model/service_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../../Appointment/Model/appointment_contact_list_response.dart';
import '../../Instruments/Model/isntrument_list_response.dart';
import '../../Sites/Model/site_list_response.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'edit_plannig_screen.dart';

class AdminPlanningDetailsScreen extends StatefulWidget {
  @override
  _AdminPlanningDetailsScreenState createState() =>
      _AdminPlanningDetailsScreenState();
}

class _AdminPlanningDetailsScreenState
    extends State<AdminPlanningDetailsScreen> {
  PlanningController planningController = Get.find<PlanningController>();

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
          'Planning',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
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
            icon: Icon(Icons.edit, color: color_secondary),
            onPressed: () {
              Get.to(EditPlanningScreen())?.then((value) {
                planningController.isLoading.value = false;
                Get.back();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _sectionTitle('Planning Details'),
            Row(
              children: [
                Expanded(
                    child: _infoColumn(
                        'Planning Date & Day',
                        getDateWithDay(
                            planningController.selectedPlanning.value.date ??
                                ""))),
                _infoColumn(
                    'Planning No.',
                    (planningController.selectedPlanning.value.planning?[0]
                                .planningId ??
                            0)
                        .toString()),
              ],
            ),
            Divider(),
            _sectionTitle('Workman Details'),
            for (int i = 0;
                i <
                    (planningController.selectedPlanning.value.workman ?? [])
                        .length;
                i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoColumn(
                      'Workman Name',
                      planningController
                              .selectedPlanning.value.workman?[i].workmanName ??
                          ""),
                  //    _infoColumn('Workman Id. No.', (planningController.selectedPlanning.value.workman?[i].workmanId??0).toString()),
                ],
              ),
            Divider(),
            _sectionTitle('Site Details'),
            _infoColumn('Site Name',
                planningController.selectedPlanning.value.headName ?? ""),
            _infoColumn('Site Suffix',
                planningController.selectedPlanning.value.siteSufix ?? ""),
            _infoColumn(
                'Site Address',
                planningController.selectedPlanning.value.siteHeadAddress ??
                    ""),
            _infoColumn(
                'Department',
                planningController.selectedPlanning.value.headDepartmentName ??
                    ""),
            _infoColumn(
                'Contact Person Name',
                planningController.selectedPlanning.value.headContactName ??
                    ""),
            _infoColumn('Email Id',
                planningController.selectedPlanning.value.headEmail ?? ""),
            Divider(),
            _sectionTitle('Conveyance Details'),
            SizedBox(height: 10),
            Divider(),
            _sectionTitle('Instrument Details'),
            for (int i = 0;
                i <
                    (planningController.selectedPlanning.value.instrument ?? [])
                        .length;
                i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoColumn('Instrument Name & No',
                      "${planningController.selectedPlanning.value.instrument?[i].headName ?? ""} ( ${planningController.selectedPlanning.value.instrument?[i].instrumentId ?? 0} )"),
                  //  _infoColumn('Instrument Id. No.', (planningController.selectedPlanning.value.instrument?[i].instrumentId??0).toString()),
                  //   _infoColumn('Instrument Model No.', (planningController.selectedPlanning.value.instrument?[i].instrumentModelNo??0).toString()),
                ],
              ),
            Divider(),
            _sectionTitle('Planned Services'),
            SizedBox(height: 10),
            Divider(),
            _sectionTitle('Notes'),
            for (int i = 0;
                i <
                    (planningController.selectedPlanning.value.note ?? [])
                        .length;
                i++)
              _infoColumn(
                  'Note ${i + 1}',
                  planningController.selectedPlanning.value.note?[i].title ??
                      ""),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          style: AppTextStyle.largeRegular
              .copyWith(fontSize: 18, color: color_secondary),
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.largeMedium
                .copyWith(fontSize: 14, color: color_brown_title),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyle.largeSemiBold
                .copyWith(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // String getDateWithDay(String dateString) {
  //   DateTime date = DateTime.parse(dateString);  // for 'yyyy-MM-dd'
  //   return '${DateFormat('dd-MM-yyyy').format(date)} (${DateFormat('EEEE').format(date)})';
  // }

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
