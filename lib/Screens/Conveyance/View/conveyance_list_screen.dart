import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/View/edit_conveyance_screen.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'conveyance_head_list_screen.dart';


class ConveyanceListScreen extends StatefulWidget {
  @override
  _ConveyanceListScreenState createState() => _ConveyanceListScreenState();
}

class _ConveyanceListScreenState extends State<ConveyanceListScreen> {

  ConveyanceController conveyanceController = Get.put(ConveyanceController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await conveyanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    conveyanceController.callConveyanceList();
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
                    'Conveyance',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color_primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(ConveyanceheadConveysListScreen());
                      },
                      child: Text(
                        'Head >',
                        style:AppTextStyle.largeBold.copyWith(fontSize: 13
                            , color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color_primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => AddConveyanceScreen())?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callConveyanceList();
                        });
                      },
                      child: Text(
                        '+Add',
                        style: AppTextStyle.largeBold.copyWith(fontSize: 13
                            , color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: conveyanceController.conveysList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        conveyanceController.selectedConveyance.value = conveyanceController.conveysList[index];
                        Get.to(EditConveyanceScreen())?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callConveyanceList();
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
                                       crossAxisAlignment: CrossAxisAlignment.start
                                       ,children: [
                                         Text(
                                          'Conveyor Name',
                                          style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                              , color: color_brown_title),
                                                                       ),
                                                                       Text(
                                          conveyanceController.conveysList[index].name??"",
                                          style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                              , color: Colors.black),
                                                                       ),
                                       ],
                                     ),
                                   ),

                                   Expanded(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: [
                                         Text(
                                           'Conveyor Through',
                                           style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                               , color: color_brown_title),
                                         ),
                                         Text(
                                           conveyanceController.conveysList[index].headConveyanceName??"",
                                           style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                               , color: Colors.black),
                                         ),
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                              const SizedBox(height: 12),
                               Text(
                                'Conveyor Contact No.',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                conveyanceController.conveysList[index].contact?[0].mobileNo??"",
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

          if(conveyanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

