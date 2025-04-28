import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/Controller/emp_leave_request_controller.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/Model/add_leave_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';

class EmpAddLeaveRequestScreen extends StatefulWidget {
  @override
  _EmpAddLeaveRequestScreenState createState() => _EmpAddLeaveRequestScreenState();
}

class _EmpAddLeaveRequestScreenState extends State<EmpAddLeaveRequestScreen> {
  EmpLeaveRequestController empLeaveRequestController =
      Get.find<EmpLeaveRequestController>();

  DateTime? fromDate;
  DateTime? toDate;

  String selectedOption = "1";


  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
      });
    }
  }



  void _pickToDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        toDate = picked;
      });
    }
  }


  @override
  void initState() {
    super.initState();

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
          'Leave Request',
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
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),

                    _buildSectionTitle("Leave Request For"),

                    Column(
                      children: [

                        ListTile(
                          title: Text('One Day'),
                          leading: Radio<String>(
                            value: '1',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                empLeaveRequestController.controllerNumOfLeaves.value.text = "1";
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('More Days'),
                          leading: Radio<String>(
                            value: '2',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                        ),

                      ],
                    ),


                    SizedBox(
                      height: 22,
                    ),


                    _buildDatePicker(),

                    SizedBox(
                      height: 28,
                    ),

                    _buildToDatePicker(),

                    SizedBox(
                      height: 12,
                    ),


                   selectedOption == "2"?  Column(
                     children: [

                       _buildTextField(
                           empLeaveRequestController.controllerNumOfLeaves.value,
                           "No Of Leave Days"
                       ),

                       SizedBox(height: 16,),
                     ],
                   ):SizedBox(),


                    _buildTextField(
                        empLeaveRequestController.controllerReason.value,
                        "Reason"
                    ),

                    SizedBox(
                      height: 22,
                    ),

                    _buildTextFieldOnlyReadable(
                        empLeaveRequestController.controllerNameOfEmp.value,
                        "Requested By"
                    ),

                    SizedBox(
                      height: 28,
                    ),

                    // Login Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {

                          if(fromDate == null){
                            snackBar(context, "Select From Date");
                            return;
                          }

                          if(selectedOption == "2"){
                            if(toDate == null){
                              snackBar(context, "Select To Date");
                              return;
                            }


                            if(empLeaveRequestController.controllerNumOfLeaves.value.text.isEmpty){
                              snackBar(context, "Enter No Days");
                              return;
                            }

                          }

                          if(empLeaveRequestController.controllerReason.value.text.isEmpty){
                            snackBar(context, "Enter reason");
                            return;
                          }


                          empLeaveRequestController.addLeaveRequest.value = AddLeaveRequest();
                          empLeaveRequestController.addLeaveRequest.value.empId = empLeaveRequestController.loginData.value.id.toString();
                          empLeaveRequestController.addLeaveRequest.value.fromDate = DateFormat('dd-MM-yyyy').format(fromDate!);
                          empLeaveRequestController.addLeaveRequest.value.toDate = DateFormat('dd-MM-yyyy').format(toDate!);
                          empLeaveRequestController.addLeaveRequest.value.reason = empLeaveRequestController.controllerReason.value.text;
                          empLeaveRequestController.addLeaveRequest.value.numberOfLeaveDays = empLeaveRequestController.controllerNumOfLeaves.value.text;
                          empLeaveRequestController.addLeaveRequest.value.leaveRequestType = selectedOption;

                          empLeaveRequestController.callCreateService();

                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),
                  ],
                ),
              ),
         if(empLeaveRequestController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
          AppTextStyle.largeRegular.copyWith(fontSize: 17, color: Colors.black),
    );
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
                fromDate == null
                    ? 'Select From Date'
                    : DateFormat('dd/MM/yyyy').format(fromDate!),
                style: AppTextStyle.largeMedium.copyWith(
                    fontSize: 15,
                    color:
                        fromDate == null ? color_hint_text : Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildToDatePicker() {
    return GestureDetector(
      onTap: _pickToDate,
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
                toDate == null
                    ? 'Select To Date'
                    : DateFormat('dd/MM/yyyy').format(toDate!),
                style: AppTextStyle.largeMedium.copyWith(
                    fontSize: 15,
                    color:
                    toDate == null ? color_hint_text : Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<SiteData> items, String? selectedValue,
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


  Widget _buildDropdownContactList(List<AppointmentContactData> items, String? selectedValue,
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
          value: e.id.toString(), child: Text(e.contactName ?? "")))
          .toList(),
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


  Widget _buildTextFieldOnlyReadable(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      readOnly: true, // Makes the field non-editable
      onTap: (){

      },
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
