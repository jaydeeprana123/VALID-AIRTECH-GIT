import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Head/Model/head_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Model/create_instrument_request.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import 'package:valid_airtech/Screens/WorkmanProfile/Controller/workman_profile_controller.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/add_childern_model.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/create_workman_request.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/workman_list_response.dart';

class AddWorkmanScreen extends StatefulWidget {
  @override
  _AddWorkmanScreenState createState() => _AddWorkmanScreenState();
}

class _AddWorkmanScreenState extends State<AddWorkmanScreen> {
  WorkmanProfileController workmanController = Get.find<WorkmanProfileController>();
  String? selectedInstrumentName;
  DateTime? selectedDate;
  String? selectedBloodGroup; // Initially null

  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      workmanController.childrenList.clear();
      workmanController.childrenList.add(AddChildrenModel());

      clearField();

      // Perform navigation or state updates after build completes
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
          'Workman Details',
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

                _buildTextField(
                  workmanController.nameController.value,
                  "Workman Name"
                    ),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.userNameController.value,
                    "Workman Username"
                ),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.contactNoController.value,
                    "Workman Contact No"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.workmanNoController.value,
                    "Workman No."
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.workmanPasswordController.value,
                    "Workman Password"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildMultilineTextField(
                    workmanController.permanentAddressController.value,
                    "Permanent Address"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildMultilineTextField(
                    workmanController.residentAddressController.value,
                    "Resident Address"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildDatePicker(),


                SizedBox(
                  height: 16,
                ),


                DropdownButton<String>(
                  value: workmanController.bloodGroups
                      .contains(selectedBloodGroup)
                      ? selectedBloodGroup
                      : null,
                  // Ensure valid value
                  hint: Text("Select Blood Group"),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBloodGroup = newValue;
                    });
                  },
                  items: workmanController.bloodGroups.map((String group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: Text(group),
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: 16,
                ),


                _buildTextFieldOnlyReadableStartTime(
                    workmanController.startTimeController.value,
                    "Start Time"
                ),

                SizedBox(
                  height: 16,
                ),


                _buildTextFieldOnlyReadableEndTime(
                    workmanController.endTimeController.value,
                    "End Time"
                ),
                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.aadharCardNoController.value,
                    "Aadhar Card No."
                ),

                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.licenseNoController.value,
                    "License No."
                ),


                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.epfNoController.value,
                    "EPF No."
                ),


                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.esiNoController.value,
                    "ECI No."
                ),


                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.bankNameController.value,
                    "Bank Name"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.ifscCodeController.value,
                    "Bank IFSC Code"
                ),


                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.accountNoController.value,
                    "Bank Account No."
                ),


                SizedBox(
                  height: 16,
                ),

                _buildTextField(
                    workmanController.fatherNameController.value,
                    "Father Name"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.fatherAadharCardNoController.value,
                    "Father Aadhar Card No."
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.motherNameController.value,
                    "Mother Name"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.motherAadharCardNoController.value,
                    "Mother Aadhar Card No."
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.wifeNameController.value,
                    "Wife Name"
                ),


                SizedBox(
                  height: 16,
                ),


                _buildTextField(
                    workmanController.wifeAadharCardNoController.value,
                    "Wife Aadhar Card No."
                ),
                
                SizedBox(
                  height: 20,
                ),


                _buildSectionTitle("Children's"),


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
                      i < workmanController.childrenList.length;
                      i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child:  _buildTextField(
                                      workmanController.childrenList[i].textEditingControllerName,
                                      'Children ${i + 1}'),),


                                SizedBox(width: 16,),
                                

                                (i ==
                                    (workmanController.childrenList.length - 1))?
                                InkWell(
                                    onTap: () {
                                      workmanController.childrenList
                                          .add(AddChildrenModel());
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: color_brown_title,
                                    )):InkWell(
                                    onTap: () {
                                      workmanController.childrenList.removeAt(i);
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

                      validateWorkmanDetails(context);

                      workmanController.createWorkmanRequest.value = CreateWorkmanRequest();
                      workmanController.createWorkmanRequest.value.name = workmanController.nameController.value.text;
                      workmanController.createWorkmanRequest.value.userName = workmanController.userNameController.value.text;
                      workmanController.createWorkmanRequest.value.mobileNumber = workmanController.contactNoController.value.text;
                      workmanController.createWorkmanRequest.value.workmanNo = workmanController.workmanNoController.value.text;
                      workmanController.createWorkmanRequest.value.password = workmanController.workmanPasswordController.value.text;
                      workmanController.createWorkmanRequest.value.permanetAddress = workmanController.permanentAddressController.value.text;
                      workmanController.createWorkmanRequest.value.residentAddress = workmanController.residentAddressController.value.text;
                      workmanController.createWorkmanRequest.value.dateOfBirth = DateFormat('dd-MM-yyyy').format(selectedDate!);
                      workmanController.createWorkmanRequest.value.addharNo = workmanController.aadharCardNoController.value.text;
                      workmanController.createWorkmanRequest.value.licenceNo = workmanController.licenseNoController.value.text;
                      workmanController.createWorkmanRequest.value.epfNo = workmanController.epfNoController.value.text;
                      workmanController.createWorkmanRequest.value.esiNo = workmanController.esiNoController.value.text;
                      workmanController.createWorkmanRequest.value.bankName = workmanController.bankNameController.value.text;
                      workmanController.createWorkmanRequest.value.ifscCode = workmanController.ifscCodeController.value.text;
                      workmanController.createWorkmanRequest.value.bankAccountNo = workmanController.accountNoController.value.text;
                      workmanController.createWorkmanRequest.value.fatherName = workmanController.fatherNameController.value.text;
                      workmanController.createWorkmanRequest.value.fatherAddharNo = workmanController.fatherAadharCardNoController.value.text;
                      workmanController.createWorkmanRequest.value.motherName = workmanController.motherNameController.value.text;
                      workmanController.createWorkmanRequest.value.motherAddharNo = workmanController.motherAadharCardNoController.value.text;
                      workmanController.createWorkmanRequest.value.wifeName = workmanController.wifeNameController.value.text;
                      workmanController.createWorkmanRequest.value.wifeAddharNo = workmanController.wifeAadharCardNoController.value.text;
                      if(selectedBloodGroup != null){
                        workmanController
                            .createWorkmanRequest.value.bloodGroup =
                            ((workmanController.bloodGroups.value.indexOf(selectedBloodGroup??"")) +1).toString();

                      }

                      workmanController
                          .createWorkmanRequest.value.startTime =  workmanController.startTimeController.value.text;
                      workmanController
                          .createWorkmanRequest.value.endTime =  workmanController.endTimeController.value.text;

                      workmanController
                          .createWorkmanRequest.value.status = "1";

                      workmanController.createWorkmanRequest.value.children = [];
                      
                      for(int i=0; i<workmanController.childrenList.length; i++){
                        Children child = Children();
                        child.childrenName = workmanController.childrenList[i].textEditingControllerName.text;

                        workmanController.createWorkmanRequest.value.children?.add(child);

                      }
                      
                      
                      workmanController.callCreateWorkman();

                    },
                    borderColor: color_primary,
                    borderWidth: 0,
                  ),
                ),
              ],
            ),
          ),

          if(workmanController.isLoading.value)Center(child: CircularProgressIndicator(),)
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


  Widget _buildDropdown(List<HeadInstrumentData> items, String? selectedValue,
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

  Widget _buildMultilineTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      maxLines: 5,
      minLines: 5,
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
            Text(selectedDate == null ? 'Select Birth Date' : DateFormat('dd-MM-yyyy').format(selectedDate!),
                style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                    , color: selectedDate == null ?color_hint_text:Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

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

  void clearField() {
    workmanController.nameController.value.text = "";
    workmanController.userNameController.value.text = "";
    workmanController.contactNoController.value.text = "";
    workmanController.workmanNoController.value.text = "";
    workmanController.permanentAddressController.value.text = "";
    workmanController.residentAddressController.value.text = "";
    workmanController.aadharCardNoController.value.text = "";
    workmanController.licenseNoController.value.text = "";
    workmanController.epfNoController.value.text = "";
    workmanController.esiNoController.value.text = "";
    workmanController.bankNameController.value.text = "";
    workmanController.ifscCodeController.value.text = "";
    workmanController.accountNoController.value.text = "";
    workmanController.fatherNameController.value.text = "";
    workmanController.fatherAadharCardNoController.value.text = "";
    workmanController.motherNameController.value.text = "";
    workmanController.motherAadharCardNoController.value.text = "";
    workmanController.wifeNameController.value.text = "";
    workmanController.wifeAadharCardNoController.value.text = "";
    workmanController.birthDateController.value.text = "";


  }


  Widget buildDropdown(String label, List<String> items, RxString selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        Obx(() => DropdownButton<String>(
          value: selectedValue.value,
          isExpanded: true,
          onChanged: (newValue) {
            setState(() {
              selectedValue.value = newValue!;
            });
          },
          items: items.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        SizedBox(height: 10),
      ],
    );
  }

  void validateWorkmanDetails(BuildContext context) {
    // Define all controllers and their respective field names
    Map<TextEditingController, String> fields = {
      workmanController.nameController.value: "Please enter name",
      workmanController.workmanPasswordController.value: "Please enter password",
      workmanController.userNameController.value: "Please enter username",
      workmanController.contactNoController.value: "Please enter contact number",
      workmanController.workmanNoController.value: "Please enter workman number",
      workmanController.permanentAddressController.value: "Please enter permanent address",
      workmanController.residentAddressController.value: "Please enter resident address",
      workmanController.aadharCardNoController.value: "Please enter Aadhar number",
      workmanController.licenseNoController.value: "Please enter license number",
      workmanController.epfNoController.value: "Please enter EPF number",
      workmanController.esiNoController.value: "Please enter ESI number",
      workmanController.bankNameController.value: "Please enter bank name",
      workmanController.ifscCodeController.value: "Please enter IFSC code",
      workmanController.accountNoController.value: "Please enter account number",
      workmanController.fatherNameController.value: "Please enter father’s name",
      workmanController.fatherAadharCardNoController.value: "Please enter father’s Aadhar number",
      workmanController.motherNameController.value: "Please enter mother’s name",
      workmanController.motherAadharCardNoController.value: "Please enter mother’s Aadhar number",
      workmanController.wifeNameController.value: "Please enter wife’s name",
      workmanController.wifeAadharCardNoController.value: "Please enter wife’s Aadhar number",
      workmanController.birthDateController.value: "Please enter birth date",
      workmanController.startTimeController.value: "Please enter start time",
      workmanController.endTimeController.value: "Please enter end time",
    };


    bool isValid = true;

    // Loop through all controllers and validate
    for (var entry in fields.entries) {
      if (entry.key.text.trim().isEmpty) {
        isValid = false;
        snackBar(context, entry.value); // Show respective error message
        return;
      }
    }

    if(!isValid){
      return;
    }

    // If all fields are filled, proceed
    print("All fields are valid!");
  }

  Widget _buildTextFieldOnlyReadableStartTime(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      readOnly: true, // Makes the field non-editable
      onTap: (){
        _selectTime(context);
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
  Widget _buildTextFieldOnlyReadableEndTime(TextEditingController controller, String hint) {
    return TextField(
      controller:  controller,
      readOnly: true, // Makes the field non-editable
      onTap: (){
        selectTimeEnd(context);
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


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      printData("picked","picked");
      setState(() {
        _selectedTime = picked;
        final now = DateTime.now();
        final formattedTime = DateFormat("HH:mm:ss").format(
          DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute),
        );
        workmanController.startTimeController.value.text = formattedTime;

        printData("startTimeController",workmanController.startTimeController.value.text);
      });
    }else{

      final now = DateTime.now();
      final formattedTime = DateFormat("HH:mm:ss").format(
        DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute),
      );

      workmanController.startTimeController.value.text = formattedTime;
      printData("picked","nnpicked");
    }
  }

  Future<void> selectTimeEnd(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,

    );

    if (picked != null && picked != selectedEndTime) {
      setState(() {



        selectedEndTime = picked;
        final now = DateTime.now();
        final formattedTime = DateFormat("HH:mm:ss").format(
          DateTime(now.year, now.month, now.day, selectedEndTime.hour, selectedEndTime.minute),
        );

        workmanController.endTimeController.value.text = formattedTime;
      });
    }else{
      final now = DateTime.now();
      final formattedTime = DateFormat("HH:mm:ss").format(
        DateTime(now.year, now.month, now.day, selectedEndTime.hour, selectedEndTime.minute),
      );

      printData("picked","nnpicked" + (selectedEndTime.format(context)));
      workmanController.endTimeController.value.text = formattedTime;
    }
  }
}
