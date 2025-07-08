import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Imports all Widgets included in [multiselect] package
import 'package:multiselect/multiselect.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/isntrument_list_response.dart';
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
import '../../Sites/Model/site_list_response.dart';

class EditWorkReportScreen extends StatefulWidget {

  EditWorkReportScreen(
      {Key? key,
      })
      : super(key: key);

  @override
  _EditWorkReportScreenState createState() => _EditWorkReportScreenState();
}

class _EditWorkReportScreenState extends State<EditWorkReportScreen> {
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
    workReportController.remarksList.clear();
    workReportController.serviceStatusList.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await workReportController.callInstrumentList();
      await workReportController.callConveyanceList();
      await workReportController.callSiteList();
      await workReportController.callSiteAttendByList();
      await workReportController.callTestPerformerList();
      await workReportController.callServiceByNatureByList();
      await workReportController.callWorkmanList();

      if((workReportController.selectedWorkReportData.value.date??"").isNotEmpty){
        DateFormat format = DateFormat("dd-MM-yyyy");
        selectedDate = format.parse(workReportController.selectedWorkReportData.value.date??"");

        setState(() {

        });
      }


      /// Site
      if ((workReportController.selectedWorkReportData.value.siteId ?? 0) != 0) {

        printData("siteId", workReportController.selectedWorkReportData.value.siteId.toString());


        for (int i = 0; i < (workReportController.siteList).length; i++) {

          printData("workReportController.siteList[i].headId", workReportController.siteList[i].headId.toString());

          if (workReportController.siteList[i].headId ==
              workReportController.selectedWorkReportData.value.siteId) {
            workReportController.siteId =
            workReportController.siteList[i];

            selectedSite = workReportController.selectedWorkReportData.value.siteId.toString();

            printData("siteIdddddd", (workReportController.siteId?.headId??0).toString());

            setState(() {

            });
          }
        }
      }

      workReportController.controllerNameOfContactPerson.value.text =
          workReportController.selectedWorkReportData.value.contactPerson ?? "";
      workReportController.controllerNameOfWitnessPerson.value.text =
          workReportController.selectedWorkReportData.value.witnessPerson ?? "";

      workReportController.isEdit.value = false;
      workReportController.conveyThrough = workReportController.conveyThroughList[
      (workReportController
          .selectedWorkReportData.value.convenyenceThroughStatus ??
          0) -
          1];

      if ((workReportController.selectedWorkReportData.value.conveyanceId ?? "")
          .isNotEmpty) {
        for (int i = 0; i < (workReportController.conveysList).length; i++) {
          if (workReportController.conveysList[i].id.toString() ==
              workReportController.selectedWorkReportData.value.conveyanceId) {
            workReportController.conveyanceData =
            workReportController.conveysList[i];

            setState(() {

            });
          }
        }
      }



      if ((workReportController.selectedWorkReportData.value.serviceNatureId ?? "")
          .isNotEmpty) {
        for (int i = 0; i < (workReportController.serviceByNatureList).length; i++) {
          if (workReportController.serviceByNatureList[i].id.toString() ==
              workReportController.selectedWorkReportData.value.serviceNatureId) {
            workReportController.serviceByNatureData =
            workReportController.serviceByNatureList[i];

            setState(() {

            });
          }
        }
      }



      if ((workReportController.selectedWorkReportData.value.remark ?? [])
          .isNotEmpty) {
        for (int i = 0;
        i <
            (workReportController.selectedWorkReportData.value.remark ?? [])
                .length;
        i++) {
          workReportController.selectedWorkReportData.value.remark?[i]
              .remarkTextEditingController.text = workReportController
              .selectedWorkReportData.value.remark?[i].remark ??
              "";
          workReportController.remarksList.add(
              workReportController.selectedWorkReportData.value.remark?[i] ??
                  RemarkWorkReport());
        }
      } else {
        workReportController.remarksList.add(RemarkWorkReport());
      }


