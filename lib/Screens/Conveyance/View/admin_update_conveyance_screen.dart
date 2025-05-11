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
import '../../../Widget/common_widget.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/admin_create_conveyance_request.dart';
import '../Model/conveyance_list_response.dart';

class AdminUpdateConveyanceScreen extends StatefulWidget {
  @override
  _AdminUpdateConveyanceScreenState createState() => _AdminUpdateConveyanceScreenState();
}

class _AdminUpdateConveyanceScreenState extends State<AdminUpdateConveyanceScreen> {
  ConveyanceController conveyanceController = Get.find<ConveyanceController>();
  String? selectedConveyanceThrough;
  String? selectedConveyanceName;
  String? selectedSite;

  DateTime? selectedDate;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // Bottom-only border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                selectedDate == null
                    ? 'Select Conveyance Date'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
                style: AppTextStyle.largeMedium.copyWith(
                    fontSize: 15,
                    color:
                    selectedDate == null ? color_hint_text : Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      // Perform navigation or state updates after build completes
      conveyanceController.isEdit.value = false;

      await conveyanceController.callHeadConveyanceList();
      await conveyanceController.callConveyanceList();
      await conveyanceController.callSiteList();
      conveyanceController.conveyanceAmountController.value.text = conveyanceController.selectedAdminConveyance.value.amount??"";

      selectedConveyanceThrough =  conveyanceController.selectedAdminConveyance.value.headConveyanceId.toString();
      selectedConveyanceName =  conveyanceController.selectedAdminConveyance.value.conveyanceId.toString();
      selectedSite =  conveyanceController.selectedAdminConveyance.value.headId.toString();

      if((conveyanceController.selectedAdminConveyance.value.date??"").isNotEmpty){
        DateFormat format = DateFormat("dd-MM-yyyy");
        selectedDate = format.parse(conveyanceController.selectedAdminConveyance.value.date??"");

        setState(() {

        });
      }


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
            icon: Icon(Icons.edit_calendar, color: color_secondary),
            onPressed: () {
              conveyanceController.isEdit.value = true;
            },
          ),

          IconButton(
            icon: Icon(Icons.delete_forever, color: color_secondary),
            onPressed: () {
              Get.defaultDialog(
                  title: "DELETE",
                  middleText:
                  "Are you sure want to delete this Conveyance?",
                  barrierDismissible: false,
                  titlePadding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10),
                  textConfirm: "Yes",
                  textCancel: "No",
                  titleStyle: TextStyle(
                      fontSize: 15),
                  buttonColor: Colors.white,
                  confirmTextColor: color_primary,
                  onCancel: () {
                    Navigator.pop(context);

                  },
                  onConfirm: () async {
                    Navigator.pop(context);
                    conveyanceController.callAdminDeleteConveyance(conveyanceController.selectedAdminConveyance.value.id.toString());

                  });
            },
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


                _buildDatePicker(),

                SizedBox(
                  height: 20,
                ),

                _buildConveyorNameDropdown(conveyanceController.conveysList, selectedSite,
                        (val) {

                      setState(() {

                        selectedConveyanceName = val;

                      });

                    } , "Conveyor Name"),

                SizedBox(
                  height: 20,
                ),



                _buildDropdown(conveyanceController.headConveysList, selectedConveyanceThrough,
                    (val) => setState(() => selectedConveyanceThrough = val), "Conveyance Through"),

                SizedBox(
                  height: 16,
                ),


                _buildSiteDropdown(conveyanceController.siteList, selectedSite,
                        (val) {

                      setState(() {
                        selectedSite = val;
                      });

                    } , "Select Site"),


                SizedBox(height: 16),

                _buildTextField(
                    conveyanceController.conveyanceAmountController.value,
                    "Conveyance Amount"
                ),


                SizedBox(
                  height: 20,
                ),

                // Login Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CommonButton(
                    titleText: "Save",
                    textColor: Colors.white,
                    onCustomButtonPressed: () async {

                      if(selectedDate == null){
                        snackBar(context, "Select Date");
                        return;
                      }

                      if(selectedSite == null){
                        snackBar(context, "Select Site");
                        return;
                      }


                      if(selectedConveyanceName == null){
                        snackBar(context, "Select Conveyance Name");
                        return;
                      }

                      if(selectedConveyanceThrough == null){
                        snackBar(context, "Select Conveyor Through");
                        return;
                      }


                      if(conveyanceController.conveyanceAmountController.value.text.isEmpty){
                        snackBar(context, "Enter Conveyance Amount");
                        return;
                      }


                      conveyanceController.adminCreateConveyanceRequest.value = AdminCreateConveyanceRequest();
                      conveyanceController.adminCreateConveyanceRequest.value.id = conveyanceController.selectedAdminConveyance.value.id.toString();
                      conveyanceController.adminCreateConveyanceRequest.value.headConveyanceId = selectedConveyanceThrough??"";
                      conveyanceController.adminCreateConveyanceRequest.value.conveyanceId = selectedConveyanceName??"";
                      conveyanceController.adminCreateConveyanceRequest.value.headId = selectedSite??"";
                      conveyanceController.adminCreateConveyanceRequest.value.amount = conveyanceController.conveyanceAmountController.value.text;
                      conveyanceController.adminCreateConveyanceRequest.value.date = DateFormat('dd-MM-yyyy').format(selectedDate!);

                      conveyanceController.callAdminEditConveyance();

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


  Widget _buildSiteDropdown(List<SiteData> items, String? selectedValue,
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
      items: items
          .map((e) => DropdownMenuItem(
          value: e.id.toString(), child: Text(e.headName ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildConveyorNameDropdown(List<ConveyanceData> items, String? selectedValue,
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
