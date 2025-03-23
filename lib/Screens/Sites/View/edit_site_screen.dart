import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Head/Model/head_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Controller/planning_controller.dart';
import 'package:valid_airtech/Screens/Planning/Model/convey_model.dart';
import 'package:valid_airtech/Screens/Planning/Model/instrument_model.dart';
import 'package:valid_airtech/Screens/Sites/Controller/site_controller.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/bills_model.dart';
import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../Model/add_contact_model.dart';

class EditSiteScreen extends StatefulWidget {
  @override
  _EditSiteScreenState createState() => _EditSiteScreenState();
}

class _EditSiteScreenState extends State<EditSiteScreen> {
  SiteController siteController = Get.find<SiteController>();
  String? selectedSite;
  final List<String> contactTypeOptions = ['Mobile', 'Telephone'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform navigation or state updates after build completes
      siteController.callHeadListList();
      siteController.contactList.clear();
      siteController.isEdit.value = false;
      selectedSite = siteController.siteDetails.value.headId.toString();
      siteController.siteAddressController.value.text =
          siteController.siteDetails.value.headAddress ?? "";
      siteController.suffixController.value.text =
          siteController.siteDetails.value.sufix ?? "";
      siteController.contactNameController.value.text =
          siteController.siteDetails.value.contactName ?? "";
      siteController.departmentNameController.value.text =
          siteController.siteDetails.value.departmentName ?? "";
      siteController.contactEmailController.value.text =
          siteController.siteDetails.value.email ?? "";

      if ((siteController.siteDetails.value.contact ?? []).isNotEmpty) {
        for (int i = 0;
            i < (siteController.siteDetails.value.contact ?? []).length;
            i++) {
          AddContactModel addContactModel = AddContactModel();
          addContactModel.id = siteController.siteDetails.value.contact?[i].id.toString();
          addContactModel.type =
              siteController.siteDetails.value.contact?[i].contactType == 1
                  ? "Mobile"
                  : "Telephone";

          if (siteController.siteDetails.value.contact?[i].contactType == 1) {
            addContactModel.textEditingControllerNum.text =
                siteController.siteDetails.value.contact?[i].mobileNo ?? "";
          } else {
            addContactModel.textEditingControllerNum.text =
                siteController.siteDetails.value.contact?[i].mobileNo ?? "";
          }
          siteController.contactList.add(addContactModel);
        }
      }else{
        siteController.contactList.add(AddContactModel());
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
          'Site Details',
          style: AppTextStyle.largeBold
              .copyWith(fontSize: 18, color: color_secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar, color: color_secondary),
            onPressed: () {
              siteController.isEdit.value = true;
            },
          ),

          IconButton(
            icon: Icon(Icons.delete_forever, color: color_secondary),
            onPressed: () {
              Get.defaultDialog(
                  title: "DELETE",
                  middleText:
                  "Are you sure want to delete this site?",
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
                    siteController.callDeleteSite(siteController.siteDetails.value.id.toString());

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

                    _buildDropdown(
                        siteController.headList as List<HeadData>,
                        selectedSite,
                        (val) => setState(() => selectedSite = val),
                        "Site Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(siteController.siteAddressController.value,
                        "Site Address"),

                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(
                        siteController.suffixController.value, "Suffix"),

                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(siteController.contactNameController.value,
                        "Contact Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(
                        siteController.departmentNameController.value,
                        "Department Name"),

                    SizedBox(
                      height: 16,
                    ),

                    _buildTextField(siteController.contactEmailController.value,
                        "Contact Email Id"),
                    SizedBox(
                      height: 16,
                    ),

                    _buildSectionTitle("Contact No's"),

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
                              i < siteController.contactList.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdownString(
                                          contactTypeOptions,
                                          siteController.contactList[i].type,
                                          (val) => setState(() => siteController
                                              .contactList[i].type = val),
                                          "Type"),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: _buildTextField(
                                          siteController.contactList[i]
                                              .textEditingControllerNum,
                                          'No. ${i + 1}'),
                                    ),
                                    (i ==
                                            (siteController.contactList.length -
                                                1))
                                        ? InkWell(
                                            onTap: () {
                                              siteController.contactList
                                                  .add(AddContactModel());
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 30,
                                              color: color_brown_title,
                                            ))
                                        : InkWell(
                                            onTap: () {

                                              RemovedContact removedContact = RemovedContact();
                                              removedContact.removedContactId = siteController.contactList[i].id.toString();
                                              siteController.removedContactList.add(removedContact);

                                              siteController.contactList
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

                    // Login Button
             siteController.isEdit.value == true?Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CommonButton(
                        titleText: "Save",
                        textColor: Colors.white,
                        onCustomButtonPressed: () async {
                          siteController.createSiteRequest.value =
                              CreateSiteRequest();

                          siteController.createSiteRequest.value.id =
                              siteController.siteDetails.value.id.toString();
                          siteController.createSiteRequest.value.headId =
                              selectedSite ?? "";
                          siteController.createSiteRequest.value.headAddress =
                              siteController.siteAddressController.value.text;
                          siteController.createSiteRequest.value.sufix =
                              siteController.suffixController.value.text;
                          siteController.createSiteRequest.value.contactName =
                              siteController.contactNameController.value.text;
                          siteController
                                  .createSiteRequest.value.departmentName =
                              siteController
                                  .departmentNameController.value.text;
                          siteController.createSiteRequest.value.email =
                              siteController.contactEmailController.value.text;

                          siteController.createSiteRequest.value.contact = [];
                          for (int i = 0;
                              i < siteController.contactList.length;
                              i++) {
                            Contact contact = Contact();
                            contact.id = siteController.contactList[i].id??"";
                            contact.contactType =
                                (siteController.contactList[i].type ?? "") ==
                                        "Mobile"
                                    ? "1"
                                    : "2";

                            if (contact.contactType == "1") {
                              contact.mobileNo = siteController.contactList[i]
                                  .textEditingControllerNum.value.text;
                            } else if (contact.contactType == "2") {
                              contact.telephone = siteController.contactList[i]
                                  .textEditingControllerNum.value.text;
                            }

                            siteController.createSiteRequest.value.contact
                                ?.add(contact);
                          }

                          siteController.createSiteRequest.value.removedContact?.addAll(siteController.removedContactList);

                          siteController.callEditSite();
                        },
                        borderColor: color_primary,
                        borderWidth: 0,
                      ),
                    ):SizedBox(),
                  ],
                ),
              ),
              if (siteController.isLoading.value)
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

  Widget _buildDropdown(List<HeadData> items, String? selectedValue,
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
