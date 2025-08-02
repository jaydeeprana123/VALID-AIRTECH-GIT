import 'dart:developer';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Allowance/Controller/allowance_controller.dart';
import 'package:valid_airtech/Screens/Allowance/View/add_allowance_screen.dart';
import 'package:valid_airtech/Screens/Allowance/View/edit_allowance_screen.dart';
import 'package:valid_airtech/Screens/Conveyance/Controller/conveyance_controller.dart';
import 'package:valid_airtech/Screens/Conveyance/View/add_conveyance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/add_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/View/edit_home_allowance_screen.dart';
import 'package:valid_airtech/Screens/HomeAllowance/controller/home_allowance_controller.dart';
import 'package:valid_airtech/Screens/Instruments/Controller/instrument_controller.dart';
import 'package:valid_airtech/Screens/Instruments/View/add_instrument_screen.dart';
import 'package:valid_airtech/Screens/Notes/Controller/notes_controller.dart';
import 'package:valid_airtech/Screens/Notes/View/add_note_screen.dart';
import 'package:valid_airtech/Screens/Service/Controller/service_controller.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/View/add_site_screen.dart';
import 'package:valid_airtech/Screens/WorkReport/View/work_report_details_screen.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import 'package:valid_airtech/utils/share_predata.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import 'edit_note_screen.dart';


class NotesListByDateScreen extends StatefulWidget {
  final String date;
  NotesListByDateScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _NotesListByDateScreenState createState() => _NotesListByDateScreenState();
}

class _NotesListByDateScreenState extends State<NotesListByDateScreen> {

  NotesController notesController = Get.put(NotesController());


  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await notesController.getLoginData();

    printData("_initializeData", "_initializeData");
    notesController.notesList.clear();
    notesController.callNoteListByDate(widget.date);
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
          'Valid Services',
          style: AppTextStyle.largeBold.copyWith(fontSize: 18
              , color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: color_secondary),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(() =>Stack(
        children: [
          Column(
            children: [

              Container(
                width: double.infinity,
                color: color_primary,
                padding: const EdgeInsets.all(12),
                child:  Center(
                  child: Text(
                    'Notes',
                    style: AppTextStyle.largeBold.copyWith(fontSize: 14
                        , color: Colors.white),
                    textAlign: TextAlign.center,

                  ),
                ),
              ),


              SizedBox(height: 12,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color_primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {

                  Get.to(AddNotesScreen());

                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add',
                      style:AppTextStyle.largeBold.copyWith(fontSize: 13
                          , color: Colors.white),
                    ),
                    SizedBox(width: 4,),

                    Icon(Icons.add, color: Colors.white,)

                  ],
                ),
              ),

              notesController.notesList.isNotEmpty?Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: notesController.notesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        notesController.selectedNote.value = notesController.notesList[index];
                        Get.to(EditNotesScreen())?.then((value) {
                          notesController.isLoading.value = false;
                          notesController.callNoteListByDate(widget.date);
                        });
                      },
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Note Date',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                notesController.notesList[index].date??"",
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),
                              const SizedBox(height: 12),
                               Text(
                                'Note 1',
                                style: AppTextStyle.largeMedium.copyWith(fontSize: 12
                                    , color: color_brown_title),
                              ),
                              Text(
                                (notesController.notesList[index].note?[0].name??"").toString(),
                                style:  AppTextStyle.largeRegular.copyWith(fontSize: 15
                                    , color: Colors.black),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ):Expanded(child: Center(child: Text("No data found"),)),
            ],
          ),

          if(notesController.isLoading.value)Center(child: CircularProgressIndicator(),)
        ],
      )),

    );
  }
}

