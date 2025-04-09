import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/add_planning_request.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../../Appointment/Model/appointment_contact_list_response.dart';
import '../../Instruments/Model/isntrument_list_response.dart';
import '../../Sites/Model/site_list_response.dart';

class AddPlanningScreen extends StatefulWidget {
  @override
  _AddPlanningScreenState createState() => _AddPlanningScreenState();
}

class _AddPlanningScreenState extends State<AddPlanningScreen> {
  PlanningController planningController = Get.find<PlanningController>();

  DateTime? selectedDate;
  TimeOfDay? siteInTime;
  TimeOfDay? siteOutTime;
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
    // TODO: implement initState
    super.initState();


    planningController.selectedInstrumentList.clear();
    planningController.selectedInstrumentList.add(AddInstrumentForPlanning());
    planningController.selectedConveysList.clear();
    planningController.selectedConveysList.add(AddConveyanceForPlanning());
    planningController.selectedWorkmanList.clear();
    planningController.selectedWorkmanList.add(AddWorkman());
    planningController.notesList.clear();
    planningController.notesList.add(TextEditingController());


    planningController.callSiteList();
    planningController.callWorkmanList();
    planningController.callHeadConveyanceList();
    planningController.callConveyanceList();
    planningController.callHeadInstrumentList();
    planningController.callInstrumentList();

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
          'Add Appointment',
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

                _buildDatePicker(),

                SizedBox(
                  height: 28,
                ),

                _buildDropdownSite(planningController.siteList, selectedSite,
                        (val) {

                      setState(() {
                        planningController.appointmentContactList.clear();
                        selectedSite = val;
                        contactPerson = null;

                        printData("here", "contactPerson null");
                      });


                      planningController.callContactListList(selectedSite??"");

                    } , "Select Site"),

                SizedBox(
                  height: 28,
                ),

                _buildDropdownContactList(planningController.appointmentContactList, contactPerson,
                        (val) {

                      setState(() {
                        contactPerson = val;

                      });

                    } , "Select Contact Person"),


                SizedBox(
                  height: 38,
                ),

                _buildSectionTitle("Workman's"),

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
                          i < planningController.selectedWorkmanList.length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: _buildDropdownWorkman(planningController.workmanList, planningController.selectedWorkmanList[i].workmanId,
                                            (val) {

                                          setState(() {
                                            planningController.selectedWorkmanList[i].workmanId = val;

                                          });

                                        } , "Workman ${i + 1}"),),
                                 (i ==
                                    (planningController.selectedWorkmanList.length - 1))?
                                  InkWell(
                                      onTap: () {
                                        planningController.selectedWorkmanList
                                            .add(AddWorkman());
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: color_brown_title,
                                      )):InkWell(
                                     onTap: () {
                                       planningController.selectedWorkmanList.removeAt(i);
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

                SizedBox(
                  height: 38,
                ),

                _buildSectionTitle("Conveyance's"),

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
                          i < planningController.selectedConveysList.length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    _buildDropdownConveyThroughList(planningController.headConveysList, planningController.selectedConveysList[i].headId,
                                            (val) {

                                          setState(() {
                                            planningController.selectedConveysList[i].headId = val;
                                            planningController.filteredConveysList.clear();
                                            planningController.callFilterConveyanceList(val??"");


                                          });

                                        } , "Conveyance Through ${i + 1}"),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    _buildDropdownConveyorList(planningController.filteredConveysList, planningController.selectedConveysList[i].conveyanceId,
                                            (val) {

                                          setState(() {
                                            planningController.selectedConveysList[i].conveyanceId = val;

                                          });

                                        } , "Conveyor Name ${i + 1}"),
                                  ],
                                )),

                                 SizedBox(width: 12,),
                                 (i ==
                                    (planningController.selectedConveysList.length - 1))?
                                  InkWell(
                                      onTap: () {
                                        planningController.selectedConveysList
                                            .add(AddConveyanceForPlanning());
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: color_brown_title,
                                      )): InkWell(
                                     onTap: () {
                                       planningController.selectedConveysList.removeAt(i);
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
                              height: 24,
                            ),
                          ],
                        )
                    ],
                  ),
                ),


                SizedBox(
                  height: 38,
                ),

                _buildSectionTitle("Instrument's"),

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
                      i < planningController.selectedInstrumentList.length;
                      i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                      children: [
                                        _buildDropdownInstrumentHeadList(planningController.headInstrumentList, planningController.selectedInstrumentList[i].headId,
                                                (val) {

                                              setState(() {
                                                planningController.selectedInstrumentList[i].headId = val;
                                                planningController.filteredInstrumentList.clear();
                                                planningController.callFilterInstrumentList(val??"");
                                              });

                                            } , "Instrument Name ${i + 1}"),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        _buildDropdownInstrumentList(planningController.filteredInstrumentList, planningController.selectedInstrumentList[i].instrumentId,
                                                (val) {

                                              setState(() {
                                                planningController.selectedInstrumentList[i].instrumentId = val;

                                              });

                                            } , "Instrument ID. ${i + 1}"),
                                      ],
                                    )),

                                SizedBox(width: 12,),
                                (i ==
                                    (planningController.selectedInstrumentList.length - 1))?
                                InkWell(
                                    onTap: () {
                                      planningController.selectedInstrumentList
                                          .add(AddInstrumentForPlanning());
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: color_brown_title,
                                    )): InkWell(
                                    onTap: () {
                                      planningController.selectedInstrumentList.removeAt(i);
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
                              height: 24,
                            ),
                          ],
                        )
                    ],
                  ),
                ),


                SizedBox(
                  height: 38,
                ),

                _buildSectionTitle("Note's"),

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
                      i < planningController.notesList.length;
                      i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: _buildTextField(
                                        planningController.notesList[i],
                                        'Note ${i + 1}')),

                                 SizedBox(width: 12,),

                                 (i ==
                                    (planningController.notesList.length - 1))?
                                  InkWell(
                                      onTap: () {
                                        planningController.notesList
                                            .add(TextEditingController());
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: color_brown_title,
                                      )):  InkWell(
                                     onTap: () {
                                       planningController.notesList.removeAt(i);
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


                SizedBox(
                  height: 20,
                ),

                // Login Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CommonButton(
                    titleText: "Save",
                    textColor: Colors.white,
                    onCustomButtonPressed: () async {},
                    borderColor: color_primary,
                    borderWidth: 0,
                  ),
                ),
              ],
            ),
          ),

          if(planningController.isLoading.value)Center(child: CircularProgressIndicator(),)
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
                    ? 'Select Planning Date'
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



  Widget _buildDropdownWorkman(List<WorkmanData> items, String? selectedValue,
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

  Widget _buildDropdownSite(List<SiteData> items, String? selectedValue,
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

  Widget _buildDropdownConveyThroughList(List<HeadConveyanceData> items, String? selectedValue,
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
          value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownConveyorList(List<ConveyanceData> items, String? selectedValue,
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
          value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }



  Widget _buildDropdownInstrumentHeadList(List<HeadInstrumentData> items, String? selectedValue,
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
          value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownInstrumentList(List<InstrumentData> items, String? selectedValue,
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
          value: e.id.toString(), child: Text(e.instrumentIdNo ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }



  Widget _buildDropdown(List<String> items, String? selectedValue,
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
