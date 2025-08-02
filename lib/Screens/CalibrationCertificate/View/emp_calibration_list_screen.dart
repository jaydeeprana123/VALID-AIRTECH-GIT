import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/edit_allowance_screen.dart';
import 'package:valid_airtech/Screens/CalibrationCertificate/Controller/calibration_controller.dart';
import 'package:valid_airtech/Screens/CalibrationCertificate/View/edit_calibration_screen.dart';
import 'package:valid_airtech/Screens/Circular/View/edit_circular_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/edit_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/home_allowance_filter_dialog.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Notes/Controller/notes_controller.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../AdminLeaveRequest/View/leave_filter_dialog.dart';
import 'add_calibration_screen.dart';

class EmpCalibrationListScreen extends StatefulWidget {
  @override
  _EmpCalibrationListScreenState createState() =>
      _EmpCalibrationListScreenState();
}

class _EmpCalibrationListScreenState extends State<EmpCalibrationListScreen> {
  CalibrationController calibrationController =
      Get.put(CalibrationController());

  @override
  void initState() {
    super.initState();
    calibrationController.calibrationList.clear();
    calibrationController.filePath.value = "";
    _initializeData();
  }

  void _initializeData() async {
    await calibrationController.getLoginData();

    printData("_initializeData", "_initializeData");

    calibrationController.callCalibrationList();
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
        ],
      ),
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: color_primary,
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        'Calibration Certificates',
                        style: AppTextStyle.largeBold
                            .copyWith(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  calibrationController.calibrationList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount:
                                calibrationController.calibrationList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  calibrationController
                                          .selectedCalibration.value =
                                      calibrationController
                                          .calibrationList[index];
                                  Get.to(EditCalibrationScreen())?.then((value) {
                                    calibrationController.isLoading.value =
                                        false;
                                    calibrationController.callCalibrationList();
                                  });
                                },
                                child: Card(
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Title',
                                          style: AppTextStyle.largeMedium
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: color_brown_title),
                                        ),
                                        Text(
                                          (calibrationController
                                                      .calibrationList[index]
                                                      .title ??
                                                  "")
                                              .toString(),
                                          style: AppTextStyle.largeRegular
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Attachment',
                                          style: AppTextStyle.largeMedium
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: color_brown_title),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final Uri launchUri = Uri.parse(
                                                calibrationController
                                                        .calibrationList[index]
                                                        .pdf ??
                                                    "");

                                            printData(
                                                "url",
                                                calibrationController
                                                        .calibrationList[index]
                                                        .pdf ??
                                                    "");

                                            await launchUrl(launchUri,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Text(
                                            Uri.parse((calibrationController
                                                        .calibrationList[index]
                                                        .pdf ??
                                                    ""))
                                                .pathSegments
                                                .last,
                                            style: AppTextStyle.largeRegular
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: Text("No data found"),
                        )),
                ],
              ),
              if (calibrationController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
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
}
