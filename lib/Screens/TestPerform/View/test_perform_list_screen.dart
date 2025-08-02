import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Service/View/add_service_screen.dart';
import 'package:valid_airtech/Screens/Service/View/edit_service_screen.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/TestPerform/Controller/test_perform_controller.dart';
import 'package:valid_airtech/Screens/TestPerform/View/add_test_perform_screen.dart';
import 'package:valid_airtech/Screens/TestPerform/View/edit_test_perform_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';


class TestPerformListScreen extends StatefulWidget {
  @override
  _TestPerformListScreenState createState() => _TestPerformListScreenState();
}

class _TestPerformListScreenState extends State<TestPerformListScreen> {

  TestPerformController testPerformController = Get.put(TestPerformController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await testPerformController.getLoginData();

    printData("_initializeData", "_initializeData");

    testPerformController.callTestPerformListList();
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
                    'Test Perform',
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

                        Get.to(AddTestPerformScreen())?.then((value) {
                          testPerformController.isLoading.value = false;
                          testPerformController.callTestPerformListList();
                        });
                      },
                      child: Text(
                        'Head +',
                        style:AppTextStyle.largeBold.copyWith(fontSize: 13
                            , color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: testPerformController.testPerformList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        testPerformController.selectedTestPerform.value = testPerformController.testPerformList[index];
                        Get.to(EditTestPerformScreen())?.then((value) {
                          testPerformController.isLoading.value = false;
                          testPerformController.testPerformList();
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
                                'Test Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                testPerformController.testPerformList[index].testName??"",
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

          if(testPerformController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

