import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:valid_airtech/Screens/AdminLeaveRequest/Model/admin_leave_request_list_response.dart';
import 'package:valid_airtech/Screens/Allowance/Model/allowance_list_response.dart';
import 'package:valid_airtech/Screens/Authentication/Model/change_password_request.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/create_conveyance_request.dart';
import 'package:valid_airtech/Screens/Conveyance/Model/update_conveyance_request.dart';
import 'package:valid_airtech/Screens/EmpLeaveRequest/Model/emp_leave_request_list_response.dart';
import 'package:valid_airtech/Screens/Head/Model/create_head_request.dart';
import 'package:valid_airtech/Screens/HeadConveyance/Model/head_conveyance_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/create_instrument_request.dart';
import 'package:valid_airtech/Screens/Instruments/Model/head_instrument_list_response.dart';
import 'package:valid_airtech/Screens/Instruments/Model/isntrument_list_response.dart';
import 'package:valid_airtech/Screens/Service/Model/service_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/create_site_request.dart';
import 'package:valid_airtech/Screens/Sites/Model/driver_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/employee_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/test_type_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/transportation_list_response.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/create_workman_request.dart';
import 'package:valid_airtech/Screens/WorkmanProfile/Model/workman_list_response.dart';



import '../../Screens/Allowance/Model/create_allowance_request.dart';
import '../../Screens/Authentication/Model/login_request.dart';
import '../../Screens/Authentication/Model/login_response.dart';
import '../../Screens/Authentication/Model/reset_password_response.dart';

import '../../Screens/Head/Model/head_list_response.dart';
import '../../Screens/Service/Model/create_service_request.dart';
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

      Response response = await api.dio.post("/profile/change-password",
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

  /// Conveyance List
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

      Response response = await api.dio.post("/get_all_employee",
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
