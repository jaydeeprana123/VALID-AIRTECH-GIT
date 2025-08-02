import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_head_screen.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'edit_head_screen.dart';


class SiteHeadListScreen extends StatefulWidget {
  @override
  _SiteHeadListScreenState createState() => _SiteHeadListScreenState();
}

class _SiteHeadListScreenState extends State<SiteHeadListScreen> {

  SiteController siteController = Get.find<SiteController>();


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await siteController.getLoginData();

    printData("_initializeData", "_initializeData");

    siteController.callHeadListList();
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
                    'Site Name & Address',
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
                    Get.to(() => AddHeadScreen())?.then((value) {
                      siteController.isLoading.value = false;
                      siteController.callHeadListList();
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
                  itemCount: siteController.headList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){

                        siteController.selectedHead.value = siteController.headList[index];

                        Get.to(EditHeadScreen())?.then((value) {
                          siteController.isLoading.value = false;
                          siteController.callHeadListList();
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
                                'Site Name',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                siteController.headList[index].name??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                               Text(
                                'Site Address',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                siteController.headList[index].address??"",
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

          if(siteController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

