import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Offices/Controller/office_controller.dart';
import 'package:valid_airtech/Screens/Offices/View/add_office_screen.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/Sites/View/site_head_list_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'edit_office_screen.dart';


class OfficeListScreen extends StatefulWidget {
  @override
  _OfficeListScreenState createState() => _OfficeListScreenState();
}

class _OfficeListScreenState extends State<OfficeListScreen> {

  OfficeController officeController = Get.put(OfficeController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await officeController.getLoginData();

    printData("_initializeData", "_initializeData");

    officeController.callOfficeList();
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
                    'Office',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child:   ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color_primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => AddOfficeScreen())?.then((value) {
                      officeController.isLoading.value = false;
                      officeController.callOfficeList();
                    });
                  },
                  child: Text(
                    '+Add',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 13
                        , color: Colors.white),
                  ),
                ),
              ),

              officeController.officeList.isNotEmpty? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: officeController.officeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        officeController.selectedOffice.value = officeController.officeList[index];

                        Get.to(EditOfficeScreen())?.then((value) {
                          officeController.isLoading.value = false;
                          officeController.callOfficeList();
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
                                'Title',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                officeController.officeList[index].title??"",
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

          if(officeController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

