import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';

class EditAppointmentScreen extends StatefulWidget {
  @override
  _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  AppointmentController appointmentController =
      Get.find<AppointmentController>();

  DateTime? selectedDate;
  TimeOfDay? siteInTime;
  TimeOfDay? siteOutTime;
  String? attendanceStatus;
  String? selectedSite;
  String? contactPerson;


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

  void _pickTime(bool isInTime) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isInTime) {
          siteInTime = picked;
        } else {
          siteOutTime = picked;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    appointmentController.isEdit.value = false;
    appointmentController.siteList.clear();
    appointmentController.appointmentContactList.clear();

    initialize();


  }

  initialize() async{


    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await appointmentController.callSiteList();

      selectedSite = appointmentController.selectedAppointment.value.siteId.toString();

      await appointmentController.callContactListList(selectedSite??"");

      contactPerson =  appointmentController.selectedAppointment.value.headId.toString();

      if((appointmentController.selectedAppointment.value.date??"").isNotEmpty){
        DateFormat format = DateFormat("dd-MM-yyyy");
        selectedDate = format.parse(appointmentController.selectedAppointment.value.date??"");

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
          'Appointment',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar, color: color_secondary),
            onPressed: () {
              appointmentController.isEdit.value = true;
            },
          ),

          IconButton(
            icon: Icon(Icons.delete_forever, color: color_secondary),
            onPressed: () {
              Get.defaultDialog(
                  title: "DELETE",
                  middleText:
                  "Are you sure want to delete this Appointment?",
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
                    appointmentController.callDeleteAppointment(appointmentController.selectedAppointment.value.id.toString());

                  });
            },
          ),
        ],
      ),
      body: Obx(() => Stack(
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
                      height: 28,
                    ),

                    _buildDropdown(appointmentController.siteList, selectedSite,
                        (val) {

                          setState(() {
                            appointmentController.appointmentContactList.clear();
                            selectedSite = val;
                            contactPerson = null;

                            printData("here", "contactPerson null");
                          });


                          appointmentController.callContactListList(selectedSite??"");

                        } , "Select Site"),

                    SizedBox(
                      height: 28,
                    ),

                    _buildDropdownContactList(appointmentController.appointmentContactList, contactPerson,
                            (val) {

                          setState(() {
                            contactPerson = val;

                          });

                        } , "Select Contact Person"),



                    SizedBox(
                      height: 20,
                    ),

                    // Login Button
                    appointmentController.isEdit.value?Padding(
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

                          if(contactPerson == null){
                            snackBar(context, "Select Contact Person");
                            return;
                          }


                          appointmentController.createAppointmentRequest.value = CreateAppointmentRequest();
                          appointmentController.createAppointmentRequest.value.id = appointmentController.selectedAppointment.value.id.toString();
                              appointmentController.createAppointmentRequest.value.siteId = selectedSite;
                          appointmentController.createAppointmentRequest.value.headId = contactPerson;
                          appointmentController.createAppointmentRequest.value.date = DateFormat('dd-MM-yyyy').format(selectedDate!);
                          appointmentController.callUpdateAppointment();

                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ):Center(),
                  ],
                ),
              ),
         if(appointmentController.isLoading.value)Center(child: CircularProgressIndicator(),)
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
                selectedDate == null
                    ? 'Select Appointment Date'
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
}
