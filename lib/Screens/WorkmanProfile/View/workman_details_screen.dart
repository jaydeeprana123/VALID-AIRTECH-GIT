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
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Sites/Model/add_contact_model.dart';
import '../Model/workman_list_response.dart';

class WorkmanDetailsScreen extends StatefulWidget {
  @override
  _WorkmanDetailsScreenState createState() => _WorkmanDetailsScreenState();
}

class _WorkmanDetailsScreenState extends State<WorkmanDetailsScreen> {
  WorkmanProfileController workmanController =
      Get.find<WorkmanProfileController>();
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
      workmanController.isEdit.value = false;
      workmanController.childrenList.clear();

      if((workmanController.selectedWorkman.value.dateOfBirth??"").isNotEmpty){
        DateFormat format = DateFormat("dd-MM-yyyy");
        selectedDate = format.parse(workmanController.selectedWorkman.value.dateOfBirth??"");

        setState(() {

        });
      }

      selectedBloodGroup =
          workmanController.selectedWorkman.value.bloodGroup ?? "";
      workmanController.nameController.value.text =
          workmanController.selectedWorkman.value.name ?? "";
      workmanController.userNameController.value.text =
          workmanController.selectedWorkman.value.userName ?? "";
      workmanController.contactNoController.value.text =
          workmanController.selectedWorkman.value.mobileNumber ?? "";
      workmanController.workmanNoController.value.text =
          workmanController.selectedWorkman.value.workmanNo ?? "";
      workmanController.permanentAddressController.value.text =
          workmanController.selectedWorkman.value.permanetAddress ?? "";
      workmanController.residentAddressController.value.text =
          workmanController.selectedWorkman.value.residentAddress ?? "";
      workmanController.aadharCardNoController.value.text =
          workmanController.selectedWorkman.value.addharNo ?? "";
      workmanController.licenseNoController.value.text =
          workmanController.selectedWorkman.value.licenceNo ?? "";
      workmanController.epfNoController.value.text =
          workmanController.selectedWorkman.value.epfNo ?? "";
      workmanController.esiNoController.value.text =
          workmanController.selectedWorkman.value.esiNo ?? "";
      workmanController.bankNameController.value.text =
          workmanController.selectedWorkman.value.bankName ?? "";
      workmanController.ifscCodeController.value.text =
          workmanController.selectedWorkman.value.ifscCode ?? "";
      workmanController.accountNoController.value.text =
          workmanController.selectedWorkman.value.bankAccountNo ?? "";
      workmanController.fatherNameController.value.text =
          workmanController.selectedWorkman.value.fatherName ?? "";
      workmanController.fatherAadharCardNoController.value.text =
          workmanController.selectedWorkman.value.fatherAddharNo ?? "";
      workmanController.motherNameController.value.text =
          workmanController.selectedWorkman.value.motherName ?? "";
      workmanController.motherAadharCardNoController.value.text =
          workmanController.selectedWorkman.value.motherAddharNo ?? "";
      workmanController.wifeNameController.value.text =
          workmanController.selectedWorkman.value.wifeName ?? "";
      workmanController.wifeAadharCardNoController.value.text =
          workmanController.selectedWorkman.value.wifeAddharNo ?? "";
      workmanController.birthDateController.value.text =
          workmanController.selectedWorkman.value.dateOfBirth ?? "";

      workmanController.startTimeController.value.text =
          workmanController.selectedWorkman.value.startTime ?? "";
      workmanController.endTimeController.value.text =
          workmanController.selectedWorkman.value.endTime ?? "";

      if ((workmanController.selectedWorkman.value.children ?? []).isNotEmpty) {
        for (int i = 0;
            i < (workmanController.selectedWorkman.value.children ?? []).length;
            i++) {
          AddChildrenModel addChildrenModel = AddChildrenModel();
          addChildrenModel.id = workmanController
              .selectedWorkman.value.children?[i].id
              .toString();
          addChildrenModel.textEditingControllerName.text = workmanController
                  .selectedWorkman.value.children?[i].childrenName ??
              "";

          workmanController.childrenList.add(addChildrenModel);
        }
      } else {
        workmanController.childrenList.add(AddChildrenModel());
      }

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
          'My Profile',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,

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

                    _sectionTitle("Personal Details"),

