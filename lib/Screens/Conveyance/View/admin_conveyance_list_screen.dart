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
import 'package:valid_airtech/Screens/Conveyance/View/admin_update_conveyance_screen.dart';
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
import 'admin_conveyance_payment_list_screen.dart';


class AdminConveyanceListScreen extends StatefulWidget {

  final String empId;

  AdminConveyanceListScreen({
    Key? key,
    required this.empId,
  }) : super(key: key);

  @override
  _AdminConveyanceListScreenState createState() => _AdminConveyanceListScreenState();
}

class _AdminConveyanceListScreenState extends State<AdminConveyanceListScreen> {

  ConveyanceController conveyanceController = Get.put(ConveyanceController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await conveyanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    conveyanceController.callAdminConveyanceReportList(widget.empId);
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
                    'All Conveyance',
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
                            conveyanceController.fromDateEditingController.value.text =
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
                          child: Text(conveyanceController
                              .fromDateEditingController.value.text.isNotEmpty
                              ? conveyanceController
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
                            conveyanceController
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
                          child: Text(conveyanceController
                              .toDateEditingController.value.text.isNotEmpty
                              ? conveyanceController
                              .toDateEditingController.value.text
                              : "To",
                            style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                , color: color_brown_title),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        conveyanceController
                            .callAdminConveyanceReportList(widget.empId);
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
                child: conveyanceController.adminConveyanceList.isNotEmpty?ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: conveyanceController.adminConveyanceList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        conveyanceController.selectedAdminConveyance.value = conveyanceController.adminConveyanceList[index];
                        Get.to(AdminUpdateConveyanceScreen())?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callAdminConveyanceList(widget.empId);
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
                              Text(
                                'Conveyance Through',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                conveyanceController.adminConveyanceList[index].headConveyanceName??"",
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
                                conveyanceController.adminConveyanceList[index].date??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),

                               Text(
                                'Conveyance Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (conveyanceController.adminConveyanceList[index].conveyanceName??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Address',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (conveyanceController.adminConveyanceList[index].headAddress??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),


                              const SizedBox(height: 12),
                              Text(
                                'Amount',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (conveyanceController.adminConveyanceList[index].amount??"0").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 16),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(AdminConveyancePaymentListScreen(adminConveyanceId: conveyanceController.adminConveyanceList[index].id.toString(),adminConveyorName: conveyanceController.adminConveyanceList[index].conveyanceName??""))?.then((value) {
                                    conveyanceController.isLoading.value = false;
                                    conveyanceController.callAdminConveyanceList(widget.empId);
                                  });

                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Icon(Icons.money, color: Colors.white,),

                                    SizedBox(width: 3,),

                                    Text(
                                      'Payment',
                                      style:AppTextStyle.largeBold.copyWith(fontSize: 13
                                          , color: Colors.white),
                                    ),
                                  ],
                                ),
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

          if(conveyanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

