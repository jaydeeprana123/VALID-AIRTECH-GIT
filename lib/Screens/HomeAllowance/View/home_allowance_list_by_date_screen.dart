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
import 'package:valid_airtech/Screens/HomeAllowance/View/add_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/edit_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';


class HomeAllowanceListByDateScreen extends StatefulWidget {
  final String date;
  HomeAllowanceListByDateScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _HomeAllowanceListByDateScreenState createState() => _HomeAllowanceListByDateScreenState();
}

class _HomeAllowanceListByDateScreenState extends State<HomeAllowanceListByDateScreen> {

  HomeAllowanceController allowanceController = Get.put(HomeAllowanceController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await allowanceController.getLoginData();

    printData("_initializeData", "_initializeData");
    allowanceController.homeAllowanceList.clear();
    allowanceController.callHomeAllowanceListByDate(widget.date);
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
                    'Allowance',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),


              SizedBox(height: 12,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color_primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {

                  Get.to(AddHomeAllowanceScreen());

                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add',
                      style:AppTextStyle.largeBold.copyWith(fontSize: 13
                          , color: Colors.white),
                    ),
                    SizedBox(width: 4,),

                    Icon(Icons.add, color: Colors.white,)

                  ],
                ),
              ),

              allowanceController.homeAllowanceList.isNotEmpty?Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: allowanceController.homeAllowanceList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        allowanceController.selectedHomeAllowance.value = allowanceController.homeAllowanceList[index];
                        Get.to(EditHomeAllowanceScreen())?.then((value) {
                          allowanceController.isLoading.value = false;
                          allowanceController.callHomeAllowanceListByDate(widget.date);
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
                                'Allowance Date',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                allowanceController.homeAllowanceList[index].date??"",
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
                                (allowanceController.homeAllowanceList[index].workmanName??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Allowance Type',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (allowanceController.homeAllowanceList[index].allowanceName??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),

                              const SizedBox(height: 12),
                              Text(
                                'Allowance Amount',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                SharePreData.keyRupeeSymbol + (allowanceController.homeAllowanceList[index].amount??"").toString(),
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
              ):Expanded(child: Center(child: Text("No data found"),)),
            ],
          ),

          if(allowanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

