import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Head/Model/head_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/conveyance_list_response.dart';

class AddConveyanceScreen extends StatefulWidget {
  @override
  _AddConveyanceScreenState createState() => _AddConveyanceScreenState();
}

class _AddConveyanceScreenState extends State<AddConveyanceScreen> {
  ConveyanceController conveyanceController = Get.find<ConveyanceController>();
  String? selectedConveyanceThrough;
  final List<String> contactTypeOptions = ['Mobile', 'Telephone'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform navigation or state updates after build completes
      conveyanceController.callHeadConveyanceList();
      conveyanceController.contactList.clear();
      conveyanceController.contactList.add(AddContactModel());

      conveyanceController.conveyorNameController.value.text = "";
      conveyanceController.suffixController.value.text = "";
      conveyanceController.conveyorAddressController.value.text = "";

    });




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
          'Conveyance Details',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() =>Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),

                _buildDropdown(conveyanceController.headConveysList, selectedConveyanceThrough,
                    (val) => setState(() => selectedConveyanceThrough = val), "Conveyance Through"),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                  conveyanceController.conveyorNameController.value,
                  "Conveyor Name"
                    ),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    conveyanceController.suffixController.value,
                    "Suffix"
                ),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    conveyanceController.conveyorAddressController.value,
                    "Conveyory Address"
                ),


                SizedBox(
                  height: 20,
                ),



              _buildSectionTitle("Contact No's"),


                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: color_hint_text, width: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0;
                      i < conveyanceController.contactList.length;
                      i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownString(
                                      contactTypeOptions,
                                      conveyanceController.contactList[i].type,
                                          (val) =>
                                          setState(() => conveyanceController.contactList[i].type = val),
                                      "Type"),),


                                SizedBox(width: 16,),

                                Expanded(
                                    child: _buildTextField(
                                        conveyanceController.contactList[i].textEditingControllerNum,
                                        'No. ${i + 1}'),
                                ),


                                (i ==
                                    (conveyanceController.contactList.length - 1))?
                                InkWell(
                                    onTap: () {
                                      conveyanceController.contactList
                                          .add(AddContactModel());
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: color_brown_title,
                                    )):InkWell(
                                    onTap: () {
                                      conveyanceController.contactList.removeAt(i);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.remove_circle,
                                      size: 30,
                                      color: color_primary,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )
                    ],
                  ),
                ),



                // Login Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CommonButton(
                    titleText: "Save",
                    textColor: Colors.white,
                    onCustomButtonPressed: () async {

                      conveyanceController.createConveyanceRequest.value = CreateConveyanceRequest();
                      conveyanceController.createConveyanceRequest.value.headConveyanceId = selectedConveyanceThrough??"";
                      conveyanceController.createConveyanceRequest.value.name = conveyanceController.conveyorNameController.value.text;
                      conveyanceController.createConveyanceRequest.value.sufix = conveyanceController.suffixController.value.text;
                      conveyanceController.createConveyanceRequest.value.address = conveyanceController.conveyorAddressController.value.text;

                      conveyanceController.createConveyanceRequest.value.contact = [];
                      for(int i=0; i<conveyanceController.contactList.length; i++){
                        ContactConveyance contact = ContactConveyance();
                        contact.contactType = (conveyanceController.contactList[i].type??"") == "Mobile"?"1":"2";

                        if(contact.contactType == "1"){
                          contact.mobileNo = conveyanceController.contactList[i].textEditingControllerNum.value.text;
                        }else if(contact.contactType == "2"){
                          contact.telephone = conveyanceController.contactList[i].textEditingControllerNum.value.text;

                        }


                        conveyanceController.createConveyanceRequest.value.contact?.add(contact);

                      }

                      conveyanceController.callCreateConveyance();

                    },
                    borderColor: color_primary,
                    borderWidth: 0,
                  ),
                ),
              ],
            ),
          ),

          if(conveyanceController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
          AppTextStyle.largeBold.copyWith(fontSize: 20, color: color_hint_text),
    );
  }


  Widget _buildDropdownString(List<String> items, String? selectedValue,
      Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10),
        alignLabelWithHint: true,

        labelText: hint,
        // Moves up as a floating label when a value is selected
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when selecting
        hintText: hint,
        // Hint text
        hintStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        labelStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Bottom-only border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Bottom border on focus
        ),
      ),
      value: selectedValue,
      isExpanded: true,
      // Ensures dropdown takes full width
      items:
      items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
    ;
  }


  Widget _buildDropdown(List<HeadConveyanceData> items, String? selectedValue,
      Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10),
        alignLabelWithHint: true,

        labelText: hint,
        // Moves up as a floating label when a value is selected
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when selecting
        hintText: hint,
        // Hint text
        hintStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        labelStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 15, color: color_hint_text),
        // Hint text style
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Bottom-only border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Bottom border on focus
        ),
      ),
      value: selectedValue,
      isExpanded: true,
      // Ensures dropdown takes full width
      items:
          items.map((e) => DropdownMenuItem(value: e.id.toString(), child: Text(e.name??""))).toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildTimePicker(String title, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (time != null) // Show label only when time is selected
            Text(
              title, // Floating label text
              style: TextStyle(
                fontSize: 12,
                color: color_hint_text, // Floating label color
              ),
            ),
          Container(
            padding: EdgeInsets.only(bottom: 4, right: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey), // Bottom-only border
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time == null ? title : time.format(context),
                  style: AppTextStyle.largeRegular.copyWith(
                    fontSize: 15,
                    color: time == null ? color_hint_text : Colors.black,
                  ),
                ),
                Icon(Icons.timer_outlined, color: Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0),
        alignLabelWithHint: true,
        labelText: hint,
        // Display hint as title when typing
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // Auto float when typing
        border: UnderlineInputBorder(),
        hintStyle: AppTextStyle.largeRegular
            .copyWith(fontSize: 16, color: color_hint_text),

        labelStyle: AppTextStyle.largeRegular
            .copyWith(fontSize: 16, color: color_hint_text),

      ),
    );
  }



}