                    _infoColumn(
                        workmanController.nameController.value, "Workman Name"),

                    SizedBox(
                      height: 16,
                    ),

                    // _infoColumn(
                    //     workmanController.emailController.value,
                    //     "Workman Email"
                    // ),
                    //
                    // SizedBox(
                    //   height: 16,
                    // ),



                    _infoColumn(workmanController.userNameController.value,
                        "Workman Username"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(workmanController.contactNoController.value,
                        "Workman Contact No"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(workmanController.workmanNoController.value,
                        "Workman No."),

                    SizedBox(
                      height: 16,
                    ),

                    // _infoColumn(
                    //     workmanController.workmanPasswordController.value,
                    //     "Workman Pin"),
                    //
                    // SizedBox(
                    //   height: 16,
                    // ),

                    _infoColumn(
                        workmanController.permanentAddressController.value,
                        "Permanent Address"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.residentAddressController.value,
                        "Resident Address"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.birthDateController.value,
                        "Birth Date"),

                    SizedBox(
                      height: 16,
                    ),




                    _infoColumn(
                      workmanController.startTimeController.value,
                      "Start Time"
                    ),

                    SizedBox(
                      height: 16,
                    ),


                    _infoColumn(
                        workmanController.endTimeController.value,
                        "End Time"
                    ),
                    SizedBox(
                      height: 16,
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Blood Group",
                          style: AppTextStyle.largeMedium
                              .copyWith(fontSize: 14, color: color_brown_title),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          selectedBloodGroup??"",
                          textAlign: TextAlign.right,
                          style: AppTextStyle.largeSemiBold
                              .copyWith(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Center(child: _sectionTitle("Document Detail")),

                    _infoColumn(
                        workmanController.aadharCardNoController.value,
                        "Aadhar Card No."),

                    SizedBox(
                      height: 16,
                    ),



                    _infoColumn(workmanController.licenseNoController.value,
                        "License No."),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.epfNoController.value, "EPF No."),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.esiNoController.value, "ECI No."),

                    SizedBox(
                      height: 16,
                    ),

                    Center(child: _sectionTitle("Bank Detail")),

                    _infoColumn(workmanController.bankNameController.value,
                        "Bank Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(workmanController.ifscCodeController.value,
                        "Bank IFSC Code"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(workmanController.accountNoController.value,
                        "Bank Account No."),

                    SizedBox(
                      height: 16,
                    ),

                    Center(child: _sectionTitle("Father's Detail")),

                    _infoColumn(
                        workmanController.fatherNameController.value,
                        "Father Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.fatherAadharCardNoController.value,
                        "Father Aadhar Card No."),

                    SizedBox(
                      height: 16,
                    ),


                    Center(child: _sectionTitle("Mother's Detail")),
                    _infoColumn(
                        workmanController.motherNameController.value,
                        "Mother Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.motherAadharCardNoController.value,
                        "Mother Aadhar Card No."),

                    SizedBox(
                      height: 16,
                    ),

                    Center(child: _sectionTitle("Wife's Detail")),


                    _infoColumn(workmanController.wifeNameController.value,
                        "Wife Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _infoColumn(
                        workmanController.wifeAadharCardNoController.value,
                        "Wife Aadhar Card No."),

                    SizedBox(
                      height: 20,
                    ),


                    Center(child: _sectionTitle("Children's Detail")),
                    SizedBox(
                      height: 4,
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: color_hint_text, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < workmanController.childrenList.length;
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _infoColumn(
                                      workmanController.childrenList[i]
                                          .textEditingControllerName,
                                      'Children ${i + 1}'),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              if (workmanController.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
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
                    ? 'Select Birth Date'
                    : DateFormat('dd-MM-yyyy').format(selectedDate!),
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

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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




  Widget _sectionTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          style: AppTextStyle.largeRegular
              .copyWith(fontSize: 18, color: color_secondary),
        ),
      ),
    );
  }

  Widget _infoColumn(TextEditingController controller,String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.largeMedium
              .copyWith(fontSize: 14, color: color_brown_title),
        ),
        SizedBox(
          height: 1,
        ),
        Text(
          controller.text,
          textAlign: TextAlign.right,
          style: AppTextStyle.largeSemiBold
              .copyWith(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

}
