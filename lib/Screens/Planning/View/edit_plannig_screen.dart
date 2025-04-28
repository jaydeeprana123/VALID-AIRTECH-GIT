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
import 'package:valid_airtech/Screens/Service/Model/service_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../../Appointment/Model/appointment_contact_list_response.dart';
import '../../Instruments/Model/isntrument_list_response.dart';
import '../../Sites/Model/site_list_response.dart';

class EditPlanningScreen extends StatefulWidget {
  @override
  _EditPlanningScreenState createState() => _EditPlanningScreenState();
}

class _EditPlanningScreenState extends State<EditPlanningScreen> {
  PlanningController planningController = Get.find<PlanningController>();

  DateTime? selectedDate;
  TimeOfDay? siteInTime;
  TimeOfDay? siteOutTime;
  String? selectedSite;
  String? selectedHead;
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
    planningController.isEdit.value = false;
    planningController.addPlanningRequest.value = AddPlanningRequest();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to use context here
      _initData(); // async method to handle initialization
      // OR visitChildElements, show dialogs, etc.
    });


  }

  void _initData() async {
    planningController.selectedConveysList.clear();
    planningController.selectedInstrumentList.clear();
    planningController.selectedWorkmanList.clear();
    planningController.addPlanningList.clear();

    if((planningController.selectedPlanning.value.date??"").isNotEmpty){
      DateFormat format = DateFormat("dd-MM-yyyy");
      selectedDate = format.parse(planningController.selectedPlanning.value.date??"");

      setState(() {

      });
    }


    await initiate(); // make sure all lists are loaded

    selectedSite = planningController.selectedPlanning.value.siteId.toString();
    contactPerson = planningController.selectedPlanning.value.headId.toString();

    planningController
        .callContactListList(selectedSite ?? "");


    // Workman
    if ((planningController.selectedPlanning.value.workman ?? []).isNotEmpty) {
      for (var item in planningController.selectedPlanning.value.workman!) {
        planningController.selectedWorkmanList.add(
          AddWorkman()
            ..id = item.id.toString()
            ..workmanId = item.workmanId.toString(),
        );
      }
    } else {
      planningController.selectedWorkmanList.add(AddWorkman());
    }

    // Instrument
    if ((planningController.selectedPlanning.value.instrument ?? []).isNotEmpty) {
      for (var item in planningController.selectedPlanning.value.instrument!) {

        AddInstrumentForPlanning addInstrumentForPlanning = AddInstrumentForPlanning();
        addInstrumentForPlanning.id = item.id.toString();
        addInstrumentForPlanning.headId = item.headId.toString();
        addInstrumentForPlanning.instrumentId = item.instrumentId.toString();

        addInstrumentForPlanning = await planningController.callFilterInstrumentListAndGet(item.headId.toString(), addInstrumentForPlanning);

        planningController.selectedInstrumentList.add(addInstrumentForPlanning);

        setState(() {

        });

      }
    } else {
      planningController.selectedInstrumentList.add(AddInstrumentForPlanning());
    }

    // Conveyance
    if ((planningController.selectedPlanning.value.conveyance ?? []).isNotEmpty) {

      final conveyanceList = planningController.selectedPlanning.value.conveyance ?? [];
      for (int i = 0; i < conveyanceList.length; i++) {
        var item = conveyanceList[i];

        AddConveyanceForPlanning addConveyanceForPlanning = AddConveyanceForPlanning();
        addConveyanceForPlanning.id = item.id.toString();
        addConveyanceForPlanning.headId = item.headId.toString();
        addConveyanceForPlanning.conveyanceId = item.conveyanceId.toString();

        addConveyanceForPlanning = await planningController.callFilterConveyanceListAndGet(item.headId.toString(), addConveyanceForPlanning);

        planningController.selectedConveysList.add(addConveyanceForPlanning);

        setState(() {

        });

      }


    } else {
      planningController.selectedConveysList.add(AddConveyanceForPlanning());
    }

    // Planning
    if ((planningController.selectedPlanning.value.planning ?? []).isNotEmpty) {
      for (var pItem in planningController.selectedPlanning.value.planning!) {
        final addPlanning = AddPlanningModel()
          ..id = pItem.id.toString()
          ..location = pItem.location ?? ""
          ..locationTextEditingController.text = pItem.location ?? ""
          ..system = [];

        final system = SystemAddPlanning()
          ..id = pItem.system?[0].id.toString()
          ..title = pItem.system?[0].title ?? ""
          ..airSystemTextEditingController.text = pItem.system?[0].title ?? ""
          ..service = [];

        for (var sItem in pItem.system?[0].service ?? []) {
          system.service?.add(ServiceAddPlanning()
            ..id = sItem.id.toString()
            ..serviceId = sItem.serviceId.toString());
        }

        addPlanning.system?.add(system);
        planningController.addPlanningList.add(addPlanning);
      }
    } else {
      planningController.addPlanningList.add(AddPlanningModel()
        ..system = [
          SystemAddPlanning()..service = [ServiceAddPlanning()]
        ]);
    }

    // Notes
    if ((planningController.selectedPlanning.value.note ?? []).isNotEmpty) {
      for (var note in planningController.selectedPlanning.value.note!) {
        planningController.notesList.add(
          NoteAddPlanning()
            ..id = note.id.toString()
            ..title = note.title ?? ""
            ..titleTextEditingController.text = note.title ?? "",
        );
      }
    } else {
      planningController.notesList.add(NoteAddPlanning());
    }
  }



  initiate()async{
   await planningController.callSiteList();
   await planningController.callWorkmanList();
   await planningController.callHeadConveyanceList();
   await  planningController.callConveyanceList();
   await  planningController.callHeadInstrumentList();
   await planningController.callInstrumentList();
   await  planningController.callServiceListList();
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
          'Edit Planning',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar, color: color_secondary),
            onPressed: () {
              planningController.isEdit.value = true;
            },
          ),

          IconButton(
            icon: Icon(Icons.delete_forever, color: color_secondary),
            onPressed: () {
              Get.defaultDialog(
                  title: "DELETE",
                  middleText:
                  "Are you sure want to delete this Planning?",
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
                    planningController.callDeletePlanning(planningController.selectedPlanning.value.id.toString());

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

                    _buildDropdownSite(
                        planningController.siteList, selectedSite, (val) {
                      setState(() {
                        planningController.appointmentContactList.clear();
                        selectedSite = val;
                        selectedHead =
                        contactPerson = null;

                        printData("here", "contactPerson null");
                      });

                      planningController
                          .callContactListList(selectedSite ?? "");
                    }, "Select Site"),

                    SizedBox(
                      height: 28,
                    ),

                    _buildDropdownContactList(
                        planningController.appointmentContactList,
                        contactPerson, (val) {
                      setState(() {
                        contactPerson = val;
                      });
                    }, "Select Contact Person"),

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
                                      child: _buildDropdownWorkman(
                                          planningController.workmanList,
                                          planningController
                                              .selectedWorkmanList[i]
                                              .workmanId, (val) {
                                        setState(() {
                                          planningController
                                              .selectedWorkmanList[i]
                                              .workmanId = val;
                                        });
                                      }, "Workman ${i + 1}"),
                                    ),
                                    (i ==
                                            (planningController
                                                    .selectedWorkmanList
                                                    .length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              planningController
                                                  .selectedWorkmanList
                                                  .add(AddWorkman());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {

                                              planningController.addPlanningRequest.value.removedWorkman ??= [];
                                              planningController.addPlanningRequest.value.removedWorkman?.add(RemovedWorkmanAddPlanning(removedWorkmanId: planningController
                                                  .selectedWorkmanList[i].id));

                                              planningController
                                                  .selectedWorkmanList
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
                                        _buildDropdownConveyThroughList(
                                            planningController.headConveysList,
                                            planningController
                                                .selectedConveysList[i]
                                                .headId, (val) {
                                          setState(() {
                                            planningController
                                                .selectedConveysList[i]
                                                .headId = val;
                                            planningController.selectedConveysList[i]
                                                .filteredConveysList
                                                .clear();
                                            planningController
                                                .callFilterConveyanceList(
                                                    val ?? "", i);
                                          });
                                        }, "Conveyance Through ${i + 1}"),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        _buildDropdownConveyorList(
                                            planningController
                                                .selectedConveysList[i]
                                                .filteredConveysList,
                                            planningController
                                                .selectedConveysList[i]
                                                .conveyanceId, (val) {
                                          setState(() {
                                            planningController
                                                .selectedConveysList[i]
                                                .conveyanceId = val;
                                          });
                                        }, "Conveyor Name ${i + 1}"),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    (i ==
                                            (planningController
                                                    .selectedConveysList
                                                    .length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              planningController
                                                  .selectedConveysList
                                                  .add(
                                                      AddConveyanceForPlanning());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {

                                              planningController.addPlanningRequest.value.removedConveyance ??= [];
                                              planningController.addPlanningRequest.value.removedConveyance?.add(RemovedConveyance(removedConveyanceId: planningController
                                                  .selectedConveysList[i].id));

                                              planningController
                                                  .selectedConveysList
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
                              i <
                                  planningController
                                      .selectedInstrumentList.length;
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
                                        _buildDropdownInstrumentHeadList(
                                            planningController
                                                .headInstrumentList,
                                            planningController
                                                .selectedInstrumentList[i]
                                                .headId, (val) {
                                          setState(() {
                                            planningController
                                                .selectedInstrumentList[i]
                                                .headId = val;
                                            planningController
                                                .selectedInstrumentList[i]
                                                .filteredInstrumentList
                                                .clear();
                                            planningController
                                                .callFilterInstrumentList(
                                                    val ?? "", i);
                                          });
                                        }, "Instrument Name ${i + 1}"),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        _buildDropdownInstrumentList(
                                            planningController
                                                .selectedInstrumentList[i]
                                                .filteredInstrumentList,
                                            planningController
                                                .selectedInstrumentList[i]
                                                .instrumentId, (val) {
                                          setState(() {
                                            planningController
                                                .selectedInstrumentList[i]
                                                .instrumentId = val;
                                          });
                                        }, "Instrument ID. ${i + 1}"),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    (i ==
                                            (planningController
                                                    .selectedInstrumentList
                                                    .length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              planningController
                                                  .selectedInstrumentList
                                                  .add(
                                                      AddInstrumentForPlanning());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {

                                              planningController.addPlanningRequest.value.removedInstrument ??= [];
                                              planningController.addPlanningRequest.value.removedInstrument?.add(RemovedInstrument(removedInstrumentId: planningController
                                                  .selectedInstrumentList[i].id));

                                              planningController
                                                  .selectedInstrumentList
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

                    _buildSectionTitle("Planning's"),

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
                              i < planningController.addPlanningList.length;
                              i++)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildTextField(
                                            planningController
                                                .addPlanningList[i]
                                                .locationTextEditingController,
                                            'Test Location ${i + 1}',
                                          ),
                                          SizedBox(height: 10),
                                          _buildTextField(
                                            (planningController
                                                        .addPlanningList[i]
                                                        .system
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? planningController
                                                    .addPlanningList[i]
                                                    .system![0]
                                                    .airSystemTextEditingController
                                                : TextEditingController(),
                                            'Air System ${i + 1}',
                                          ),
                                          SizedBox(height: 10),

                                          // Service Dropdowns
                                          if ((planningController
                                                  .addPlanningList[i]
                                                  .system
                                                  ?.isNotEmpty ??
                                              false))
                                            Column(
                                              children: [
                                                for (int j = 0;
                                                    j <
                                                        (planningController
                                                                .addPlanningList[
                                                                    i]
                                                                .system![0]
                                                                .service
                                                                ?.length ??
                                                            0);
                                                    j++)
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                _buildDropdownService(
                                                              planningController
                                                                  .serviceList,
                                                              planningController
                                                                  .addPlanningList[
                                                                      i]
                                                                  .system![0]
                                                                  .service![j]
                                                                  .serviceId,
                                                              (val) {
                                                                setState(() {
                                                                  planningController
                                                                      .addPlanningList[
                                                                          i]
                                                                      .system![
                                                                          0]
                                                                      .service![
                                                                          j]
                                                                      .serviceId = val;
                                                                });
                                                              },
                                                              "Applicable Test ${j + 1}",
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 12,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (j ==
                                                                  (planningController
                                                                          .addPlanningList[
                                                                              i]
                                                                          .system![
                                                                              0]
                                                                          .service!
                                                                          .length -
                                                                      1)) {
                                                                planningController
                                                                    .addPlanningList[
                                                                        i]
                                                                    .system![0]
                                                                    .service!
                                                                    .add(
                                                                        ServiceAddPlanning());
                                                              } else {

                                                                planningController.addPlanningRequest.value.removedService ??= [];
                                                                planningController.addPlanningRequest.value.removedService?.add(RemovedService(removedServiceId:  planningController
                                                                    .addPlanningList[
                                                                i]
                                                                    .system![0]
                                                                    .service?[j].id));
                                                                planningController
                                                                    .addPlanningList[
                                                                        i]
                                                                    .system![0]
                                                                    .service!
                                                                    .removeAt(
                                                                        j);
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              j ==
                                                                      (planningController
                                                                              .addPlanningList[
                                                                                  i]
                                                                              .system![
                                                                                  0]
                                                                              .service!
                                                                              .length -
                                                                          1)
                                                                  ? Icons
                                                                      .add_circle
                                                                  : Icons
                                                                      .remove_circle,
                                                              size: 30,
                                                              color: j ==
                                                                      (planningController
                                                                              .addPlanningList[i]
                                                                              .system![0]
                                                                              .service!
                                                                              .length -
                                                                          1)
                                                                  ? color_brown_title
                                                                  : color_primary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 12),
                                                    ],
                                                  ),
                                              ],
                                            ),

                                          SizedBox(height: 24),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 12,
                                    ),

                                    // Add/Remove Planning
                                    InkWell(
                                      onTap: () {
                                        if (i ==
                                            planningController
                                                    .addPlanningList.length -
                                                1) {
                                          final newPlanning =
                                              AddPlanningModel();
                                          newPlanning.system = [
                                            SystemAddPlanning()
                                              ..service = [ServiceAddPlanning()]
                                          ];
                                          planningController.addPlanningList
                                              .add(newPlanning);
                                        } else {


                                          planningController.addPlanningRequest.value.removedPlanning ??= [];
                                          planningController.addPlanningRequest.value.removedPlanning?.add(RemovedPlanning(removedPlanningId: planningController
                                              .addPlanningList[i].id));

                                          planningController.addPlanningList
                                              .removeAt(i);
                                        }
                                        setState(() {});
                                      },
                                      child: Icon(
                                        i ==
                                                planningController
                                                        .addPlanningList
                                                        .length -
                                                    1
                                            ? Icons.add_circle
                                            : Icons.remove_circle,
                                        size: 30,
                                        color: i ==
                                                planningController
                                                        .addPlanningList
                                                        .length -
                                                    1
                                            ? color_brown_title
                                            : color_primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
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
                                            planningController.notesList[i].titleTextEditingController,
                                            'Note ${i + 1}')),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    (i ==
                                            (planningController
                                                    .notesList.length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              planningController.notesList
                                                  .add(NoteAddPlanning());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {

                                              planningController.addPlanningRequest.value.removedNote ??= [];
                                              planningController.addPlanningRequest.value.removedNote?.add(RemovedNote(removedNoteId: planningController
                                                  .notesList[i].id));

                                              planningController.notesList
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
                      height: 20,
                    ),

                    // Login Button
                    planningController.isEdit.value?Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {

                          planningController.addPlanningRequest.value.id = planningController.selectedPlanning.value.id.toString();

                          if (selectedDate != null) {
                            planningController.addPlanningRequest.value.date =
                                DateFormat('dd-MM-yyyy').format(selectedDate!);
                          }

                          planningController.addPlanningRequest.value.siteId = selectedSite;
                          planningController.addPlanningRequest.value.headId = contactPerson;

                          planningController.addPlanningRequest.value.workman = planningController.selectedWorkmanList;
                          planningController.addPlanningRequest.value.conveyance = planningController.selectedConveysList;
                          planningController.addPlanningRequest.value.instrument = planningController.selectedInstrumentList;

                          for(int i=0;i< planningController.addPlanningList.length;i++){
                            planningController.addPlanningList[i].location = planningController.addPlanningList[i].locationTextEditingController.text;

                            for(int j=0;j< (planningController.addPlanningList[i].system??[]).length;j++){
                              planningController.addPlanningList[i].system?[j].title = planningController.addPlanningList[i].system?[j].airSystemTextEditingController.text;
                            }

                          }

                          planningController.addPlanningRequest.value.planning = planningController.addPlanningList;

                          for(int i=0;i< planningController.notesList.length;i++){
                            planningController.notesList[i].title = planningController.notesList[i].titleTextEditingController.text;
                          }

                          planningController.addPlanningRequest.value.note = planningController.notesList;

                          planningController.callUpdatePlanning();

                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ):SizedBox(),
                  ],
                ),
              ),
              if (planningController.isLoading.value)
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
      items: items
          .map((e) => DropdownMenuItem(
              value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownService(List<ServiceData> items, String? selectedValue,
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
              value: e.id.toString(), child: Text(e.testName ?? "")))
          .toList(),
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

  Widget _buildDropdownContactList(List<AppointmentContactData> items,
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
      items: items
          .map((e) => DropdownMenuItem(
              value: e.id.toString(), child: Text(e.contactName ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownConveyThroughList(List<HeadConveyanceData> items,
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
      items: items
          .map((e) => DropdownMenuItem(
              value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownConveyorList(List<ConveyanceData> items,
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
      items: items
          .map((e) => DropdownMenuItem(
              value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownInstrumentHeadList(List<HeadInstrumentData> items,
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
      items: items
          .map((e) => DropdownMenuItem(
              value: e.id.toString(), child: Text(e.name ?? "")))
          .toList(),
      onChanged: onChanged,
    );
    ;
  }

  Widget _buildDropdownInstrumentList(List<InstrumentData> items,
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
