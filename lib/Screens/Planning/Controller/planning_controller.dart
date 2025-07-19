import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Planning/Model/add_planning_request.dart';


import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Appointment/Model/appointment_contact_list_response.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Conveyance/Model/conveyance_list_response.dart';
import '../../Conveyance/Model/head_conveyance_list_response.dart';
import '../../Instruments/Model/head_instrument_list_response.dart';
import '../../Instruments/Model/isntrument_list_response.dart';
import '../../Service/Model/service_list_response.dart';
import '../../Sites/Model/site_list_response.dart';
import '../../WorkmanProfile/Model/workman_list_response.dart';
import '../Model/convey_model.dart';
import '../Model/instrument_model.dart';
import '../Model/planning_list_response.dart';


/// Controller
class PlanningController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;
  APIRepository postRepository = APIRepository();
  RxList<NoteAddPlanning> notesList = <NoteAddPlanning>[].obs;
  Rx<AddPlanningRequest> addPlanningRequest = AddPlanningRequest().obs;
  RxList<WorkmanData> workmanList = <WorkmanData>[].obs;
  RxList<AddWorkman> selectedWorkmanList = <AddWorkman>[].obs;
  RxList<PlanningData> planningList = <PlanningData>[].obs;
  RxList<ConveyanceData> conveysList = <ConveyanceData>[].obs;

  // RxList<ConveyanceData> filteredConveysList = <ConveyanceData>[].obs;

  RxList<AddConveyanceForPlanning> selectedConveysList = <AddConveyanceForPlanning>[].obs;
  Rx<PlanningData> selectedPlanning = PlanningData().obs;
  RxList<HeadConveyanceData> headConveysList = <HeadConveyanceData>[].obs;

  RxList<HeadInstrumentData> headInstrumentList = <HeadInstrumentData>[].obs;
  RxList<InstrumentData> instrumentList = <InstrumentData>[].obs;
  // RxList<InstrumentData> filteredInstrumentList = <InstrumentData>[].obs;

  RxList<AddInstrumentForPlanning> selectedInstrumentList = <AddInstrumentForPlanning>[].obs;
  Rx<LoginData> loginData = LoginData().obs;
  RxList<SiteData> siteList = <SiteData>[].obs;
  RxList<AppointmentContactData> appointmentContactList = <AppointmentContactData>[].obs;

  RxList<ServiceData> serviceList = <ServiceData>[].obs;
  RxList<AddPlanningModel> addPlanningList = <AddPlanningModel>[].obs;


  final Rx<TextEditingController> controllerTrain = TextEditingController(text: "0")
      .obs;

  final Rx<TextEditingController> controllerBus = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerAuto = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerFuel = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerFoodAmount = TextEditingController(text:"0")
      .obs;

  final Rx<TextEditingController> controllerOther = TextEditingController()
      .obs;

  final Rx<TextEditingController> controllerRemarksForOther = TextEditingController()
      .obs;

  final Rx<TextEditingController> controllerUsername = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerCity = TextEditingController().obs;
  final Rx<
      TextEditingController> controllerPhoneNumber = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerEmailId = TextEditingController()
      .obs;
  final Rx<TextEditingController> controllerPassword = TextEditingController()
      .obs;



  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }


  /// Service list api call
  Future<void> callServiceListList() async {
    try {
      isLoading.value = true;

      ServiceListResponse response = await postRepository.serviceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        serviceList.value = response.data??[];
      } else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// site list api call
  Future<void> callSiteList() async {

    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      SiteListResponse response = await postRepository.siteList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        siteList.value = response.data??[];
      }else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Contact list api call
  Future callContactListList(String headId) async {
    try {
      isLoading.value = true;

      AppointmentContactListResponse response = await postRepository.appointmentContactList(loginData.value.token??"", headId);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        appointmentContactList.value = response.data??[];
      }else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Head Instrument list api call
  Future<void> callHeadInstrumentList() async {
    try {
      isLoading.value = true;

      HeadInstrumentResponse response = await postRepository.headInstrumentList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        headInstrumentList.value = response.data??[];
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Instrument list api call
  Future<void> callInstrumentList() async {
    try {
      isLoading.value = true;

      InstrumentListResponse response = await postRepository.instrumentList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        instrumentList.value = response.data??[];
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Head Conveyance list api call
  Future<void> callHeadConveyanceList() async {
    try {
      isLoading.value = true;

      HeadConveyanceListResponse response = await postRepository.headConveyanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        headConveysList.value = response.data??[];
      } else {

      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Conveyance list api call
  Future<void> callConveyanceList() async {
    try {
      isLoading.value = true;

      ConveyanceListResponse response = await postRepository.conveyanceList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {


        conveysList.value = response.data??[];
      } else {

      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Planning create api call
  Future<void> callCreatePlanning() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createPlanning(loginData.value.token ?? "",addPlanningRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message??"");
        printData("response", response.message??"");


      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Planning update api call
  Future<void> callUpdatePlanning() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updatePlanning(loginData.value.token ?? "",addPlanningRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message??"");
        printData("response", response.message??"");


      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }


  /// Workman list api call
  Future<void> callWorkmanList() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response = await postRepository.workmanList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {

        workmanList.value = response.data??[];
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }


  /// Planning delete api call
  Future<void> callDeletePlanning(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deletePlanning(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Planning deleted successfully");
      } else if (response.code == 401) {
        Helper().logout();
      }else {
        Get.snackbar("Error", response.message ?? "Something went wrong");
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Planning list api call
  void callPlanningList() async {
    try {
      isLoading.value = true;

      PlanningListResponse response = await postRepository.planningList(loginData.value.token??"");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        planningList.value = response.data??[];
      }else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }

  /// Planning list by date api call
  void callPlanningListByDate(String date) async {
    try {
      isLoading.value = true;
      PlanningListResponse response = await postRepository.planningListByDate(loginData.value.token??"", date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        planningList.value = response.data??[];
      }else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }


  /// Planning list by month api call
  void callPlanningListByMonth(String date, String endDate) async {
    try {
      isLoading.value = true;
      PlanningListResponse response = await postRepository.planningListByMonth(loginData.value.token??"", date,endDate);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        planningList.value = response.data??[];
      }else if(response.code == 401){
        Helper().logout();
      }
    } catch (ex) {
      if (ex is DioException) {
        errorMessage.value = ex.type.toString();
      } else {
        errorMessage.value = ex.toString();
      }
      Get.snackbar('Error', errorMessage.value);
    }
  }





  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<PlanningController>();
  }

  ///Clear all field
  clearAllField() {
    controllerUsername.value.clear();
    controllerCity.value.clear();
    controllerPhoneNumber.value.clear();
    controllerEmailId.value.clear();
    controllerPassword.value.clear();
  }

  callFilterConveyanceList(String headId, int position){
    selectedConveysList[position]
        .filteredConveysList.clear();
    for(int i=0; i<conveysList.length; i++){
      if(conveysList[i].headConveyanceId.toString() == headId){
        selectedConveysList[position]
            .filteredConveysList.add(conveysList[i]);
      }
    }
  }

 Future<AddConveyanceForPlanning> callFilterConveyanceListAndGet(String headId, AddConveyanceForPlanning addConveyanceForPlanning) async {
    addConveyanceForPlanning
        .filteredConveysList.clear();
    for(int i=0; i<conveysList.length; i++){
      if(conveysList[i].headConveyanceId.toString() == headId){
        addConveyanceForPlanning
            .filteredConveysList.add(conveysList[i]);
      }
    }

    return addConveyanceForPlanning;
  }


  callFilterInstrumentList(String headId, int position){
    selectedInstrumentList[position].filteredInstrumentList.clear();
    for(int i=0; i<instrumentList.length; i++){
      if(instrumentList[i].headInstrumentId.toString() == headId){
        selectedInstrumentList[position].filteredInstrumentList.add(instrumentList[i]);
      }
    }
  }

  Future<AddInstrumentForPlanning> callFilterInstrumentListAndGet(String headId, AddInstrumentForPlanning addInstrumentForPlanning)async{
    addInstrumentForPlanning.filteredInstrumentList.clear();
    for(int i=0; i<instrumentList.length; i++){
      if(instrumentList[i].headInstrumentId.toString() == headId){
        addInstrumentForPlanning.filteredInstrumentList.add(instrumentList[i]);
      }
    }

    return addInstrumentForPlanning;
  }
}
