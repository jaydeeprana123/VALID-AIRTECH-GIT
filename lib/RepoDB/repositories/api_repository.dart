import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/Model/admin_leave_request_list_response.dart';
import 'package:valid_airtech/Screens/Allowance/Model/admin_expense_list_response.dart';
import 'package:valid_airtech/Screens/Allowance/Model/allowance_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/admin_attendance_list_response.dart';
import 'package:valid_airtech/Screens/Attendance/Model/admin_create_attendance_request.dart';
import 'package:valid_airtech/Screens/Authentication/Model/change_password_request.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/admin_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/update_conveyance_request.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/Model/add_leave_request.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/Model/emp_leave_request_list_response.dart';
import 'package:valid_airtech/Screens/Head/Model/create_head_request.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/HomeAllowance/model/create_home_allowance_request.dart';
import 'package:valid_airtech/Screens/HomeAllowance/model/home_allowance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/create_instrument_request.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/isntrument_list_response.dart';
import 'package:valid_airtech/Screens/Notes/Model/create_notes_request.dart';
import 'package:valid_airtech/Screens/Offices/Model/office_list_response.dart';
import 'package:valid_airtech/Screens/Planning/Model/add_planning_request.dart';
import 'package:valid_airtech/Screens/Service/Model/service_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/driver_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/employee_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/test_type_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/transportation_list_response.dart';
import 'package:valid_airtech/Screens/TestPerform/Model/create_test_perform_request.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/admin_work_report_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/service_by_nature_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/service_status_model.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/test_by_perform_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Model/work_report_list_response.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/create_workman_request.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';
import 'package:valid_airtech/Widget/common_widget.dart';
import '../../Screens/Allowance/Model/create_allowance_request.dart';
import '../../Screens/Attendance/Model/admin_update_attendance_request.dart';
import '../../Screens/Attendance/Model/attendance_list_response.dart';
import '../../Screens/Attendance/Model/create_attendance_in_request.dart';
import '../../Screens/Authentication/Model/login_request.dart';
import '../../Screens/Authentication/Model/login_response.dart';
import '../../Screens/Authentication/Model/reset_password_response.dart';
import '../../Screens/Circular/Model/circular_list_response.dart';
import '../../Screens/Conveyance/Model/admin_conveyance_payment_list_response.dart';
import '../../Screens/Conveyance/Model/admin_create_conveyance_payment_request.dart';
import '../../Screens/Conveyance/Model/admin_create_conveyance_request.dart';
import '../../Screens/Head/Model/head_list_response.dart';
import '../../Screens/Notes/Model/note_list_response.dart';
import '../../Screens/Offices/Model/create_office_request.dart';
import '../../Screens/Planning/Model/planning_list_response.dart';
import '../../Screens/Service/Model/create_service_request.dart';
import '../../Screens/WorkReport/Model/site_by_service_list_response.dart';
import '../../base_model.dart';
import 'api/api.dart';

class APIRepository {
  API api = API();

  /// Login
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      // var user = {'mail': email, "password" : password};
      var formData = FormData.fromMap(loginRequest.toJson());

