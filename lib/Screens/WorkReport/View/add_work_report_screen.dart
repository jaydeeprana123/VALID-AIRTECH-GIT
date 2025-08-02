import 'dart:developer';
import 'dart:io';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// Imports all Widgets included in [multiselect] package
import 'package:multiselect/multiselect.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/isntrument_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/service_by_nature_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/service_status_model.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/site_by_service_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/test_by_perform_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/work_report_list_response.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../Sites/Model/employee_list_response.dart';

class AddWorkReportScreen extends StatefulWidget {

  final String date;
  final String siteId;
  final String siteName;

  AddWorkReportScreen({
    Key? key,
  required this.date,
    required this.siteId,
    required this.siteName,

  }) : super(key: key);


  @override
  _AddWorkReportScreenState createState() => _AddWorkReportScreenState();
}

class _AddWorkReportScreenState extends State<AddWorkReportScreen> {

  WorkReportController workReportController = Get.find<WorkReportController>();

  TimeOfDay? siteInTime;
  TimeOfDay? siteOutTime;
  String? attendanceStatus;
  String? contactPerson;



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

    WidgetsBinding.instance.addPostFrameCallback((_) {

      workReportController.siteId = widget.siteId??"0";

      workReportController.callInstrumentList();
      workReportController.callConveyanceList();
      workReportController.callSiteAttendByList();
      workReportController.callTestPerformerList();
      workReportController.callServiceByNatureByList();
      workReportController.callWorkmanList();
    });




    workReportController.serviceStatusList.clear();
    workReportController.remarksList.clear();
    workReportController.serviceStatusList.add(ServiceStatusModel());
    workReportController.remarksList.add(RemarkWorkReport());
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
          'Add Site Report',
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
      body: Obx(() =>Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [

                SizedBox(height: 12,),

                _buildSectionTitle('Site Details'),

                SizedBox(height: 12,),

                Column(
                  children: [
                    Text("Reporting Date",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                        , color: color_hint_text)),

                      Text(widget.date,style: AppTextStyle.largeBold.copyWith(fontSize: 16
                          , color: color_brown_title)),

                    SizedBox(height: 16,),


                    Text("Site Name",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                        , color: color_hint_text)),

                    Text(widget.siteName,style: AppTextStyle.largeBold.copyWith(fontSize: 16
                        , color: color_brown_title)),
                  ],
                ),

                SizedBox(height: 16,),



                // _buildDatePicker(),

                // _buildTextFieldOnlyReadableDate(TextEditingController(text: widget.date), "Site Reporting Date"),

                SizedBox(height: 16,),


                // DropdownButton<SiteAttendByData>(
                //   value: workReportController.siteAttendByList
                //       .contains(workReportController.siteAttendByData)
                //       ? workReportController.siteAttendByData
                //       : null,
                //   // Ensure valid value
                //   hint: Text("Site Attend By",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                //       , color: color_hint_text)) ,
                //
                //
                //   isExpanded: true,
                //   onChanged: (SiteAttendByData? newValue) {
                //     setState(() {
                //       workReportController.siteAttendByData = newValue;
                //     });
                //   },
                //   items: workReportController.siteAttendByList.map((SiteAttendByData group) {
                //     return DropdownMenuItem<SiteAttendByData>(
                //       value: group,
                //       child: Text(group.name??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                //           , color: blackText),),
                //     );
                //   }).toList(),
                // ),


                _buildSectionTitle('Site Attend By'),


                MultiSelectDialogField<SiteAttendByData>(
                  items: workReportController.siteAttendByList
                      .map((item) => MultiSelectItem<SiteAttendByData>(item, item.name??""))
                      .toList(),
                  initialValue: workReportController.selectedSiteAttendByList,
                  onConfirm: (List<SiteAttendByData> selected) {
                    workReportController.selectedSiteAttendByList.value = selected;
                    workReportController.selectedSiteAttendListInString =
                        selected.map((e) => e.name).join(', ');
                  },
                  chipDisplay: MultiSelectChipDisplay<SiteAttendByData>(
                    chipColor: Colors.blue.shade100,
                    textStyle: TextStyle(color: Colors.black),
                    onTap: (item) {
                      workReportController.selectedSiteAttendByList.remove(item);
                    },
                  ),
                  buttonText: Text("Select Site Attendees"),
                ),


                // DropDownMultiSelect<SiteAttendByData>(
                //   options: workReportController.siteAttendByList,
                //   selectedValues: workReportController.selectedSiteAttendByList,
                //   onChanged: (List<SiteAttendByData> values) {
                //
                //     workReportController.selectedSiteAttendListInString = values.toString();
                //     printData("selected", values.toString());
                //   //  workReportController.updateSelectedSiteAttendByList(values.toString().split(','));
                //
                //   },
                //
                // ),


