import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_head_screen.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'add_conveyance_head_screen.dart';
import 'edit_conveyance_head_screen.dart';


class ConveyanceheadConveysListScreen extends StatefulWidget {
  @override
  _ConveyanceheadConveysListScreenState createState() => _ConveyanceheadConveysListScreenState();
}

class _ConveyanceheadConveysListScreenState extends State<ConveyanceheadConveysListScreen> {

  ConveyanceController conveyanceController = Get.find<ConveyanceController>();


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await conveyanceController.getLoginData();

    printData("_initializeData", "_initializeData");

    conveyanceController.callHeadConveyanceList();
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
                    'Conveyance Type',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color_primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => AddConveyanceHeadScreen())?.then((value) {
                      conveyanceController.isLoading.value = false;
                      conveyanceController.callHeadConveyanceList();
                    });
                  },
                  child: Text(
                    '+Generate',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 13
                        , color: Colors.white),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: conveyanceController.headConveysList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        conveyanceController.selectedHeadConveyance.value = conveyanceController.headConveysList[index];
                        Get.to(EditConveyanceHeadScreen())?.then((value) {
                          conveyanceController.isLoading.value = false;
                          conveyanceController.callHeadConveyanceList();
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
                                'Conveyance Type',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                conveyanceController.headConveysList[index].name??"",
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

