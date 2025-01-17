import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';



class AddWorkReportScreen extends StatefulWidget {
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
  TextEditingController remarksController = TextEditingController();

  final List<String> attendanceOptions = ['Present', 'Absent', 'On Leave'];
  final List<String> siteOptions = ['Office', 'Factory', 'Field Work'];
  final List<String> contactPersons = ['John Doe', 'Jane Smith', 'Bob Johnson'];

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

    workReportController.remarksList.add(TextEditingController());
    workReportController.billsList.add(BillsModel("", TextEditingController()));
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
          style: AppTextStyle.largeBold.copyWith(fontSize: 18
              , color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 12,),

            _buildDatePicker(),

            SizedBox(height: 12,),

            _buildDropdown(attendanceOptions, attendanceStatus, (val) => setState(() => attendanceStatus = val),"Select Attendance Status"),

            SizedBox(height: 28,),
            _buildSectionTitle('Site Details'),
            SizedBox(height: 4,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: color_hint_text,
                    width: 0.5
                ),

                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  _buildDropdown(siteOptions, selectedSite, (val) => setState(() => selectedSite = val), "Select Site"),
                  SizedBox(height: 12,),
                  _buildDropdown(contactPersons, contactPerson, (val) => setState(() => contactPerson = val), "Select Contact Person"),
                  SizedBox(height: 28,),
                  _buildTimePicker('Select Site In Time', siteInTime, () => _pickTime(true)),
                  SizedBox(height: 28,),
                  _buildTimePicker('Select Site Out Time', siteOutTime, () => _pickTime(false)),
                ],
              ),
            ),
            SizedBox(height: 28,),

            _buildSectionTitle('Remarks'),

            SizedBox(height: 4,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: color_hint_text,
                    width: 0.5
                ),

                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [

                  for(int i=0;i<workReportController.remarksList.length; i++)
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Expanded(child: _buildTextField(workReportController.remarksList[i], 'Remarks ${i+1}')),

                           SizedBox(width: 12,),

                           (i == (workReportController.remarksList.length-1))?InkWell(onTap: (){
                             workReportController.remarksList.add(TextEditingController());
                             setState(() {

                             });
                           },child: Icon(Icons.add_circle,size: 30,color: color_brown_title,)):InkWell(
                               onTap: () {
                                 workReportController.remarksList.removeAt(i);
                                 setState(() {});
                               },
                               child: Icon(
                                 Icons.remove_circle,
                                 size: 30,
                                 color: color_primary,
                               ))
                         ],
                       ),
                       SizedBox(height: 12,),
                     ],
                   )


                  ],
              ),
            ),

            SizedBox(height: 28,),

            _buildSectionTitle('Expenses'),

            SizedBox(height: 4,),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: color_hint_text,
                    width: 0.5
                ),

                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [

                  _buildTextField(workReportController.controllerTrain.value, "Train"),
                  SizedBox(height: 12,),
                  _buildTextField(workReportController.controllerBus.value, "Bus"),
                  SizedBox(height: 12,),
                  _buildTextField(workReportController.controllerAuto.value, "Auto"),
                  SizedBox(height: 12,),
                  _buildTextField(workReportController.controllerFuel.value, "Fuel"),
                  SizedBox(height: 12,),
                  _buildTextField(workReportController.controllerFoodAmount.value, "Food Amount"),
                  SizedBox(height: 12,),
                  _buildTextField(workReportController.controllerRemarksForOther.value, "Remarks For Others"),
                  SizedBox(height: 12,),

                ],
              ),
            ),


            SizedBox(height: 28,),

            _buildSectionTitle('Expenses Bills'),

            SizedBox(height: 4,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: color_hint_text,
                    width: 0.5
                ),

                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [

                  for(int i=0;i<workReportController.billsList.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container(height: 160
                              ,child: Stack(
                                children: [
                                  Container(width: double.infinity,height: 150,color: Colors.grey.shade300,margin: EdgeInsets.only(right: 10),),
                                  Align(alignment: Alignment.bottomRight,child: Icon(Icons.edit,size: 30,color: color_primary,))
                                ],
                              ),
                            )),

                            SizedBox(width: 12,),

                            InkWell(onTap: (){
                              workReportController.billsList.removeAt(i);
                              setState(() {

                              });
                            },child: Icon(Icons.remove_circle,size: 30,color: color_primary,))
                          ],
                        ),


                        Row(
                          children: [
                            Expanded(child: _buildTextField(workReportController.billsList[i].textEditingController, 'Bill Name ${i+1}')),

                            if(i == (workReportController.billsList.length-1))Container(margin: EdgeInsets.only(left: 12),
                              child: InkWell(onTap: (){
                                workReportController.billsList.add(BillsModel("", TextEditingController()));
                                setState(() {

                                });
                              },child: Icon(Icons.add_circle,size: 30,color: color_brown_title,)),
                            )
                          ],
                        ),

                        if(i != (workReportController.billsList.length-1))SizedBox(height: 28,),
                      ],
                    )


                ],
              ),
            ),

            SizedBox(height: 20),

            // Login Button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              child: CommonButton(
                titleText: "Save",
                textColor: Colors.white,
                onCustomButtonPressed: () async {


                },
                borderColor: color_primary,
                borderWidth: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.largeBold.copyWith(fontSize: 20
          , color: color_hint_text),
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
            Text(selectedDate == null ? 'Select Work Reporting Date' : DateFormat('dd/MM/yyyy').format(selectedDate!),
                style: AppTextStyle.largeMedium.copyWith(fontSize: 15
                    , color: selectedDate == null ?color_hint_text:Colors.black)),
            Icon(Icons.calendar_month_sharp, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String? selectedValue, Function(String?) onChanged, String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10),
        alignLabelWithHint: true,

        labelText: hint, // Moves up as a floating label when a value is selected
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Auto float when selecting
        hintText:hint, // Hint text
        hintStyle:AppTextStyle.largeMedium.copyWith(fontSize: 15
            , color: color_hint_text), // Hint text style
        labelStyle:AppTextStyle.largeMedium.copyWith(fontSize: 15
            , color: color_hint_text), // Hint text style
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Bottom-only border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Bottom border on focus
        ),
      ),
      value: selectedValue,
      isExpanded: true, // Ensures dropdown takes full width
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
            padding: EdgeInsets.only(bottom: 4,  right: 10),
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
    )
    ;
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0),
        alignLabelWithHint: true,
        labelText: hint, // Display hint as title when typing
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Auto float when typing
        border: UnderlineInputBorder(),
        hintStyle: AppTextStyle.largeMedium.copyWith(fontSize: 16
            , color: color_hint_text) ,

        labelStyle: AppTextStyle.largeMedium.copyWith(fontSize: 16
            , color: color_hint_text) ,
      ),
    );
  }
}


