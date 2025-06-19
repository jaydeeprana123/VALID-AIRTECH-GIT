import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/work_report_list_response.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Sites/Model/site_list_response.dart';

class AddWorkReportScreen extends StatefulWidget {
  final String attendanceId;
  final String date;
  final String siteId;

  AddWorkReportScreen(
      {Key? key,
      required this.attendanceId,
      required this.date,
      required this.siteId})
      : super(key: key);

  @override
  _AddWorkReportScreenState createState() => _AddWorkReportScreenState();
}

class _AddWorkReportScreenState extends State<AddWorkReportScreen> {
  WorkReportController workReportController = Get.find<WorkReportController>();

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
    // TODO: implement initState
    super.initState();

    workReportController.callSiteList();
    workReportController.callSiteAttendByList();
    workReportController.callTestPerformerList();
    workReportController.callServiceByNatureByList();

    workReportController.remarksList.clear();
    workReportController.billsList.clear();
    workReportController.remarksList.add(RemarkWorkReport());
    workReportController.billsList.add(WorkReportExpensesBill());
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
          'Add Work Report',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12,
                    ),

                    _buildTextFieldOnlyReadableDate(
                        TextEditingController(text: widget.date),
                        "Work Reporting Date"),

                    SizedBox(
                      height: 28,
                    ),

                    _buildDropdownSite(
                        workReportController.siteList, selectedSite, (val) {
                      setState(() {
                        selectedSite = val;
                      });
                    }, "Select Site"),

                    SizedBox(
                      height: 28,
                    ),

                    _buildDropdownConveyanceThrough(
                        workReportController.conveyThroughList,
                        selectedSite,
                        (val) => setState(() => selectedSite = val),
                        "Select Conveyance"),

                    SizedBox(
                      height: 28,
                    ),

                    _buildSectionTitle('Remarks'),

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
                              i < workReportController.remarksList.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildTextField(
                                            workReportController.remarksList[i]
                                                .remarkTextEditingController,
                                            'Remarks ${i + 1}')),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    (i ==
                                            (workReportController
                                                    .remarksList.length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              workReportController.remarksList
                                                  .add(RemarkWorkReport());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              workReportController.remarksList
                                                  .removeAt(i);
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
                      height: 28,
                    ),

                    _buildSectionTitle('Expenses'),

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
                          _buildTextField(
                              workReportController.controllerTrain.value,
                              "Train"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController.controllerBus.value, "Bus"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController.controllerAuto.value,
                              "Auto"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController.controllerFuel.value,
                              "Fuel"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController.controllerFoodAmount.value,
                              "Food Amount"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController.controllerOther.value,
                              "Other"),
                          SizedBox(
                            height: 12,
                          ),
                          _buildTextField(
                              workReportController
                                  .controllerRemarksForOther.value,
                              "Remarks For Others"),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 28,
                    ),

                    _buildSectionTitle('Expenses Bills'),

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
                              i < workReportController.billsList.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () async {
                                        workReportController.billsList[i].path =
                                            await selectPhoto(context);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 160,
                                        child: Stack(
                                          children: [
                                            (workReportController.billsList[i]
                                                            .path ??
                                                        "")
                                                    .isNotEmpty
                                                ? Image.file(
                                                    File(workReportController
                                                            .billsList[i]
                                                            .path ??
                                                        ""),
                                                    fit: BoxFit.cover,
                                                    height: 160,
                                                    width: double.infinity,
                                                  )
                                                : Container(
                                                    width: double.infinity,
                                                    height: 150,
                                                    color: Colors.grey.shade300,
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                  ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 30,
                                                  color: color_primary,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          workReportController.billsList
                                              .removeAt(i);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          size: 30,
                                          color: color_primary,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildTextField(
                                            workReportController.billsList[i]
                                                .billNameTextEditingController,
                                            'Bill Name ${i + 1}')),
                                    if (i ==
                                        (workReportController.billsList.length -
                                            1))
                                      Container(
                                        margin: EdgeInsets.only(left: 12),
                                        child: InkWell(
                                            onTap: () {
                                              workReportController.billsList
                                                  .add(
                                                      WorkReportExpensesBill());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            )),
                                      )
                                  ],
                                ),
                                if (i !=
                                    (workReportController.billsList.length - 1))
                                  SizedBox(
                                    height: 28,
                                  ),
                              ],
                            )
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Login Button
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          if (workReportController.remarksList.isEmpty) {
                            snackBar(context, "Please add remark");
                            return;
                          }

                          workReportController.callCreateWorkReportList(
                              widget.attendanceId, widget.siteId);
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ),
                  ],
                ),
              ),
              if (workReportController.isLoading.value)
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
                    ? 'Select Work Reporting Date'
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

  Widget _buildDropdownConveyanceThrough(List<String> items,
      String? selectedValue, Function(String?) onChanged, String hint) {
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
                  style: AppTextStyle.largeMedium.copyWith(
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
        hintStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 16, color: color_hint_text),

        labelStyle: AppTextStyle.largeMedium
            .copyWith(fontSize: 16, color: color_hint_text),
      ),
    );
  }

  Widget _buildTextFieldOnlyReadableDate(
      TextEditingController controller, String hint) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: true, // Makes the field non-editable
            onTap: () {},
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
          ),
        ),
        Icon(Icons.calendar_month_sharp, color: Colors.red),
      ],
    );
  }
}