      if ((workReportController.selectedWorkReportData.value.serviceStatus ?? [])
          .isNotEmpty) {
        for (int i = 0;
        i <
            (workReportController.selectedWorkReportData.value
                .serviceStatus ??
                [])
                .length;
        i++) {


          ServiceStatusModel serviceStatusModel = ServiceStatusModel();
          serviceStatusModel.id = workReportController.selectedWorkReportData.value
              .serviceStatus?[i].id.toString();
          serviceStatusModel
              .testLocationEditingController
              .text = workReportController.selectedWorkReportData.value
              .serviceStatus?[i].testLocation ??
              "";

          serviceStatusModel
              .remarkTextEditingController
              .text = workReportController.selectedWorkReportData.value
              .serviceStatus?[i].remark ??
              "";

          serviceStatusModel
              .roomEquipmentEditingController
              .text = workReportController.selectedWorkReportData.value
              .serviceStatus?[i].roomEquipment ??
              "";


          printData("workReportController.selectedWorkReportData.value.serviceStatus?[i].testPerfomedId", (workReportController.selectedWorkReportData.value.serviceStatus?[i].testPerfomedId??0).toString());

          if ((workReportController.selectedWorkReportData.value.serviceStatus?[i].testPerfomedId ?? 0) != 0) {
            for (int z = 0; z < (workReportController.testPerformerList).length; z++) {
              if (workReportController.selectedWorkReportData.value.serviceStatus?[i].testPerfomedId ==  workReportController.testPerformerList[z].id
                  ) {
                serviceStatusModel.testPerformData =
                workReportController.testPerformerList[z];
              }
            }
          }


          if ((workReportController.selectedWorkReportData.value.serviceStatus?[i].headInstrumentId ?? 0) != 0) {
            for (int z = 0; z < (workReportController.instrumentList).length; z++) {
              if (workReportController.selectedWorkReportData.value.serviceStatus?[i].headInstrumentId == workReportController.instrumentList[z].id
                  ) {
                serviceStatusModel.usedInstrument =
                workReportController.instrumentList[z];
              }
            }
          }


          if ((workReportController.selectedWorkReportData.value.serviceStatus?[i].performUserId ?? 0) != 0) {
            for (int z = 0; z < (workReportController.workmanList).length; z++) {
              if (workReportController.workmanList[z].id ==
                  workReportController.selectedWorkReportData.value.serviceStatus?[i].performUserId) {
                serviceStatusModel.workmanData =
                workReportController.workmanList[z];
              }
            }
          }


          serviceStatusModel.dataSheetStatus = workReportController.sheetStatusList[ workReportController.selectedWorkReportData.value.serviceStatus?[i].status??0];
          workReportController.serviceStatusList.add(serviceStatusModel);

          setState(() {

          });

        }
      } else {
        workReportController.serviceStatusList.add(ServiceStatusModel());
      }