      Response response = await api.dio.post("/login",
          data: formData,
          options: Options(
            headers: {
            'Cookie': 'ci_session=769b4e56ca5cbcf48ab63c7bc45489bcc579903b'
            },
          ));
      dynamic postMaps = response.data;
      return LoginResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Profile details
  Future<LoginResponse> profile(String userToken) async {
    try {
      var user = {'user_token': userToken};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/get_user_profile_detail",
          data: formData,
          options: Options(
          ));
      dynamic postMaps = response.data;
      return LoginResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Change Password
  Future<BaseModel> changePassword(ChangePasswordRequest changePasswordRequest, String token) async {
    try {
      // var user = {'mail': email, "password" : password};
      var formData = FormData.fromMap(changePasswordRequest.toJson());

      Response response = await api.dio.post("/user/change-password",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Change Password
  Future<LoginResponse> editProfile(LoginData loginData, String? filePath,String token) async {
    try {
      // var user = {'mail': email, "password" : password};
      var data = FormData.fromMap({
        if((filePath??"").isNotEmpty)'files': [
          await MultipartFile.fromFile(filePath??"", filename: '')
        ],
        'id': loginData.id,
        'name': loginData.name,
        'user_name': loginData.userName,
        'mobile_number': loginData.mobileNumber,
        'email': loginData.email
      });

      Response response = await api.dio.post("/profile/update-profile",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return LoginResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Get Attendance List
  Future<AttendanceListResponse> attendanceList(String token, String empId) async {
    try {

      Response response = await api.dio.get("/attendence/list",
          queryParameters: {'emp_id': empId}, // <-- This is the right way
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AttendanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Get Attendance List
  Future<AttendanceListResponse> attendanceListByDate(String token, String empId, String date) async {
    try {

      Response response = await api.dio.get("/attendence/calender-list",
          queryParameters: {'emp_id': empId, "date":date}, // <-- This is the right way
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AttendanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Attendance
  Future<BaseModel> createAdminAttendance(String token, AdminCreateAttendanceRequest adminCreateAttendanceRequest) async {
    try {
      Response response = await api.dio.post("/admin-attendence/create",
          data: adminCreateAttendanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Attendance
  Future<BaseModel> updateAdminAttendance(String token, AdminUpdateAttendanceRequest adminUpdateAttendanceRequest) async {
    try {
      Response response = await api.dio.post("/admin-attendence/update",
          data: adminUpdateAttendanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Create Attendance
  Future<BaseModel> createAttendanceIn(String token, CreateAttendanceInRequest createAttendanceRequest) async {
    try {
      Response response = await api.dio.post("/attendence/in",
          data: createAttendanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Attendance
  Future<BaseModel> createAttendanceOut(String token, CreateAttendanceInRequest createAttendanceRequest) async {
    try {
      Response response = await api.dio.post("/attendence/out",
          data: createAttendanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Get Appointment List
  Future<AppointmentListResponse> appointmentList(String token) async {
    try {

      Response response = await api.dio.get("/appointment/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AppointmentListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Appointment List By Date
  Future<AppointmentListResponse> appointmentListByDate(String token, String date) async {
    try {

      var data = json.encode({
        "date": date,
      });

      Response response = await api.dio.post("/appointment/calender-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AppointmentListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Appointment List By Date
  Future<AppointmentContactListResponse> appointmentContactList(String token, String headId) async {
    try {

      var data = json.encode({
        "head_id": headId,
      });

      Response response = await api.dio.post("/appointment/contact-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AppointmentContactListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }





  /// Create Appointment
  Future<BaseModel> createAppointment(String token, CreateAppointmentRequest createAppointmentRequest) async {
    try {
      Response response = await api.dio.post("/appointment/create",
          data: createAppointmentRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Appointment
  Future<BaseModel> updateAppointment(String token, CreateAppointmentRequest createAppointmentRequest) async {
    try {
      Response response = await api.dio.post("/appointment/update",
          data: createAppointmentRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Appointment
  Future<BaseModel> deleteAppointment(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/appointment/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Site List
  Future<SiteListResponse> empSiteList(String token, String empId) async {
    try {
      var user = {'emp_id': empId};
      var formData = FormData.fromMap(user);
      Response response = await api.dio.post("/attendence/site-list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return SiteListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Site List
  Future<SiteListResponse> siteList(String token) async {
    try {

      Response response = await api.dio.get("/site/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return SiteListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Head
  Future<BaseModel> createSite(String token, CreateSiteRequest createSiteRequest) async {
    try {


      Response response = await api.dio.post("/site/create",
          data: createSiteRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Delete Allowance
  Future<BaseModel> deleteSite(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/site/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Get Office List
  Future<OfficeListResponse> officeList(String token) async {
    try {

      Response response = await api.dio.get("/office/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return OfficeListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Get Office List
  Future<OfficeListResponse> empOfficeList(String token, String empId) async {
    try {

      var data = json.encode({
        "emp_id": empId,
      });


      Response response = await api.dio.post("/attendence/office-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return OfficeListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  ///Site attend by list
  Future<SiteByServiceLIstResponse> siteAttendByList(String token) async {
    try {

      var data = json.encode({
        "attendence_id": "3",
      });


      Response response = await api.dio.get("/work-report/site-attend-by-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return SiteByServiceLIstResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Service by Nature list
  Future<ServiceByNatureResponse> serviceByNatureList(String token) async {
    try {

      var data = json.encode({
        "attendence_id": "3",
      });


      Response response = await api.dio.get("/work-report/service-nature-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return ServiceByNatureResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Test performer list
  Future<TestByPerformanceListResponse> testPerformerList(String token) async {
    try {

      var data = json.encode({
        "attendence_id": "3",
      });


      Response response = await api.dio.get("/work-report/test-perform-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return TestByPerformanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Admin Test perform list
  Future<TestByPerformanceListResponse> adminTestPerformList(String token) async {
    try {

      var data = json.encode({
        "admin_conveyance_id": "1",
      });


      Response response = await api.dio.get("/admin-test-performed/list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return TestByPerformanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  ///Admin Create Test Perform
  Future<BaseModel> createTestPerform(String token, CreateTestPerformRequest createTestPerformRequest) async {
    try {


      Response response = await api.dio.post("/admin-test-performed/create",
          data: createTestPerformRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Test Perform
  Future<BaseModel> updateTestPerform(String token, CreateTestPerformRequest createTestPerformRequest) async {
    try {

      Response response = await api.dio.post("/admin-test-performed/update",
          data: createTestPerformRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Test Perform
  Future<BaseModel> deleteTestPerform(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/admin-test-performed/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }







  /// Get Work report List
  Future<WorkReportListResponse> workReportList(String token, String empId) async {
    try {

      var data = json.encode({
        "emp_id": empId,
      });


      Response response = await api.dio.get("/work-report/list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return WorkReportListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Work report
  Future<BaseModel> createWorkReport(String token, String date, String empId,
      String siteId,List<SiteAttendByData> siteAttendByList,  List<RemarkWorkReport> comments, String? conveyThrough, String other,  List<ServiceStatusModel> serviceStatusList,  List<String> sheetStatusList,  List<String> conveyThroughList,String conveyanceId,String serviceNatureIdId,String contactPerson, String witnessPerson) async {
    try {
      Map<String, dynamic> employeeMap = {};
      Map<String, dynamic> remarkMap = {};
      Map<String, dynamic> testLocationMap = {};
      Map<String, dynamic> roomEquipmentMap = {};
      Map<String, dynamic> testPerformedIdByMap = {};
      Map<String, dynamic> instrumentIdByMap = {};
      Map<String, dynamic> statusMap = {};
      for (int i = 0; i < serviceStatusList.length; i++){
        remarkMap['remark[$i][remark]'] = serviceStatusList[i].remarkTextEditingController.text;
        testLocationMap['service_status[$i][test_location]'] = serviceStatusList[i].testLocationEditingController.text;
        roomEquipmentMap['service_status[$i][room_equipment]'] = serviceStatusList[i].roomEquipmentEditingController.text;
        testPerformedIdByMap['service_status[$i][test_perfomed_id]'] = serviceStatusList[i].testPerformData != null?serviceStatusList[i].testPerformData?.id.toString():"";
        instrumentIdByMap['service_status[$i][head_instrument_id]'] = serviceStatusList[i].usedInstrument != null?serviceStatusList[i].usedInstrument?.id.toString():"";
        statusMap['service_status[$i][status]'] = serviceStatusList[i].dataSheetStatus != null?sheetStatusList.indexOf(serviceStatusList[i].dataSheetStatus??"").toString():"";
        employeeMap['service_status[$i][perform_user_id]'] =serviceStatusList[i].workmanData != null?serviceStatusList[i].workmanData?.id.toString():"";


      }


      Map<String, dynamic> commentsByMap = {};
      for (int i = 0; i < comments.length; i++) {
        commentsByMap['remark[$i][remark]'] =
            comments[i].remarkTextEditingController.text;
      }

      Map<String, dynamic> siteAttendByMap = {};
      for (int i = 0; i < siteAttendByList.length; i++) {
        siteAttendByMap['site_attend_by[$i][user_id]'] =
            siteAttendByList[i].id.toString();
      }


        // Map<String, dynamic> photoFileMap = {};
      //
      // for (int i = 0; i < bills.length; i++) {
      //   final filePath = bills[i].path;
      //   final fileName = filePath?.split('/').last;
      //
      //   photoFileMap['expence_bill[$i][photo]'] = await MultipartFile.fromFile(
      //     filePath??"",
      //     filename: fileName,
      //   );
      // }

      var data = FormData.fromMap({

        'emp_id': empId,
        'site_id': siteId,
        'convenyence_through_status': conveyThrough != null?(conveyThroughList.indexOf(conveyThrough) + 1).toString():"",
        'other':other,
        'conveyance_id': conveyanceId,
        'service_nature_id': serviceNatureIdId,
        'contact_person': contactPerson,
        'witness_person': witnessPerson,
        'date': date,
        ...commentsByMap,
        ...siteAttendByMap,
        ...remarkMap, // spread remarks into the main map
        ...testLocationMap,
        ...roomEquipmentMap,
        ...testPerformedIdByMap,
        ...instrumentIdByMap,
        ...statusMap,
        ...employeeMap,
      });

      Response response = await api.dio.post("/work-report/create",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// eDIT Work report
  Future<BaseModel> updateWorkReport(String token,String id, String date, String empId,
      String siteId,List<SiteAttendByData> siteAttendByList,   List<RemarkWorkReport> comments, String? conveyThrough, String other,  List<ServiceStatusModel> serviceStatusList,  List<String> sheetStatusList,  List<String> conveyThroughList,String conveyanceId,String serviceNatureIdId,String contactPerson, String witnessPerson) async {
    try {

      Map<String, dynamic> remarkMap = {};
      Map<String, dynamic> testLocationMap = {};
      Map<String, dynamic> roomEquipmentMap = {};
      Map<String, dynamic> testPerformedIdByMap = {};
      Map<String, dynamic> instrumentIdByMap = {};
      Map<String, dynamic> statusMap = {};
      Map<String, dynamic> employeeMap = {};
      for (int i = 0; i < serviceStatusList.length; i++){
        remarkMap['remark[$i][remark]'] = serviceStatusList[i].remarkTextEditingController.text;
        testLocationMap['service_status[$i][test_location]'] = serviceStatusList[i].testLocationEditingController.text;
        roomEquipmentMap['service_status[$i][room_equipment]'] = serviceStatusList[i].roomEquipmentEditingController.text;
        testPerformedIdByMap['service_status[$i][test_perfomed_id]'] = serviceStatusList[i].testPerformData != null?serviceStatusList[i].testPerformData?.id.toString():"";
        instrumentIdByMap['service_status[$i][head_instrument_id]'] = serviceStatusList[i].usedInstrument != null?serviceStatusList[i].usedInstrument?.id.toString():"";
        statusMap['service_status[$i][status]'] = serviceStatusList[i].dataSheetStatus != null?sheetStatusList.indexOf(serviceStatusList[i].dataSheetStatus??"").toString():"";
        employeeMap['service_status[$i][perform_user_id]'] =serviceStatusList[i].workmanData != null?serviceStatusList[i].workmanData?.id.toString():"";

      }


      Map<String, dynamic> commentsByMap = {};
      for (int i = 0; i < comments.length; i++) {
        commentsByMap['remark[$i][remark]'] =
            comments[i].remarkTextEditingController.text;
      }

      Map<String, dynamic> siteAttendByMap = {};
      for (int i = 0; i < siteAttendByList.length; i++) {
        remarkMap['site_attend_by[$i][user_id]'] =
            siteAttendByList[i].id.toString();
      }


      // Map<String, dynamic> photoFileMap = {};
      //
      // for (int i = 0; i < bills.length; i++) {
      //   final filePath = bills[i].path;
      //   final fileName = filePath?.split('/').last;
      //
      //   photoFileMap['expence_bill[$i][photo]'] = await MultipartFile.fromFile(
      //     filePath??"",
      //     filename: fileName,
      //   );
      // }

      var data = FormData.fromMap({

        "id": id,
        'emp_id': empId,
        'site_id': siteId,
        'convenyence_through_status': conveyThrough != null?(conveyThroughList.indexOf(conveyThrough) + 1).toString():"",
        'other':other,
        'conveyance_id': conveyanceId,
        'service_nature_id': serviceNatureIdId,
        'contact_person': contactPerson,
        'witness_person': witnessPerson,
        'date': date,
        ...commentsByMap,
        ...siteAttendByMap,
        ...remarkMap, // spread remarks into the main map
        ...testLocationMap,
        ...roomEquipmentMap,
        ...testPerformedIdByMap,
        ...instrumentIdByMap,
        ...statusMap,
        ...employeeMap,
      });

      Response response = await api.dio.post("/work-report/update",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }




  /// Delete Allowance
  Future<BaseModel> deleteWorkReport(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/work-report/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Office
  Future<BaseModel> createOffice(String token, CreateOfficeRequest createOfficeRequest) async {
    try {
      Response response = await api.dio.post("/office/create",
          data: createOfficeRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Office
  Future<BaseModel> updateOffice(String token, CreateOfficeRequest createOfficeRequest) async {
    try {

      Response response = await api.dio.post("/office/update",
          data: createOfficeRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Allowance
  Future<BaseModel> deleteOffice(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/office/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Delete Allowance
  Future<BaseModel> deleteHead(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/head/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Edit Head
  Future<BaseModel> editSite(String token, CreateSiteRequest createSiteRequest) async {
    try {


      Response response = await api.dio.post("/site/update",
          data: createSiteRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Test Type List
  Future<HeadListResponse> headListList(String token) async {
    try {

      Response response = await api.dio.get("/head/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return HeadListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Head
  Future<BaseModel> createHead(String token, CreateHeadRequest createHeadRequest) async {
    try {


      Response response = await api.dio.post("/head/create",
          data: createHeadRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Head
  Future<BaseModel> updateHead(String token, CreateHeadRequest createHeadRequest) async {
    try {


      Response response = await api.dio.post("/head/update",
          data: createHeadRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }






  /// Service List
  Future<ServiceListResponse> serviceList(String token) async {
    try {

      Response response = await api.dio.get("/service/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return ServiceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Service
  Future<BaseModel> createService(String token, CreateServiceRequest createServiceRequest) async {
    try {


      Response response = await api.dio.post("/service/create",
          data: createServiceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Service
  Future<BaseModel> updateService(String token, CreateServiceRequest updateServiceRequest) async {
    try {


      Response response = await api.dio.post("/service/update",
          data: updateServiceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Service
  Future<BaseModel> deleteService(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/service/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Admin Expense List
  Future<AdminExpenseListResponse> adminExpenseList(String token, String type, String empId, String startDate, String endDate) async {
    try {

      var data = json.encode({
        "type":type,
        "emp_id": empId,
        "start_date": startDate,
        "end_date": endDate
      });

      Response response = await api.dio.post("/admin-report/expence-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminExpenseListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Admin Conveyance  List
  Future<AdminConveyanceListResponse> adminConveyanceList(String token) async {
    try {


      Response response = await api.dio.get("/admin-conveyance/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminConveyanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Admin Conveyance List by date
  Future<AdminConveyanceListResponse> adminConveyanceListDate(String token, String date) async {
    try {

      var user = {"date": date};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/admin-conveyance/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminConveyanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Create Admin Conveyance
  Future<BaseModel> adminCreateConveyance(String token, AdminCreateConveyanceRequest createConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/admin-conveyance/create",
          data: createConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Admin Conveyance
  Future<BaseModel> adminUpdateConveyance(String token, AdminCreateConveyanceRequest updateConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/admin-conveyance/update",
          data: updateConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Admin Conveyance
  Future<BaseModel> adminDeleteConveyance(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/admin-conveyance/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


///  admin-conveyance-payment

  /// Admin admin-conveyance-payment  List
  Future<AdminConveyancePaymentListResponse> adminConveyancePaymentList(String token, String adminConveyanceId) async {
    try {
      var data = json.encode({
        "admin_conveyance_id": adminConveyanceId,
      });

      Response response = await api.dio.post("/admin-conveyance-payment/list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminConveyancePaymentListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// admin-conveyance-payment List by date
  Future<AdminConveyancePaymentListResponse> adminConveyancePaymentListDate(String token, String date) async {
    try {

      var user = {"date": date};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/admin-conveyance-payment/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminConveyancePaymentListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Create admin-conveyance-payment
  Future<BaseModel> adminCreateConveyancePayment(String token, AdminCreateConveyancePaymentRequest createConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/admin-conveyance-payment/create",
          data: createConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update admin-conveyance-payment
  Future<BaseModel> adminUpdateConveyancePayment(String token, AdminCreateConveyancePaymentRequest updateConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/admin-conveyance-payment/update",
          data: updateConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Admin Conveyance
  Future<BaseModel> adminDeleteConveyancePayment(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/admin-conveyance-payment/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }





  /// Admin Conveyance Report List
  Future<AdminConveyanceListResponse> adminConveyanceReportList(String token, String type, String empId, String startDate, String endDate) async {
    try {

      var data = json.encode({
        "type":type,
        "emp_id": empId,
        "start_date": startDate,
        "end_date": endDate
      });

      Response response = await api.dio.post("/admin-report/conveyance-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminConveyanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Admin Attendance List
  Future<AdminAttendanceListResponse> adminAttendanceList(String token, String type, String empId, String startDate, String endDate) async {
    try {

      var data = json.encode({
        "type":type,
        "emp_id": empId,
        "start_date": startDate,
        "end_date": endDate
      });

      Response response = await api.dio.post("/admin-report/admin-attendence-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminAttendanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }




  /// Admin Work Report List
  Future<AdminWorkReportListResponse> adminWorkReportList(String token, String type, String empId, String startDate, String endDate) async {
    try {

      var data = json.encode({
        "type":type,
        "emp_id": empId,
        "start_date": startDate,
        "end_date": endDate
      });

      Response response = await api.dio.post("/admin-report/work-report-list",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AdminWorkReportListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Allowance List
  Future<AllowanceListResponse> allowanceList(String token) async {
    try {

      Response response = await api.dio.get("/allowance/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return AllowanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Home Allowance List
  Future<HomeAllowanceListResponse> homeAllowanceList(String token) async {
    try {

      Response response = await api.dio.get("/home_allowance/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return HomeAllowanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  ///Home Allowance List
  Future<HomeAllowanceListResponse> homeAllowanceListByDate(String token, String date) async {
    try {

      var user = {"date": date};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/home_allowance/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return HomeAllowanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Allowance
  Future<BaseModel> createAllowance(String token, CreateAllowanceRequest createAllowanceRequest) async {
    try {


      Response response = await api.dio.post("/allowance/create",
          data: createAllowanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Delete Allowance
  Future<BaseModel> deleteHomeAllowance(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/home_allowance/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Home Allowance
  Future<BaseModel> createHomeAllowance(String token, CreateHomeAllowanceRequest createHomeAllowanceRequest) async {
    try {
      Response response = await api.dio.post("/home_allowance/create",
          data: createHomeAllowanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Home Allowance
  Future<BaseModel> updateHomeAllowance(String token, CreateHomeAllowanceRequest createHomeAllowanceRequest) async {
    try {
      Response response = await api.dio.post("/home_allowance/update",
          data: createHomeAllowanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Allowance
  Future<BaseModel> updateAllowance(String token, CreateAllowanceRequest updateAllowanceRequest) async {
    try {


      Response response = await api.dio.post("/allowance/update",
          data: updateAllowanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Allowance
  Future<BaseModel> deleteAllowance(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/allowance/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Conveyance List
  Future<ConveyanceListResponse> conveyanceList(String token) async {
    try {

      Response response = await api.dio.get("/conveyance/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return ConveyanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Conveyance
  Future<BaseModel> createConveyance(String token, CreateConveyanceRequest createConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/conveyance/create",
          data: createConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Conveyance
  Future<BaseModel> updateConveyance(String token, UpdateConveyanceRequest updateConveyanceRequest) async {
    try {


      Response response = await api.dio.post("/conveyance/update",
          data: updateConveyanceRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Conveyance
  Future<BaseModel> deleteConveyance(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/conveyance/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Head Conveyance List
  Future<HeadConveyanceListResponse> headConveyanceList(String token) async {
    try {

      Response response = await api.dio.get("/head-conveyance/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return HeadConveyanceListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Conveyance Head
  Future<BaseModel> createHeadConveyance(String token, String name) async {
    try {

      var data = json.encode({
        "name": name
      });

      Response response = await api.dio.post("/head-conveyance/create",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update Conveyance Head
  Future<BaseModel> updateHeadConveyance(String token, String name, String id) async {
    try {

      var data = json.encode({
        "id": id,
        "name": name
      });

      Response response = await api.dio.post("/head-conveyance/update",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Conveyance Head
  Future<BaseModel> deleteConveyanceHead(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/head-conveyance/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Head Instrument List
  Future<HeadInstrumentResponse> headInstrumentList(String token) async {
    try {

      Response response = await api.dio.get("/head-instrument/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return HeadInstrumentResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Instrument Head
  Future<BaseModel> deleteInstrumentHead(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/head-instrument/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Instrument Head
  Future<BaseModel> createHeadInstrument(String token, String name) async {
    try {

      var data = json.encode({
        "name": name
      });

      Response response = await api.dio.post("/head-instrument/create",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Instrument Head
  Future<BaseModel> updateHeadInstrument(String token, String name, String id) async {
    try {

      var data = json.encode({
        "id": id,
        "name": name
      });

      Response response = await api.dio.post("/head-instrument/update",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// instrument List
  Future<InstrumentListResponse> instrumentList(String token) async {
    try {

      Response response = await api.dio.get("/instrument/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return InstrumentListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Instrument
  Future<BaseModel> createInstrument(String token, CreateInstrumentRequest createInstrumentRequest) async {
    try {


      Response response = await api.dio.post("/instrument/create",
          data: createInstrumentRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Instrument
  Future<BaseModel> updateInstrument(String token, CreateInstrumentRequest createInstrumentRequest) async {
    try {


      Response response = await api.dio.post("/instrument/update",
          data: createInstrumentRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Instrument
  Future<BaseModel> deleteInstrument(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/instrument/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }




  /// Note List
  Future<NoteListResponse> noteList(String token, String empId) async {
    try {
      var user = {'emp_id': empId};
      var formData = FormData.fromMap(user);
      Response response = await api.dio.post("/note/list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return NoteListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Note List
  Future<NoteListResponse> noteListByDate(String token, String date, String empId) async {
    try {

      var user = {"date": date,'emp_id':empId};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/note/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return NoteListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Note
  Future<BaseModel> createNote(String token, CreateNotesRequest createNoteRequest) async {
    try {
      Response response = await api.dio.post("/note/create",
          data: createNoteRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Note
  Future<BaseModel> updateNote(String token, CreateNotesRequest createNoteRequest) async {
    try {


      Response response = await api.dio.post("/note/update",
          data: createNoteRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Note
  Future<BaseModel> deleteNote(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/note/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }



  /// Planning List
  Future<PlanningListResponse> planningList(String token) async {
    try {

      Response response = await api.dio.get("/planning/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return PlanningListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Planning List
  Future<PlanningListResponse> planningListByDate(String token, String date) async {
    try {

      var user = {"date": date};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/planning/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return PlanningListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Planning
  Future<BaseModel> createPlanning(String token, AddPlanningRequest addPlanningRequest) async {
    try {
      Response response = await api.dio.post("/planning/create",
          data: addPlanningRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Planning
  Future<BaseModel> updatePlanning(String token, AddPlanningRequest addPlanningRequest) async {
    try {


      Response response = await api.dio.post("/planning/update",
          data: addPlanningRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Planning
  Future<BaseModel> deletePlanning(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/planning/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Circular List
  Future<CircularListResponse> circularList(String token, String empId) async {
    try {
      var user = {'emp_id': empId};
      var formData = FormData.fromMap(user);
      Response response = await api.dio.post("/employee-circular/list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return CircularListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Circular List
  Future<CircularListResponse> employeeCircularList(String token, String empId) async {
    try {
      var user = {'emp_id': empId};
      var formData = FormData.fromMap(user);
      Response response = await api.dio.post("/employee-circular/list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return CircularListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Circular List By date
  Future<CircularListResponse> employeeCircularListByDate(String token, String empId, String date) async {
    try {
      var user = {'emp_id': empId, "date" :date};
      var formData = FormData.fromMap(user);
      Response response = await api.dio.post("/employee-circular/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return CircularListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create Circular
  Future<BaseModel> createCircular(String token, String empId, String date,String title, String pdfPath,String fileName) async {
    try {

      printData("pdfPath 11", pdfPath);

      var data = FormData.fromMap({
        'pdf': [
          await MultipartFile.fromFile(pdfPath, filename: fileName)
        ],
        'emp_id': empId,
        'date': date,
        'title': title
      });

      Response response = await api.dio.post("/employee-circular/create",
          data: data ,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Update Circular
  Future<BaseModel> updateCircular(String token, String id, String empId, String date,String title, String pdfPath) async {
    try {

      var data = FormData.fromMap({
        if(pdfPath.isNotEmpty)'pdf': [
          await MultipartFile.fromFile(pdfPath, filename: '')
        ],
        'id': id,
        'emp_id': empId,
        'date': date,
        'title': title
      });
      Response response = await api.dio.post("/employee-circular/update",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Circular
  Future<BaseModel> deleteCircular(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/employee-circular/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }







  /// Workman List
  Future<WorkmanListResponse> workmanList(String token) async {
    try {

      Response response = await api.dio.get("/workman-profile/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
          ));
      dynamic postMaps = response.data;
      return WorkmanListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Conveyance
  Future<BaseModel> createWorkman(String token, CreateWorkmanRequest createWorkmanRequest) async {
    try {
      Response response = await api.dio.post("/workman-profile/create",
          data: createWorkmanRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Create Workman
  Future<BaseModel> updateWorkman(String token, CreateWorkmanRequest createWorkmanRequest) async {
    try {
      Response response = await api.dio.post("/workman-profile/update",
          data: createWorkmanRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete Workman
  Future<BaseModel> deleteWorkman(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/workman-profile/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Emp leave requet list
  Future<EmpLeaveRequestListResponse> employeeLeaveRequestList(String token, String empId) async {
    try {

      var user = {'emp_id': empId};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/employee-leave-request/list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return EmpLeaveRequestListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Create EmpLeaveRequest
  Future<BaseModel> createEmpLeaveRequest(String token, AddLeaveRequest addLeaveRequest) async {
    try {


      Response response = await api.dio.post("/employee-leave-request/create",
          data: addLeaveRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Update EmpLeaveRequest
  Future<BaseModel> updateEmpLeaveRequest(String token, AddLeaveRequest addLeaveRequest) async {
    try {


      Response response = await api.dio.post("/employee-leave-request/update",
          data: addLeaveRequest.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Delete EmpLeaveRequest
  Future<BaseModel> deleteEmpLeaveRequest(String token, String id) async {
    try {

      var data = json.encode({
        "id": id,
      });

      Response response = await api.dio.post("/employee-leave-request/delete",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return BaseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  /// Admin leave requet list
  Future<AdminLeaveRequestListResponse> adminLeaveRequestList(String token) async {
    try {
      Response response = await api.dio.get("/admin-leave-request/list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return AdminLeaveRequestListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Admin leave requet list
  Future<AdminLeaveRequestListResponse> adminLeaveRequestListByDateWorkman(String token, String empId, String date) async {
    try {

      var user = {'emp_id': empId, "date": date};
      var formData = FormData.fromMap(user);

      Response response = await api.dio.post("/admin-leave-request/calender-list",
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return AdminLeaveRequestListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Admin leave requet list
  Future<AdminLeaveRequestListResponse> adminLeaveRequestPendingList(String token) async {
    try {
      Response response = await api.dio.get("/admin-leave-request/pending_list",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },


          ));
      dynamic postMaps = response.data;
      return AdminLeaveRequestListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Test Type List
  Future<TestTypeListResponse> testTypeList() async {
    try {

      Response response = await api.dio.post("/get_all_test_type",
          options: Options(
          ));
      dynamic postMaps = response.data;
      return TestTypeListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Employee List
  Future<EmployeeListResponse> employeeList() async {
    try {

      Response response = await api.dio.get("/get_all_employee",
          options: Options(
          ));
      dynamic postMaps = response.data;
      return EmployeeListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Transportation List
  Future<TransportationListResponse> transportationList() async {
    try {

      Response response = await api.dio.post("/get_all_transportation",
          options: Options(
          ));
      dynamic postMaps = response.data;
      return TransportationListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  /// Get Driver List
  Future<DriverListResponse> driverList() async {
    try {

      Response response = await api.dio.post("/get_all_driver",
          options: Options(
          ));
      dynamic postMaps = response.data;
      return DriverListResponse.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }






}
