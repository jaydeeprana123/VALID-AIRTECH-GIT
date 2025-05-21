import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/edit_allowance_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Enums/select_date_enum.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../utils/helper.dart';


class EmpExpenseListScreen extends StatefulWidget {

  final String empId;

  EmpExpenseListScreen({
    Key? key,
    required this.empId,
  }) : super(key: key);

  @override
  _EmpExpenseListScreenState createState() => _EmpExpenseListScreenState();
}

class _EmpExpenseListScreenState extends State<EmpExpenseListScreen> {

  AllowanceController allowanceController = Get.find<AllowanceController>();


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await allowanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    allowanceController.callAdminExpenseList(widget.empId);
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
                    'All Expenses',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),

              // Container(
              //   margin: EdgeInsets.only(top: 16),
              //   padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: color_primary,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         onPressed: () {
              //           Get.to(AddAllowanceScreen())?.then((value) {
              //             allowanceController.isLoading.value = false;
              //             allowanceController.callAllowanceList();
              //           });
              //         },
              //         child: Text(
              //           'Head +',
              //           style:AppTextStyle.largeBold.copyWith(fontSize: 13
              //               , color: Colors.white),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              // ),


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
                            allowanceController.fromDateEditingController.value.text =
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
                          child: Text(allowanceController
                              .fromDateEditingController.value.text.isNotEmpty
                              ? allowanceController
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
                            allowanceController
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
                          child: Text(allowanceController
                              .toDateEditingController.value.text.isNotEmpty
                              ? allowanceController
                              .toDateEditingController.value.text
                              : "To",
                            style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                , color: color_brown_title),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        allowanceController
                            .callAdminExpenseList(widget.empId);
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


              Expanded(
                child: allowanceController.adminExpenseList.isNotEmpty?ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: allowanceController.adminExpenseList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

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
                                'Employee Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                allowanceController.adminExpenseList[index].empName??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),

                              Text(
                                'Date',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                allowanceController.adminExpenseList[index].date??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),

                               Text(
                                'Train',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].train??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Bus',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].bus??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),


                              const SizedBox(height: 12),
                              Text(
                                'Auto',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].auto??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Fuel',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].fuel??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),


                              const SizedBox(height: 12),
                              Text(
                                'Food Amount',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].foodAmount??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Other',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.adminExpenseList[index].other??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ):Center(child: Text("No Data Found"),),
              ),
            ],
          ),

          if(allowanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