      workReportController.controllerOther.value.text =
          workReportController.selectedWorkReportData.value.other ?? "";

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
          'Edit Work Report',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar, color: color_secondary),
            onPressed: () {
              workReportController.isEdit.value = true;
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever, color: color_secondary),
            onPressed: () {
              Get.defaultDialog(
                  title: "DELETE",
                  middleText: "Are you sure want to delete this Work Report?",
                  barrierDismissible: false,
                  titlePadding:
                      const EdgeInsets.only(left: 20, right: 20, top: 10),
                  textConfirm: "Yes",
                  textCancel: "No",
                  titleStyle: TextStyle(fontSize: 15),
                  buttonColor: Colors.white,
                  confirmTextColor: color_primary,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () async {
                    Navigator.pop(context);
                    workReportController.callDeleteWorkReport(
                        workReportController.selectedWorkReportData.value.id
                            .toString());
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
                      height: 12,
                    ),

                    _buildTextFieldOnlyReadableDate(
                        TextEditingController(text: DateFormat('dd/MM/yyyy').format(selectedDate??DateTime(2025))),
                        "Work Reporting Date"),

                    SizedBox(
                      height: 16,
                    ),




                    DropdownButton<SiteData>(
                      value: workReportController.siteId,
                      hint: Text(
                        "Select Site",
                        style: AppTextStyle.largeMedium.copyWith(
                          fontSize: 16,
                          color: color_hint_text,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (SiteData? newValue) {
                        setState(() {
                          workReportController.siteId = newValue;
                        });
                      },
                      items: workReportController.siteList.map((SiteData group) {
                        return DropdownMenuItem<SiteData>(
                          value: group,
                          child: Text(
                            group.headName ?? "",
                            style: AppTextStyle.largeMedium.copyWith(
                              fontSize: 16,
                              color: blackText,
                            ),
                          ),
                        );
                      }).toList(),
                    ),


                    // DropdownButton<SiteData>(
                    //   value: workReportController.siteList
                    //       .contains(workReportController.siteId)
                    //       ? workReportController.siteId
                    //       : null,
                    //   // Ensure valid value
                    //   hint: Text("Select Site",style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                    //       , color: color_hint_text)) ,
                    //
                    //   isExpanded: true,
                    //   onChanged: (SiteData? newValue) {
                    //     setState(() {
                    //       workReportController.siteId = newValue;
                    //     });
                    //   },
                    //   items: workReportController.siteList.map((SiteData group) {
                    //     return DropdownMenuItem<SiteData>(
                    //       value: group,
                    //       child: Text(group.headName??"", style: AppTextStyle.largeMedium.copyWith(fontSize: 16
                    //           , color: blackText),),
                    //     );
                    //   }).toList(),
                    // ),
                    SizedBox(height: 12,),


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

                    DropDownMultiSelect<SiteAttendByData>(
                      options: workReportController.siteAttendByList,
                      selectedValues: workReportController.selectedSiteAttendByList,
                      onChanged: (List<SiteAttendByData> values) {

                        workReportController.selectedSiteAttendListInString = values.toString();
                        printData("selected", values.toString());
                        //  workReportController.updateSelectedSiteAttendByList(values.toString().split(','));

                      },

                    ),

                    SizedBox(
                      height: 8,
                    ),

                    DropdownButton<String>(
                      value: workReportController.conveyThroughList
                              .contains(workReportController.conveyThrough)
                          ? workReportController.conveyThrough
                          : null,
                      // Ensure valid value
                      hint: Text("Convey Through",
                          style: AppTextStyle.largeMedium
                              .copyWith(fontSize: 16, color: color_hint_text)),

                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          workReportController.conveyThrough = newValue;
                        });
                      },
                      items: workReportController.conveyThroughList
                          .map((String group) {
                        return DropdownMenuItem<String>(
                          value: group,
                          child: Text(
                            group,
                            style: AppTextStyle.largeMedium
                                .copyWith(fontSize: 16, color: blackText),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    _buildTextField(
                        workReportController.controllerOther.value, "Other"),
                    SizedBox(
                      height: 16,
                    ),

                    DropdownButton<ConveyanceData>(
                      value: workReportController.conveysList
                              .contains(workReportController.conveyanceData)
                          ? workReportController.conveyanceData
                          : null,
                      // Ensure valid value
                      hint: Text("Driver Name",
                          style: AppTextStyle.largeMedium
                              .copyWith(fontSize: 16, color: color_hint_text)),

                      isExpanded: true,
                      onChanged: (ConveyanceData? newValue) {
                        setState(() {
                          workReportController.conveyanceData = newValue;
                        });
                      },
                      items: workReportController.conveysList
                          .map((ConveyanceData group) {
                        return DropdownMenuItem<ConveyanceData>(
                          value: group,
                          child: Text(
                            group.name ?? "",
                            style: AppTextStyle.largeMedium
                                .copyWith(fontSize: 16, color: blackText),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    DropdownButton<ServiceByNatureData>(
                      value: workReportController.serviceByNatureList.contains(
                              workReportController.serviceByNatureData)
                          ? workReportController.serviceByNatureData
                          : null,
                      // Ensure valid value
                      hint: Text("Service Nature",
                          style: AppTextStyle.largeMedium
                              .copyWith(fontSize: 16, color: color_hint_text)),

                      isExpanded: true,
                      onChanged: (ServiceByNatureData? newValue) {
                        setState(() {
                          workReportController.serviceByNatureData = newValue;
                        });
                      },
                      items: workReportController.serviceByNatureList
                          .map((ServiceByNatureData group) {
                        return DropdownMenuItem<ServiceByNatureData>(
                          value: group,
                          child: Text(
                            group.name ?? "",
                            style: AppTextStyle.largeMedium
                                .copyWith(fontSize: 16, color: blackText),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    _buildTextField(
                        workReportController
                            .controllerNameOfContactPerson.value,
                        "Name Of Contact Person"),
                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(
                        workReportController
                            .controllerNameOfWitnessPerson.value,
                        "Name Of Witness Person"),

                    _buildSectionTitle('Comments'),

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
                                              workReportController
                                                  .removedRemarkIds
                                                  .add(workReportController
                                                      .remarksList[i].id
                                                      .toString());
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
                      height: 16,
                    ),

                    _buildSectionTitle('Given Service & Status'),

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
                              i < workReportController.serviceStatusList.length;
                              i++)
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
                                                _buildTextField(
                                                    workReportController
                                                        .serviceStatusList[i]
                                                        .testLocationEditingController,
                                                    'Test Location ${i + 1}'),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                _buildTextField(
                                                    workReportController
                                                        .serviceStatusList[i]
                                                        .roomEquipmentEditingController,
                                                    'Room/Equipment/System Identification ${i + 1}'),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                DropdownButton<TestByPerformData>(
                                                  value: workReportController
                                                          .testPerformerList
                                                          .contains(
                                                              workReportController
                                                                  .serviceStatusList[
                                                                      i]
                                                                  .testPerformData)
                                                      ? workReportController
                                                          .serviceStatusList[i]
                                                          .testPerformData
                                                      : null,
                                                  // Ensure valid value
                                                  hint: Text("Test Performed",
                                                      style: AppTextStyle.largeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                                  color_hint_text)),

                                                  isExpanded: true,
                                                  onChanged:
                                                      (TestByPerformData? newValue) {
                                                    setState(() {
                                                      workReportController
                                                          .serviceStatusList[i]
                                                          .testPerformData = newValue;
                                                    });
                                                  },
                                                  items: workReportController
                                                      .testPerformerList
                                                      .map((TestByPerformData group) {
                                                    return DropdownMenuItem<
                                                        TestByPerformData>(
                                                      value: group,
                                                      child: Text(
                                                        group.testName ?? "",
                                                        style: AppTextStyle
                                                            .largeMedium
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: blackText),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                DropdownButton<String>(
                                                  value: workReportController
                                                          .sheetStatusList
                                                          .contains(
                                                              workReportController
                                                                  .serviceStatusList[
                                                                      i]
                                                                  .dataSheetStatus)
                                                      ? workReportController
                                                          .serviceStatusList[i]
                                                          .dataSheetStatus
                                                      : null,
                                                  // Ensure valid value
                                                  hint: Text("Sheet Status",
                                                      style: AppTextStyle.largeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                                  color_hint_text)),

                                                  isExpanded: true,
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      workReportController
                                                          .serviceStatusList[i]
                                                          .dataSheetStatus = newValue;
                                                    });
                                                  },
                                                  items: workReportController
                                                      .sheetStatusList
                                                      .map((String group) {
                                                    return DropdownMenuItem<String>(
                                                      value: group,
                                                      child: Text(
                                                        group,
                                                        style: AppTextStyle
                                                            .largeMedium
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: blackText),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                DropdownButton<InstrumentData>(
                                                  value: workReportController
                                                          .instrumentList
                                                          .contains(
                                                              workReportController
                                                                  .serviceStatusList[
                                                                      i]
                                                                  .usedInstrument)
                                                      ? workReportController
                                                          .serviceStatusList[i]
                                                          .usedInstrument
                                                      : null,
                                                  // Ensure valid value
                                                  hint: Text("Select Used Instrument",
                                                      style: AppTextStyle.largeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                                  color_hint_text)),

                                                  isExpanded: true,
                                                  onChanged:
                                                      (InstrumentData? newValue) {
                                                    setState(() {
                                                      workReportController
                                                          .serviceStatusList[i]
                                                          .usedInstrument = newValue;
                                                    });
                                                  },
                                                  items: workReportController
                                                      .instrumentList
                                                      .map((InstrumentData group) {
                                                    return DropdownMenuItem<
                                                        InstrumentData>(
                                                      value: group,
                                                      child: Text(
                                                        group.headInstrumentName ??
                                                            "",
                                                        style: AppTextStyle
                                                            .largeMedium
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: blackText),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),

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

                                                _buildTextField(
                                                    workReportController
                                                        .serviceStatusList[i]
                                                        .remarkTextEditingController,
                                                    'Remarks ${i + 1}'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          (i ==
                                                  (workReportController
                                                          .serviceStatusList.length -
                                                      1))
                                              ? InkWell(
                                                  onTap: () {

                                                    workReportController
                                                        .removedServiceStatusIds
                                                        .add(workReportController
                                                        .serviceStatusList[i].id
                                                        .toString());

                                                    workReportController
                                                        .serviceStatusList
                                                        .add(ServiceStatusModel());
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    size: 30,
                                                    color: color_brown_title,
                                                  ))
                                              : InkWell(
                                                  onTap: () {
                                                    workReportController
                                                        .serviceStatusList
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
                    if(workReportController.isEdit.value) Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {

                          if (selectedDate == null) {
                            snackBar(context, "Please select date");
                            return;
                          }

                          if (workReportController.controllerNameOfContactPerson
                              .value.text.isEmpty) {
                            snackBar(context, "Please enter Contact person");
                            return;
                          }

                          if (workReportController.controllerNameOfContactPerson
                              .value.text.isEmpty) {
                            snackBar(context, "Please enter Witness person");
                            return;
                          }

                          if (workReportController.conveyanceData == null) {
                            snackBar(context, "Select Driver Name");
                            return;
                          }

                          if (workReportController.serviceByNatureData ==
                              null) {
                            snackBar(context, "Select Service Nature");
                            return;
                          }

                          if (workReportController.conveyanceData == null) {
                            snackBar(context, "Select Driver Name");
                            return;
                          }

                          if(workReportController.siteId == null){
                            snackBar(context, "Select Site ");
                            return;
                          }

                          String cleaned = workReportController.selectedSiteAttendListInString.toString().replaceAll('[', '').replaceAll(']', '');

// Step 2: Split by comma and trim spaces
                          List<String> result = cleaned.split(',').map((e) => e.trim()).toList();

                          await workReportController.updateSelectedSiteAttendByList(result);

                          printData("seletced", workReportController.selectedSiteAttendListInString??"");


                          workReportController.callUpdateWorkReportList(workReportController.selectedWorkReportData.value.id.toString(),
                              DateFormat('dd-MM-yyyy').format(selectedDate!), (workReportController.siteId?.id??0).toString());
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
