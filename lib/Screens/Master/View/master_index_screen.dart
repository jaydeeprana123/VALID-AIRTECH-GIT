import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Enums/master_screen_enum.dart';
import 'package:valid_airtech/Screens/Allowance/View/allowance_list_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/View/conveyance_list_screen.dart';
import 'package:valid_airtech/Screens/Instruments/View/instrument_list_screen.dart';
import 'package:valid_airtech/Screens/Offices/View/office_list_screen.dart';
import 'package:valid_airtech/Screens/Service/View/service_list_screen.dart';
import 'package:valid_airtech/Screens/Sites/View/site_list_screen.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/View/workman_list_screen.dart';

import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../utils/helper.dart';

class MasterIndexScreen extends StatelessWidget {
  const MasterIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: color_secondary),
        onPressed: () {
         Get.back();
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.green,
            padding: const EdgeInsets.all(12),
            child:  Center(
              child: Text(
                'Master / Index',
                style: AppTextStyle.largeBold.copyWith(fontSize: 14
                    , color: Colors.white),
                textAlign: TextAlign.center,

              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.6, // Adjust aspect ratio for rectangle shape
                children: [
                  _buildGridButton(Icons.factory, 'Site', MasterScreenEnum.site.index),
                  _buildGridButton(Icons.add_road_outlined, 'Conveyance',MasterScreenEnum.conveyance.index),
                  _buildGridButton(Icons.build, 'Instrument',MasterScreenEnum.instruments.index),
                  _buildGridButton(Icons.handyman, 'Service',MasterScreenEnum.service.index),
                  _buildGridButton(Icons.attach_money, 'Allowance', MasterScreenEnum.allowance.index),
                  _buildGridButton(Icons.person, 'Workman Profile', MasterScreenEnum.workmanProfile.index),
                  _buildGridButton(Icons.person, 'Office', MasterScreenEnum.office.index),

                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildGridButton(IconData icon, String title,int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {

        navigateToScreen(index);

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyle.largeBold.copyWith(fontSize: 14
                , color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void navigateToScreen(int index) {
    switch (MasterScreenEnum.values[index]) {
      case MasterScreenEnum.site:
        Get.to(SiteListScreen());
        break;
      case MasterScreenEnum.conveyance:
        Get.to(ConveyanceListScreen());
        break;
      case MasterScreenEnum.instruments:
        Get.to(InstrumentListScreen());
        break;
      case MasterScreenEnum.service:
        Get.to(ServiceListScreen());
        break;
      case MasterScreenEnum.allowance:
        Get.to(AllowanceListScreen());
        break;
      case MasterScreenEnum.workmanProfile:
        Get.to(WorkmanListScreen());
        break;

      case MasterScreenEnum.office:
        Get.to(OfficeListScreen());
        break;

    }
  }

}
