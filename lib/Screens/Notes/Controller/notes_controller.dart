import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Notes/Model/create_notes_request.dart';
import 'package:valid_airtech/Screens/Notes/Model/note_list_response.dart';


import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';


/// Controller
class NotesController extends GetxController {
  Rx<bool> isLoading = false.obs;
  var errorMessage = ''.obs;

  RxBool isEdit = false.obs;
  Rx<CreateNotesRequest> createNotesRequest = CreateNotesRequest().obs;
  Rx<TextEditingController> instrumentNameController = TextEditingController().obs;

  Rx<TextEditingController> instrumentIdNoController = TextEditingController().obs;
  Rx<TextEditingController> modelNoController = TextEditingController().obs;
  Rx<TextEditingController> srNoController = TextEditingController().obs;
  Rx<TextEditingController> makeController = TextEditingController().obs;

  RxList<TextEditingController> workmanList = <TextEditingController>[].obs;
  RxList<NoteData> notesList = <NoteData>[].obs;
  Rx<NoteData> selectedNote= NoteData().obs;

  RxList<NoteNameData> notesNameList = <NoteNameData>[].obs;
  RxList<RemovedNote> removedNoteList = <RemovedNote>[].obs;
  APIRepository postRepository = APIRepository();

  Rx<LoginData> loginData = LoginData().obs;

  Future getLoginData()async{
    loginData.value =  await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel)??LoginData();
  }



  /// Note list api call
  void callNoteList() async {
    try {
      isLoading.value = true;

      NoteListResponse response = await postRepository.noteList(loginData.value.token??"", loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        notesList.value = response.data??[];
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


  ///Note list api call by date
  void callNoteListByDate(String date) async {
    try {
      isLoading.value = true;

      NoteListResponse response = await postRepository.noteListByDate(loginData.value.token??"", date, loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status??false) {
        notesList.value = response.data??[];
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

  /// Note create api call
  Future<void> callCreateNote() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.createNote(loginData.value.token ?? "",createNotesRequest.value);
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

  /// Note update api call
  Future<void> callUpdateNote() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.updateNote(loginData.value.token ?? "",createNotesRequest.value);
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

  /// Instrument delete api call
  Future<void> callDeleteNote(String id) async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response =
      await postRepository.deleteNote(loginData.value.token ?? "",id);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        printData("response", response.message??"");

        Get.snackbar("Success", "Instrument deleted successfully");
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    printData("onClose", "onClose login controller");
    Get.delete<NotesController>();
  }

}