                SizedBox(height: 8,),

                DropdownButton<String>(
                  value: workReportController.conveyThroughList
                      .contains(workReportController.conveyThrough)
                      ? workReportController.conveyThrough
                      : null,
                  // Ensure valid value
                  hint: Text("Convey Through",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                      , color: color_hint_text)) ,

                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      workReportController.conveyThrough = newValue;
                    });
                  },
                  items: workReportController.conveyThroughList.map((String group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: Text(group, style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                          , color: blackText),),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12,),

                _buildTextField(workReportController.controllerOther.value, "Other"),
                SizedBox(height: 16,),


                DropdownButton<ConveyanceData>(
                  value: workReportController.conveysList
                      .contains(workReportController.conveyanceData)
                      ? workReportController.conveyanceData
                      : null,
                  // Ensure valid value
                  hint: Text("Driver Name",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                      , color: color_hint_text)) ,

                  isExpanded: true,
                  onChanged: (ConveyanceData? newValue) {
                    setState(() {
                      workReportController.conveyanceData = newValue;
                    });
                  },
                  items: workReportController.conveysList.map((ConveyanceData group) {
                    return DropdownMenuItem<ConveyanceData>(
                      value: group,
                      child: Text(group.name??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                          , color: blackText),),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12,),

                DropdownButton<ServiceByNatureData>(
                  value: workReportController.serviceByNatureList
                      .contains(workReportController.serviceByNatureData)
                      ? workReportController.serviceByNatureData
                      : null,
                  // Ensure valid value
                  hint: Text("Service Nature",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                      , color: color_hint_text)) ,

                  isExpanded: true,
                  onChanged: (ServiceByNatureData? newValue) {
                    setState(() {
                      workReportController.serviceByNatureData = newValue;
                    });
                  },
                  items: workReportController.serviceByNatureList.map((ServiceByNatureData group) {
                    return DropdownMenuItem<ServiceByNatureData>(
                      value: group,
                      child: Text(group.name??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                          , color: blackText),),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12,),

                _buildTextField(workReportController.controllerNameOfContactPerson.value, "Name Of Contact Person"),
                SizedBox(height: 16,),

                _buildTextField(workReportController.controllerNameOfWitnessPerson.value, "Name Of Witness Person"),
                SizedBox(height: 20,),
                _buildSectionTitle('Comments'),

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
                                Expanded(child: _buildTextField(workReportController.remarksList[i].remarkTextEditingController, 'Comment ${i+1}')),

                                SizedBox(width: 12,),

                                (i == (workReportController.remarksList.length-1))?InkWell(onTap: (){
                                  workReportController.remarksList.add(RemarkWorkReport());
                                  setState(() {

                                  });
                                },child: Icon(Icons.add_circle,size: 30,color: color_brown_title,)):InkWell(
                                    onTap: () {

                                      workReportController.removedRemarkIds.add(workReportController.remarksList[i].id.toString());
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

                SizedBox(height: 20,),

                _buildSectionTitle('Given Service & Status'),

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

                      for(int i=0;i<workReportController.serviceStatusList.length; i++)
                       Padding(
                         padding: const EdgeInsets.only(bottom: 8.0),
                         child: Column(
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     Expanded(
                                       child: Column(
                                         children: [

                                           _buildTextField(workReportController.serviceStatusList[i].testLocationEditingController, 'Test Location ${i+1}'),

                                           SizedBox(height: 8,),

                                           _buildTextField(workReportController.serviceStatusList[i].roomEquipmentEditingController, 'Room/Equipment/System Identification ${i+1}'),
                                           SizedBox(height: 16,),

                                           DropdownButton<TestByPerformData>(
                                             value: workReportController.testPerformerList
                                                 .contains(workReportController.serviceStatusList[i].testPerformData)
                                                 ? workReportController.serviceStatusList[i].testPerformData
                                                 : null,
                                             // Ensure valid value
                                             hint: Text("Test Performed",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                 , color: color_hint_text)) ,


                                             isExpanded: true,
                                             onChanged: (TestByPerformData? newValue) {
                                               setState(() {
                                                 workReportController.serviceStatusList[i].testPerformData = newValue;
                                               });
                                             },
                                             items: workReportController.testPerformerList.map((TestByPerformData group) {
                                               return DropdownMenuItem<TestByPerformData>(
                                                 value: group,
                                                 child: Text(group.testName??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                     , color: blackText),),
                                               );
                                             }).toList(),
                                           ),

                                           SizedBox(height: 16,),

                                           DropdownButton<String>(
                                             value: workReportController.sheetStatusList
                                                 .contains(workReportController.serviceStatusList[i].dataSheetStatus)
                                                 ? workReportController.serviceStatusList[i].dataSheetStatus
                                                 : null,
                                             // Ensure valid value
                                             hint: Text("Sheet Status",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                 , color: color_hint_text)) ,


                                             isExpanded: true,
                                             onChanged: (String? newValue) {
                                               setState(() {
                                                 workReportController.serviceStatusList[i].dataSheetStatus = newValue;
                                               });
                                             },
                                             items: workReportController.sheetStatusList.map((String group) {
                                               return DropdownMenuItem<String>(
                                                 value: group,
                                                 child: Text(group, style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                     , color: blackText),),
                                               );
                                             }).toList(),
                                           ),

                                           SizedBox(height: 16,),


                                           DropdownButton<InstrumentData>(
                                             value: workReportController.instrumentList
                                                 .contains(workReportController.serviceStatusList[i].usedInstrument)
                                                 ? workReportController.serviceStatusList[i].usedInstrument
                                                 : null,
                                             // Ensure valid value
                                             hint: Text("Select Used Instrument",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                 , color: color_hint_text)) ,


                                             isExpanded: true,
                                             onChanged: (InstrumentData? newValue) {
                                               setState(() {
                                                 workReportController.serviceStatusList[i].usedInstrument = newValue;
                                               });
                                             },
                                             items: workReportController.instrumentList.map((InstrumentData group) {
                                               return DropdownMenuItem<InstrumentData>(
                                                 value: group,
                                                 child: Text(group.headInstrumentName??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                     , color: blackText),),
                                               );
                                             }).toList(),
                                           ),

                                           SizedBox(height: 8,),

                                           DropdownButton<WorkmanData>(
                                             value: workReportController.workmanList
                                                 .contains(workReportController.serviceStatusList[i].workmanData)
                                                 ? workReportController.serviceStatusList[i].workmanData
                                                 : null,
                                             // Ensure valid value
                                             hint: Text("Performed By",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                 , color: color_hint_text)) ,


                                             isExpanded: true,
                                             onChanged: (WorkmanData? newValue) {
                                               setState(() {
                                                 workReportController.serviceStatusList[i].workmanData = newValue;
                                               });
                                             },
                                             items: workReportController.workmanList.map((WorkmanData group) {
                                               return DropdownMenuItem<WorkmanData>(
                                                 value: group,
                                                 child: Text(group.name??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                                                     , color: blackText),),
                                               );
                                             }).toList(),
                                           ),

                                           SizedBox(height: 8,),

                                           _buildTextField(workReportController.serviceStatusList[i].remarkTextEditingController, 'Remarks ${i+1}'),
                                         ],
                                       ),
                                     ),

                                     SizedBox(width: 12,),

                                     (i == (workReportController.serviceStatusList.length-1))?InkWell(onTap: (){
                                       workReportController.serviceStatusList.add(ServiceStatusModel());
                                       setState(() {

                                       });
                                     },child: Icon(Icons.add_circle,size: 30,color: color_brown_title,)):InkWell(
                                         onTap: () {
                                           workReportController.serviceStatusList.removeAt(i);
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
                             ),

                             SizedBox(height: 12,),

                             Container(width: double.infinity,
                               height: 1,color: color_primary,),

                             SizedBox(height: 2,),

                             Container(width: double.infinity,
                               height: 1,color: color_primary,),

                             SizedBox(height: 2,),

                             Container(width: double.infinity,
                               height: 1,color: color_primary,),

                             SizedBox(height: 16,),

                           ],
                         ),
                       )


                      ],
                  ),
                ),

                // SizedBox(height: 28,),
                //
                // _buildSectionTitle('Expenses'),
                //
                // SizedBox(height: 4,),
                //
                // Container(
                //   padding: EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //         color: color_hint_text,
                //         width: 0.5
                //     ),
                //
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   child: Column(
                //     children: [
                //
                //       _buildTextField(workReportController.controllerTrain.value, "Train"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerBus.value, "Bus"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerAuto.value, "Auto"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerFuel.value, "Fuel"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerFoodAmount.value, "Food Amount"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerOther.value, "Other"),
                //       SizedBox(height: 12,),
                //       _buildTextField(workReportController.controllerRemarksForOther.value, "Remarks For Others"),
                //       SizedBox(height: 12,),
                //
                //     ],
                //   ),
                // ),


                // SizedBox(height: 28,),
                //
                // _buildSectionTitle('Expenses Bills'),
                //
                // SizedBox(height: 4,),
                // Container(
                //   padding: EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //         color: color_hint_text,
                //         width: 0.5
                //     ),
                //
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   child: Column(
                //     children: [
                //
                //       for(int i=0;i<workReportController.billsList.length; i++)
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: [
                //                 Expanded(child: InkWell(
                //                   onTap: ()async{
                //                    workReportController.billsList[i].path = await selectPhoto(context);
                //                    setState(() {
                //
                //                    });
                //                   },
                //                   child: Container(height: 160
                //                     ,child: Stack(
                //                       children: [
                //                         (workReportController.billsList[i].path??"").isNotEmpty?Image.file(
                //                           File(workReportController.billsList[i].path??""),
                //                           fit: BoxFit.cover,
                //                           height: 160,
                //                           width: double.infinity,
                //                         ): Container(width: double.infinity,height: 150,color: Colors.grey.shade300,margin: EdgeInsets.only(right: 10),),
                //                         Align(alignment: Alignment.bottomRight,child: Icon(Icons.edit,size: 30,color: color_primary,))
                //                       ],
                //                     ),
                //                   ),
                //                 )),
                //
                //                 SizedBox(width: 12,),
                //
                //                 InkWell(onTap: (){
                //                   workReportController.billsList.removeAt(i);
                //                   setState(() {
                //
                //                   });
                //                 },child: Icon(Icons.remove_circle,size: 30,color: color_primary,))
                //               ],
                //             ),
                //
                //
                //             Row(
                //               children: [
                //                 Expanded(child: _buildTextField(workReportController.billsList[i].billNameTextEditingController, 'Bill Name ${i+1}')),
                //
                //                 if(i == (workReportController.billsList.length-1))Container(margin: EdgeInsets.only(left: 12),
                //                   child: InkWell(onTap: (){
                //                     workReportController.billsList.add(WorkReportExpensesBill());
                //                     setState(() {
                //
                //                     });
                //                   },child: Icon(Icons.add_circle,size: 30,color: color_brown_title,)),
                //                 )
                //               ],
                //             ),
                //
                //             if(i != (workReportController.billsList.length-1))SizedBox(height: 28,),
                //           ],
                //         )
                //
                //
                //     ],
                //   ),
                // ),

                SizedBox(height: 20),

                // Login Button
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: CommonButton(
                    titleText: "Save",
                    textColor: Colors.white,
                    onCustomButtonPressed: () async {


                      if(workReportController.controllerNameOfContactPerson.value.text.isEmpty){
                        snackBar(context, "Please enter Contact person");
                        return;
                      }

                      if(workReportController.controllerNameOfContactPerson.value.text.isEmpty){
                        snackBar(context, "Please enter Witness person");
                        return;
                      }

                      if(workReportController.conveyanceData == null){
                        snackBar(context, "Select Driver Name");
                        return;
                      }

                      if(workReportController.serviceByNatureData == null){
                        snackBar(context, "Select Service Nature");
                        return;
                      }


                      if(workReportController.conveyanceData == null){
                        snackBar(context, "Select Driver Name");
                        return;
                      }


                      if(workReportController.selectedSiteAttendListInString == null){
                        snackBar(context, "Select Site attend by");
                        return;
                      }

                      if(workReportController.siteId == null){
                        snackBar(context, "Select Site ");
                        return;
                      }


//                       String cleaned = workReportController.selectedSiteAttendListInString.toString().replaceAll('[', '').replaceAll(']', '');
//
// // Step 2: Split by comma and trim spaces
//                       List<String> result = cleaned.split(',').map((e) => e.trim()).toList();
//
//                      await workReportController.updateSelectedSiteAttendByList(result);

                      // printData("seletced", workReportController.selectedSiteAttendListInString??"");

                      workReportController.callCreateWorkReportList(widget.date, widget.siteId);

                    },
                    borderColor: color_primary,
                    borderWidth: 0,
                  ),
                ),
              ],
            ),
          ),

          if(workReportController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.largeBold.copyWith(fontSize: 20
          , color: color_hint_text),
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


  Widget _buildTextFieldOnlyReadableDate(TextEditingController controller, String hint) {
    return Row(
      children: [
        Expanded(
          child: TextField(
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
          ),
        ),
        Icon(Icons.calendar_month_sharp, color: Colors.red),
      ],
    );
  }
}


