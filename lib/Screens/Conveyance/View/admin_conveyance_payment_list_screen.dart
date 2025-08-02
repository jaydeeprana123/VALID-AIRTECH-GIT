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
import 'package:valid_airtech/Screens/Conveyance/View/admin_edit_conveyance_payment_screen.dart';
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
import 'admin_add_conveyance_payment_screen.dart';


class AdminConveyancePaymentListScreen extends StatefulWidget {

  final String adminConveyanceId;
  final String adminConveyorName;
  AdminConveyancePaymentListScreen({
    Key? key,
    required this.adminConveyanceId,
    required this.adminConveyorName,

  }) : super(key: key);

  @override
  _AdminConveyancePaymentListScreenState createState() => _AdminConveyancePaymentListScreenState();
}

class _AdminConveyancePaymentListScreenState extends State<AdminConveyancePaymentListScreen> {

  ConveyanceController conveyanceController = Get.find<ConveyanceController>();


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await conveyanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    conveyanceController.callAdminConveyancePaymentList(widget.adminConveyanceId);
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
                    'All Conveyance Payment',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
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

                        Get.to(AdminAddConveyancePaymentScreen(adminConveyanceId: widget.adminConveyanceId,))?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callAdminConveyancePaymentList(widget.adminConveyanceId);
                        });

                      },
                      child: Text(
                        'Add +',
                        style:AppTextStyle.largeBold.copyWith(fontSize: 13
                            , color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),

              


              Expanded(
                child: conveyanceController.adminConveyancePaymentList.isNotEmpty?ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: conveyanceController.adminConveyancePaymentList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        conveyanceController.selectedAdminConveyancePayment.value = conveyanceController.adminConveyancePaymentList[index];
                        Get.to(AdminEditConveyancePaymentScreen(adminConveyanceId: widget.adminConveyanceId))?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callAdminConveyancePaymentList(widget.adminConveyanceId);
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
                                'Date',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                conveyanceController.adminConveyancePaymentList[index].date??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),


                              Text(
                                'Conveyor Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                widget.adminConveyorName,
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
                                (conveyanceController.adminConveyancePaymentList[index].amount??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Remarks',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (conveyanceController.adminConveyancePaymentList[index].remark??"").toString(),
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

          if(conveyanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

