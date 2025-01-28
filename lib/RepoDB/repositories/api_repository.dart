import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:valid_airtech/Screens/Sites/Model/employee_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/transportation_list_response.dart';



import '../../Screens/Authentication/Model/login_request.dart';
import '../../Screens/Authentication/Model/login_response.dart';
import '../../Screens/Authentication/Model/reset_password_response.dart';

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

  /// Get Site List
  Future<SiteListResponse> siteList() async {
    try {

      Response response = await api.dio.post("/get_all_site",
          options: Options(
          ));
      dynamic postMaps = response.data;
      return SiteListResponse.fromJson(postMaps);
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

}
