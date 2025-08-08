import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/admin_attendance_list_response.dart';
import 'package:valid_airtech/Screens/Attendance/Model/attendance_list_response.dart';
import 'package:valid_airtech/Screens/Attendance/Model/create_attendance_in_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/filter_attendance_data.dart';
import 'package:valid_airtech/Screens/Offices/Model/office_list_response.dart';

import '../../../RepoDB/repositories/api_repository.dart';
import '../../../Widget/common_widget.dart';
import '../../../base_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/preference_utils.dart';
import '../../../utils/share_predata.dart';
import '../../Authentication/Model/login_response.dart';
import '../../Sites/Model/site_list_response.dart';
import 'package:intl/intl.dart';

import '../../WorkReport/Model/work_report_list_response.dart';
import '../../WorkmanProfile/Model/workman_list_response.dart';
import '../Model/admin_create_attendance_request.dart';
import '../Model/admin_update_attendance_request.dart';
import '../Model/site_attendance_data.dart';

/// Controller
class AttendanceController extends GetxController {
  String? selectedPlace;
  String? statusOfAttendance;
  String? selectedSite;
  String? selectedOffice;
  String? attendanceId;

  APIRepository postRepository = APIRepository();
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;
  RxBool isEdit = false.obs;
  Rx<LoginData> loginData = LoginData().obs;
  RxList<SiteData> siteList = <SiteData>[].obs;
  RxList<OfficeData> officeList = <OfficeData>[].obs;
  RxList<String> statusList = <String>[].obs;
  RxList<String> attendanceStatusList = <String>[].obs;
  Rx<AdminCreateAttendanceRequest> adminCreateAttendanceRequest =
      AdminCreateAttendanceRequest().obs;

  RxList<FilterAttendanceData> filterAttendanceData =
      <FilterAttendanceData>[].obs;
  RxList<FilterAttendanceData> finalFilterAttendanceData =
      <FilterAttendanceData>[].obs;

  RxList<SiteAttendanceData> filterSiteAttendanceData =
      <SiteAttendanceData>[].obs;

  RxList<SiteAttendanceData> siteAttendanceData = <SiteAttendanceData>[].obs;
  RxList<SiteAttendanceData> finalSiteAttendanceData =
      <SiteAttendanceData>[].obs;

  RxList<WorkReportData> workReportListByDates = <WorkReportData>[].obs;

  RxList<AdminAttendanceData> adminAttendanceList = <AdminAttendanceData>[].obs;
  RxList<WorkmanData> workmanList = <WorkmanData>[].obs;
  Rx<AdminAttendanceData> selectedAdminAttendanceData =
      AdminAttendanceData().obs;
  Rx<AdminUpdateAttendanceRequest> adminUpdateAttendanceRequest =
      AdminUpdateAttendanceRequest().obs;
  RxList<AttendanceData> attendanceList = <AttendanceData>[].obs;
  Rx<AttendanceData> selectedAttendance = AttendanceData().obs;
  RxList<AppointmentContactData> attendanceContactList =
      <AppointmentContactData>[].obs;
  Rx<TextEditingController> fromDateEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> toDateEditingController =
      TextEditingController().obs;
  Rx<CreateAttendanceInRequest> createAttendanceInRequest =
      CreateAttendanceInRequest().obs;

  Future<void> getLoginData() async {
    loginData.value =
        await MySharedPref().getLoginModel(SharePreData.keySaveLoginModel) ??
            LoginData();

    statusList.clear();
    statusList.add("In");
    statusList.add("Out");

    attendanceStatusList.clear();
    attendanceStatusList.add("P (Present)");
    attendanceStatusList.add("PA (Present Absent)");
    attendanceStatusList.add("O (Weekly Off)");
    attendanceStatusList.add("H (Holiday)");
    attendanceStatusList.add("A (Absent)");
    printData("token", loginData.value.token ?? "");

    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String todayDate = formatter.format(now);

// Get the first day of the previous month
    DateTime oneMonthBefore = DateTime(
      now.month == 1 ? now.year - 1 : now.year,
      now.month == 1 ? 12 : now.month - 1,
      1,
    );

    String oneMonthBeforeDate = formatter.format(oneMonthBefore);

    fromDateEditingController.value.text = oneMonthBeforeDate;
    toDateEditingController.value.text = todayDate;
  }

  /// Workman list api call
  Future<void> callWorkmanList() async {
    try {
      isLoading.value = true;

      WorkmanListResponse response =
          await postRepository.workmanList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      workmanList.clear();
      if (response.status ?? false) {
        workmanList.value = response.data ?? [];
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Admin Attendance list api call
  Future<void> callAdminAttendanceList(String empId) async {
    try {
      isLoading.value = true;

      AdminAttendanceListResponse response =
          await postRepository.adminAttendanceList(
              loginData.value.token ?? "",
              "0",
              empId,
              fromDateEditingController.value.text,
              toDateEditingController.value.text);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));
      adminAttendanceList.clear();
      if (response.status ?? false) {
        adminAttendanceList.value = response.data ?? [];
      } else if (response.code == 401) {
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

      SiteListResponse response =
          await postRepository.siteList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        siteList.value = response.data ?? [];
      } else if (response.code == 401) {
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

  /// office list api call
  Future<void> callOfficeList() async {
    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      OfficeListResponse response =
          await postRepository.officeList(loginData.value.token ?? "");
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        officeList.value = response.data ?? [];
      } else if (response.code == 401) {
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

  /// site Emp list api call
  Future<void> callEmpSiteList() async {
    printData("callSiteList", "callSiteList");
    try {
      isLoading.value = true;

      SiteListResponse response = await postRepository.empSiteList(
          loginData.value.token ?? "", loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        siteList.value = response.data ?? [];
      } else if (response.code == 401) {
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

  /// office list api call
  Future<void> callEmpOfficeList() async {
    printData("callEmpOfficeList", "callEmpOfficeList");
    try {
      isLoading.value = true;

      OfficeListResponse response = await postRepository.empOfficeList(
          loginData.value.token ?? "", loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        officeList.value = response.data ?? [];
      } else if (response.code == 401) {
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

  /// Attendance list api call
  Future<void> callAttendanceList(List<WorkReportData> workReportList) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response = await postRepository.attendanceList(
          loginData.value.token ?? "", loginData.value.id.toString());
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        attendanceList.value = response.data ?? [];
        siteAttendanceData.clear();
        filterAttendanceData.clear();
        for (int i = 0; i < attendanceList.length; i++) {
          bool isDateAvail = false;

          for (int j = 0; j < filterAttendanceData.length; j++) {
            if (attendanceList[i].date == filterAttendanceData[j].date) {
              isDateAvail = true;
              bool entryUpdated = false;

              for (int z = 0;
                  z < filterAttendanceData[j].siteAttendanceData.length;
                  z++) {
                final siteData = filterAttendanceData[j].siteAttendanceData[z];

                final isSameHead = attendanceList[i].headId != null &&
                    attendanceList[i].headId == siteData.headId;

                final isSameOffice = attendanceList[i].officeId != null &&
                    attendanceList[i].officeId == siteData.officeId;

                if (isSameHead || isSameOffice) {
                  if (attendanceList[i].status == 1) {
                    siteData.inTime = attendanceList[i].time ?? "";
                    siteData.siteInLat = attendanceList[i].lat;
                    siteData.siteInLong = attendanceList[i].long;
                  } else if (attendanceList[i].status == 2) {
                    siteData.outTime = attendanceList[i].time ?? "";
                    siteData.siteOutLat = attendanceList[i].lat;
                    siteData.siteOutLong = attendanceList[i].long;
                  }

                  entryUpdated = true;
                  break;
                }
              }

              if (!entryUpdated) {
                filterAttendanceData[j].siteAttendanceData.add(
                      SiteAttendanceData(
                        siteName:
                            (attendanceList[i].officeName ?? "").isNotEmpty
                                ? attendanceList[i].officeName!
                                : (attendanceList[i].headName ?? ""),
                        headId: attendanceList[i].headId,
                        officeId: attendanceList[i].officeId,
                        inTime: attendanceList[i].status == 1
                            ? attendanceList[i].time ?? ""
                            : "",
                        outTime: attendanceList[i].status == 2
                            ? attendanceList[i].time ?? ""
                            : "",
                        siteInLat: attendanceList[i].status == 1
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteInLong: attendanceList[i].status == 1
                            ? attendanceList[i].long ?? ""
                            : "",
                        siteOutLat: attendanceList[i].status == 2
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteOutLong: attendanceList[i].status == 2
                            ? attendanceList[i].long ?? ""
                            : "",
                      ),
                    );
              }

              break;
            }
          }

          if (!isDateAvail) {
            // Add new date entry
            final newFilterData = FilterAttendanceData();
            newFilterData.date = attendanceList[i].date ?? "";
            newFilterData.siteAttendanceData = [
              SiteAttendanceData(
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              )
            ];
            filterAttendanceData.add(newFilterData);
          }
        }

        for (int i = 0; i < attendanceList.length; i++) {
          printData("date of attendance", attendanceList[i].date ?? "");

          bool entryUpdated = false;

          for (int j = 0; j < siteAttendanceData.length; j++) {
            final isSameDate = attendanceList[i].date ==
                siteAttendanceData[j].dateOfAttendance;

            final isSameHead = attendanceList[i].headId != null &&
                attendanceList[i].headId == siteAttendanceData[j].headId;

            final isSameOffice = attendanceList[i].officeId != null &&
                attendanceList[i].officeId == siteAttendanceData[j].officeId;

            if (isSameDate && (isSameHead || isSameOffice)) {
              if (attendanceList[i].status == 1) {
                siteAttendanceData[j].inTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteInLat = attendanceList[i].lat;
                siteAttendanceData[j].siteInLong = attendanceList[i].long;
              } else if (attendanceList[i].status == 2) {
                siteAttendanceData[j].outTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteOutLat = attendanceList[i].lat;
                siteAttendanceData[j].siteOutLong = attendanceList[i].long;
              }

              entryUpdated = true;
              break;
            }
          }

          if (!entryUpdated) {
            siteAttendanceData.add(
              SiteAttendanceData(
                dateOfAttendance: attendanceList[i].date ?? "",
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              ),
            );
          }
        }

        printData("workReportList length", workReportList.length.toString());

        for (int i = 0; i < siteAttendanceData.length; i++) {
          for (int j = 0; j < workReportList.length; j++) {
            if ((siteAttendanceData[i].dateOfAttendance ==
                    workReportList[j].date) &&
                (siteAttendanceData[i].headId == workReportList[j].siteId)) {
              siteAttendanceData[i].isWorkReportAvail = true;
            }
          }
        }

        // Update filterSiteAttendanceData (same as siteAttendanceData initially)
        filterSiteAttendanceData.clear();

        for (int i = 0; i < siteAttendanceData.length; i++) {
          if (siteAttendanceData[i].headId != null) {
            filterSiteAttendanceData.add(siteAttendanceData[i]);
          }
        }
      } else if (response.code == 401) {
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

  /// Attendance list api call
  Future<void> callAttendanceListForAdmin(String empId) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response = await postRepository.attendanceList(
          loginData.value.token ?? "", empId);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        attendanceList.value = response.data ?? [];
        siteAttendanceData.clear();
        filterAttendanceData.clear();

        for (int i = 0; i < attendanceList.length; i++) {
          printData("latttyy", attendanceList[i].lat ?? "");

          bool isDateAvail = false;

          for (int j = 0; j < filterAttendanceData.length; j++) {
            if (attendanceList[i].date == filterAttendanceData[j].date) {
              isDateAvail = true;
              bool entryUpdated = false;

              for (int z = 0;
                  z < filterAttendanceData[j].siteAttendanceData.length;
                  z++) {
                final siteData = filterAttendanceData[j].siteAttendanceData[z];

                final isSameHead = attendanceList[i].headId != null &&
                    attendanceList[i].headId == siteData.headId;

                final isSameOffice = attendanceList[i].officeId != null &&
                    attendanceList[i].officeId == siteData.officeId;

                if (isSameHead || isSameOffice) {
                  if (attendanceList[i].status == 1) {
                    siteData.inTime = attendanceList[i].time ?? "";
                    siteData.siteInLat = attendanceList[i].lat;
                    siteData.siteInLong = attendanceList[i].long;
                  } else if (attendanceList[i].status == 2) {
                    siteData.outTime = attendanceList[i].time ?? "";
                    siteData.siteOutLat = attendanceList[i].lat;
                    siteData.siteOutLong = attendanceList[i].long;
                  }

                  entryUpdated = true;
                  break;
                }
              }

              if (!entryUpdated) {
                filterAttendanceData[j]
                    .siteAttendanceData
                    .add(SiteAttendanceData(
                      siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                          ? attendanceList[i].officeName!
                          : (attendanceList[i].headName ?? ""),
                      headId: attendanceList[i].headId,
                      officeId: attendanceList[i].officeId,
                      inTime: attendanceList[i].status == 1
                          ? attendanceList[i].time ?? ""
                          : "",
                      outTime: attendanceList[i].status == 2
                          ? attendanceList[i].time ?? ""
                          : "",
                      siteInLat: attendanceList[i].status == 1
                          ? attendanceList[i].lat ?? ""
                          : "",
                      siteInLong: attendanceList[i].status == 1
                          ? attendanceList[i].long ?? ""
                          : "",
                      siteOutLat: attendanceList[i].status == 2
                          ? attendanceList[i].lat ?? ""
                          : "",
                      siteOutLong: attendanceList[i].status == 2
                          ? attendanceList[i].long ?? ""
                          : "",
                    ));
              }

              break;
            }
          }

          if (!isDateAvail) {
            // Add new date entry
            final newFilterData = FilterAttendanceData();
            newFilterData.date = attendanceList[i].date ?? "";
            newFilterData.siteAttendanceData = [
              SiteAttendanceData(
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              )
            ];

            newFilterData.lat = attendanceList[i].lat ?? "";
            newFilterData.long = attendanceList[i].long ?? "";
            filterAttendanceData.add(newFilterData);
          }
        }

        printData(
            "filter final laaattt",
            (filterAttendanceData[0].date ?? "") +
                (filterAttendanceData[0].lat ?? ""));
        printData("final laaattt",
            (attendanceList[0].date ?? "") + (attendanceList[0].lat ?? ""));

        for (int i = 0; i < attendanceList.length; i++) {
          bool entryUpdated = false;
          for (int j = 0; j < siteAttendanceData.length; j++) {
            if (attendanceList[i].date ==
                siteAttendanceData[j].dateOfAttendance) {
              if (attendanceList[i].headId == siteAttendanceData[j].headId ||
                  attendanceList[i].officeId ==
                      siteAttendanceData[j].officeId) {
                if (attendanceList[i].status == 1) {
                  siteAttendanceData[j].inTime = attendanceList[i].time ?? "";
                  siteAttendanceData[j].siteInLat = attendanceList[i].lat;
                  siteAttendanceData[j].siteInLong = attendanceList[i].long;
                } else if (attendanceList[i].status == 2) {
                  siteAttendanceData[j].outTime = attendanceList[i].time ?? "";
                  siteAttendanceData[j].siteOutLat = attendanceList[i].lat;
                  siteAttendanceData[j].siteOutLong = attendanceList[i].long;
                }

                entryUpdated = true;
                break;
              }
            }
          }

          // If no existing site/office match, add new
          if (!entryUpdated) {
            siteAttendanceData.add(
              SiteAttendanceData(
                dateOfAttendance: attendanceList[i].date ?? "",
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              ),
            );
          }
        }

        for (int j = 0; j < filterAttendanceData.length; j++) {
          final officeDurations = calculateTotalOfficeDuration(
              filterAttendanceData[j].siteAttendanceData);
          final siteDurations = calculateTotalSiteDuration(
              filterAttendanceData[j].siteAttendanceData);

          officeDurations.forEach((officeId, duration) {
            filterAttendanceData[j].officeDuration =
                "${duration.inHours} hours ${duration.inMinutes % 60} mins";

            print(
                "Office $officeId total duration: ${duration.inHours} hours ${duration.inMinutes % 60} mins");
          });

          siteDurations.forEach((siteName, duration) {
            filterAttendanceData[j].siteDuration =
                "${duration.inHours} hours ${duration.inMinutes % 60} mins";

            print(
                "Site $siteName total duration: ${duration.inHours} hours ${duration.inMinutes % 60} mins");
          });
        }

        /// For over all time
        for (int j = 0; j < filterAttendanceData.length; j++) {
          calculateOverallInOutTimes(filterAttendanceData[j]);
        }

        finalFilterAttendanceData.value = generateAttendanceWithAllDates(
            fromDateStr: fromDateEditingController.value.text,
            toDateStr: toDateEditingController.value.text,
            existingData: filterAttendanceData);
      } else if (response.code == 401) {
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

  /// Employee Work report list api call
  Future<void> callEmployeeWorkReportListByMonth(
      String empId, String date, String endDate) async {
    printData("callWorkReportList", "callWorkReportList");
    try {
      isLoading.value = true;
      workReportListByDates.clear();
      WorkReportListResponse response = await postRepository.empWorkReportList(
          loginData.value.token ?? "",
          loginData.value.id.toString(),
          "",
          date,
          endDate);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        workReportListByDates.value = response.data ?? [];
        finalSiteAttendanceData.clear();
        callAttendanceListForAdminSiteReport(workReportListByDates, empId);
      } else if (response.code == 401) {
        Helper().logout();
      } else if (response.code == 404) {
        finalSiteAttendanceData.clear();
      } else {
        finalSiteAttendanceData.clear();
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

  /// Attendance list api call
  Future<void> callAttendanceListForAdminSiteReport(
      List<WorkReportData> workReportList, String empId) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response = await postRepository.attendanceList(
          loginData.value.token ?? "", empId);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        attendanceList.value = response.data ?? [];
        siteAttendanceData.clear();
        filterAttendanceData.clear();
        finalSiteAttendanceData.clear();
        for (int i = 0; i < attendanceList.length; i++) {
          bool isDateAvail = false;

          for (int j = 0; j < filterAttendanceData.length; j++) {
            if (attendanceList[i].date == filterAttendanceData[j].date) {
              isDateAvail = true;
              bool entryUpdated = false;

              for (int z = 0;
                  z < filterAttendanceData[j].siteAttendanceData.length;
                  z++) {
                final siteData = filterAttendanceData[j].siteAttendanceData[z];

                final isSameHead = attendanceList[i].headId != null &&
                    attendanceList[i].headId == siteData.headId;

                final isSameOffice = attendanceList[i].officeId != null &&
                    attendanceList[i].officeId == siteData.officeId;

                if (isSameHead || isSameOffice) {
                  if (attendanceList[i].status == 1) {
                    siteData.inTime = attendanceList[i].time ?? "";
                    siteData.siteInLat = attendanceList[i].lat;
                    siteData.siteInLong = attendanceList[i].long;
                  } else if (attendanceList[i].status == 2) {
                    siteData.outTime = attendanceList[i].time ?? "";
                    siteData.siteOutLat = attendanceList[i].lat;
                    siteData.siteOutLong = attendanceList[i].long;
                  }

                  entryUpdated = true;
                  break;
                }
              }

              if (!entryUpdated) {
                filterAttendanceData[j].siteAttendanceData.add(
                      SiteAttendanceData(
                        siteName:
                            (attendanceList[i].officeName ?? "").isNotEmpty
                                ? attendanceList[i].officeName!
                                : (attendanceList[i].headName ?? ""),
                        headId: attendanceList[i].headId,
                        officeId: attendanceList[i].officeId,
                        inTime: attendanceList[i].status == 1
                            ? attendanceList[i].time ?? ""
                            : "",
                        outTime: attendanceList[i].status == 2
                            ? attendanceList[i].time ?? ""
                            : "",
                        siteInLat: attendanceList[i].status == 1
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteInLong: attendanceList[i].status == 1
                            ? attendanceList[i].long ?? ""
                            : "",
                        siteOutLat: attendanceList[i].status == 2
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteOutLong: attendanceList[i].status == 2
                            ? attendanceList[i].long ?? ""
                            : "",
                      ),
                    );
              }

              break;
            }
          }

          if (!isDateAvail) {
            // Add new date entry
            final newFilterData = FilterAttendanceData();
            newFilterData.date = attendanceList[i].date ?? "";
            newFilterData.siteAttendanceData = [
              SiteAttendanceData(
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              )
            ];

            newFilterData.lat = attendanceList[i].lat ?? "";
            newFilterData.long = attendanceList[i].long ?? "";

            filterAttendanceData.add(newFilterData);
          }
        }

        for (int i = 0; i < attendanceList.length; i++) {
          printData("date of attendance", attendanceList[i].date ?? "");

          bool entryUpdated = false;

          for (int j = 0; j < siteAttendanceData.length; j++) {
            final isSameDate = attendanceList[i].date ==
                siteAttendanceData[j].dateOfAttendance;

            final isSameHead = attendanceList[i].headId != null &&
                attendanceList[i].headId == siteAttendanceData[j].headId;

            final isSameOffice = attendanceList[i].officeId != null &&
                attendanceList[i].officeId == siteAttendanceData[j].officeId;

            if (isSameDate && (isSameHead || isSameOffice)) {
              if (attendanceList[i].status == 1) {
                siteAttendanceData[j].inTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteInLat = attendanceList[i].lat;
                siteAttendanceData[j].siteInLong = attendanceList[i].long;
              } else if (attendanceList[i].status == 2) {
                siteAttendanceData[j].outTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteOutLat = attendanceList[i].lat;
                siteAttendanceData[j].siteOutLong = attendanceList[i].long;
              }

              entryUpdated = true;
              break;
            }
          }

          if (!entryUpdated) {
            siteAttendanceData.add(
              SiteAttendanceData(
                dateOfAttendance: attendanceList[i].date ?? "",
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              ),
            );
          }
        }

        printData("workReportList length", workReportList.length.toString());

        for (int i = 0; i < siteAttendanceData.length; i++) {
          for (int j = 0; j < workReportList.length; j++) {
            if ((siteAttendanceData[i].dateOfAttendance ==
                    workReportList[j].date) &&
                (siteAttendanceData[i].headId == workReportList[j].siteId)) {
              siteAttendanceData[i].isWorkReportAvail = true;
              siteAttendanceData[i].workReportData = workReportList[j];

              finalSiteAttendanceData.add(siteAttendanceData[i]);
            }
          }
        }
      } else if (response.code == 401) {
        Helper().logout();
      } else {
        finalSiteAttendanceData.clear();
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

  /// Attendance list api call
  Future<void> callAttendanceListByDate(String date) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response =
          await postRepository.attendanceListByDate(
              loginData.value.token ?? "", loginData.value.id.toString(), date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        attendanceList.value = response.data ?? [];
      } else if (response.code == 401) {
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

  /// Attendance list api call
  Future<void> callAttendanceListByDateForWorkReport(
      String date, List<WorkReportData> workReportList) async {
    try {
      isLoading.value = true;

      AttendanceListResponse response =
          await postRepository.attendanceListByDate(
              loginData.value.token ?? "", loginData.value.id.toString(), date);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        attendanceList.value = response.data ?? [];
        siteAttendanceData.clear();
        filterAttendanceData.clear();

        for (int i = 0; i < attendanceList.length; i++) {
          bool isDateAvail = false;

          for (int j = 0; j < filterAttendanceData.length; j++) {
            if (attendanceList[i].date == filterAttendanceData[j].date) {
              isDateAvail = true;
              bool entryUpdated = false;

              for (int z = 0;
                  z < filterAttendanceData[j].siteAttendanceData.length;
                  z++) {
                final siteData = filterAttendanceData[j].siteAttendanceData[z];

                final isSameHead = attendanceList[i].headId != null &&
                    attendanceList[i].headId == siteData.headId;

                final isSameOffice = attendanceList[i].officeId != null &&
                    attendanceList[i].officeId == siteData.officeId;

                if (isSameHead || isSameOffice) {
                  if (attendanceList[i].status == 1) {
                    siteData.inTime = attendanceList[i].time ?? "";
                    siteData.siteInLat = attendanceList[i].lat;
                    siteData.siteInLong = attendanceList[i].long;
                  } else if (attendanceList[i].status == 2) {
                    siteData.outTime = attendanceList[i].time ?? "";
                    siteData.siteOutLat = attendanceList[i].lat;
                    siteData.siteOutLong = attendanceList[i].long;
                  }

                  entryUpdated = true;
                  break;
                }
              }

              if (!entryUpdated) {
                filterAttendanceData[j].siteAttendanceData.add(
                      SiteAttendanceData(
                        siteName:
                            (attendanceList[i].officeName ?? "").isNotEmpty
                                ? attendanceList[i].officeName!
                                : (attendanceList[i].headName ?? ""),
                        headId: attendanceList[i].headId,
                        officeId: attendanceList[i].officeId,
                        inTime: attendanceList[i].status == 1
                            ? attendanceList[i].time ?? ""
                            : "",
                        outTime: attendanceList[i].status == 2
                            ? attendanceList[i].time ?? ""
                            : "",
                        siteInLat: attendanceList[i].status == 1
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteInLong: attendanceList[i].status == 1
                            ? attendanceList[i].long ?? ""
                            : "",
                        siteOutLat: attendanceList[i].status == 2
                            ? attendanceList[i].lat ?? ""
                            : "",
                        siteOutLong: attendanceList[i].status == 2
                            ? attendanceList[i].long ?? ""
                            : "",
                      ),
                    );
              }

              break;
            }
          }

          if (!isDateAvail) {
            // Add new date entry
            final newFilterData = FilterAttendanceData();
            newFilterData.date = attendanceList[i].date ?? "";
            newFilterData.siteAttendanceData = [
              SiteAttendanceData(
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              )
            ];
            filterAttendanceData.add(newFilterData);
          }
        }

        for (int i = 0; i < attendanceList.length; i++) {
          printData("date of attendance", attendanceList[i].date ?? "");

          bool entryUpdated = false;

          for (int j = 0; j < siteAttendanceData.length; j++) {
            final isSameDate = attendanceList[i].date ==
                siteAttendanceData[j].dateOfAttendance;

            final isSameHead = attendanceList[i].headId != null &&
                attendanceList[i].headId == siteAttendanceData[j].headId;

            final isSameOffice = attendanceList[i].officeId != null &&
                attendanceList[i].officeId == siteAttendanceData[j].officeId;

            if (isSameDate && (isSameHead || isSameOffice)) {
              if (attendanceList[i].status == 1) {
                siteAttendanceData[j].inTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteInLat = attendanceList[i].lat;
                siteAttendanceData[j].siteInLong = attendanceList[i].long;
              } else if (attendanceList[i].status == 2) {
                siteAttendanceData[j].outTime = attendanceList[i].time ?? "";
                siteAttendanceData[j].siteOutLat = attendanceList[i].lat;
                siteAttendanceData[j].siteOutLong = attendanceList[i].long;
              }

              entryUpdated = true;
              break;
            }
          }

          if (!entryUpdated) {
            siteAttendanceData.add(
              SiteAttendanceData(
                dateOfAttendance: attendanceList[i].date ?? "",
                siteName: (attendanceList[i].officeName ?? "").isNotEmpty
                    ? attendanceList[i].officeName!
                    : (attendanceList[i].headName ?? ""),
                headId: attendanceList[i].headId,
                officeId: attendanceList[i].officeId,
                inTime: attendanceList[i].status == 1
                    ? attendanceList[i].time ?? ""
                    : "",
                outTime: attendanceList[i].status == 2
                    ? attendanceList[i].time ?? ""
                    : "",
                siteInLat: attendanceList[i].status == 1
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteInLong: attendanceList[i].status == 1
                    ? attendanceList[i].long ?? ""
                    : "",
                siteOutLat: attendanceList[i].status == 2
                    ? attendanceList[i].lat ?? ""
                    : "",
                siteOutLong: attendanceList[i].status == 2
                    ? attendanceList[i].long ?? ""
                    : "",
              ),
            );
          }
        }

        printData(
            "siteAttendanceData length", siteAttendanceData.length.toString());

        for (int i = 0; i < siteAttendanceData.length; i++) {
          for (int j = 0; j < workReportList.length; j++) {
            if ((siteAttendanceData[i].dateOfAttendance ==
                    workReportList[j].date) &&
                (siteAttendanceData[i].headId == workReportList[j].siteId)) {
              siteAttendanceData[i].isWorkReportAvail = true;
            }
          }
        }

        // Update filterSiteAttendanceData (same as siteAttendanceData initially)
        filterSiteAttendanceData.clear();

        for (int i = 0; i < siteAttendanceData.length; i++) {
          if (siteAttendanceData[i].headId != null) {
            filterSiteAttendanceData.add(siteAttendanceData[i]);
          }
        }
      } else if (response.code == 401) {
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

  /// Attendance create api call
  Future<void> callCreateAttendanceIn(double lat, double long) async {
    try {
      createAttendanceInRequest.value.lat = lat.toString();
      createAttendanceInRequest.value.long = long.toString();
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.createAttendanceIn(
          loginData.value.token ?? "", createAttendanceInRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");

        selectedSite = null;
        selectedOffice = null;
        selectedPlace = null;
        statusOfAttendance = null;

        refresh();

        callAttendanceListByDate(createAttendanceInRequest.value.date ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Admin Attendance create api call
  Future<void> callAdminCreateAttendance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.createAdminAttendance(
          loginData.value.token ?? "", adminCreateAttendanceRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Admin Attendance update api call
  Future<void> callAdminUpdateAttendance() async {
    try {
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.updateAdminAttendance(
          loginData.value.token ?? "", adminUpdateAttendanceRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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

  /// Attendance out api call
  Future<void> callCreateAttendanceOut(double lat, double long) async {
    try {
      createAttendanceInRequest.value.lat = lat.toString();
      createAttendanceInRequest.value.long = long.toString();
      isLoading.value = true;

      printData("site ", "api called");

      BaseModel response = await postRepository.createAttendanceOut(
          loginData.value.token ?? "", createAttendanceInRequest.value);
      isLoading.value = false;

      // Get.snackbar("response ",loginResponseToJson(response));

      if (response.status ?? false) {
        // Get.back();
        Get.snackbar("Success", response.message ?? "");
        printData("response", response.message ?? "");
        selectedSite = null;
        selectedOffice = null;
        selectedPlace = null;
        statusOfAttendance = null;

        refresh();

        callAttendanceListByDate(createAttendanceInRequest.value.date ?? "");
      } else if (response.code == 401) {
        Helper().logout();
      } else {
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
    Get.delete<AttendanceController>();
  }

  ///Clear all field
  clearAllField() {}

  Map<int, Duration> calculateTotalOfficeDuration(
      List<SiteAttendanceData> dataList) {
    Map<int, Duration> officeDurations = {};

    for (var data in dataList) {
      if (data.officeId != null &&
          data.inTime != null &&
          data.outTime != null &&
          data.inTime!.isNotEmpty &&
          data.outTime!.isNotEmpty) {
        final inTime = DateFormat('HH:mm:ss').parse(data.inTime!);
        final outTime = DateFormat('HH:mm:ss').parse(data.outTime!);

        final duration = outTime.difference(inTime);

        officeDurations[data.officeId!] =
            (officeDurations[data.officeId!] ?? Duration()) + duration;
      }
    }

    return officeDurations;
  }

  Map<String, Duration> calculateTotalSiteDuration(
      List<SiteAttendanceData> dataList) {
    Map<String, Duration> siteDurations = {};

    for (var data in dataList) {
      if (data.headId != null &&
          data.inTime != null &&
          data.outTime != null &&
          data.inTime!.isNotEmpty &&
          data.outTime!.isNotEmpty) {
        final inTime = DateFormat('HH:mm:ss').parse(data.inTime!);
        final outTime = DateFormat('HH:mm:ss').parse(data.outTime!);

        final duration = outTime.difference(inTime);

        siteDurations[data.siteName!] =
            (siteDurations[data.siteName!] ?? Duration()) + duration;
      }
    }

    return siteDurations;
  }

  void calculateOverallInOutTimes(FilterAttendanceData data) {
    DateFormat format = DateFormat('HH:mm:ss');

    // Get all site inTimes
    final siteInTimes = data.siteAttendanceData
        .where(
            (d) => d.headId != null && d.inTime != null && d.inTime!.isNotEmpty)
        .map((d) => format.parse(d.inTime!))
        .toList();

    // Get all site outTimes
    final siteOutTimes = data.siteAttendanceData
        .where((d) =>
            d.headId != null && d.outTime != null && d.outTime!.isNotEmpty)
        .map((d) => format.parse(d.outTime!))
        .toList();

    // Get all office inTimes
    final officeInTimes = data.siteAttendanceData
        .where((d) =>
            d.officeId != null && d.inTime != null && d.inTime!.isNotEmpty)
        .map((d) => format.parse(d.inTime!))
        .toList();

    // Get all office outTimes
    final officeOutTimes = data.siteAttendanceData
        .where((d) =>
            d.officeId != null && d.outTime != null && d.outTime!.isNotEmpty)
        .map((d) => format.parse(d.outTime!))
        .toList();

    // For Site
    if (siteInTimes.isNotEmpty) {
      siteInTimes.sort();
      data.overallSiteInTime = format.format(siteInTimes.first);
    }
    if (siteOutTimes.isNotEmpty) {
      siteOutTimes.sort();
      data.overallSiteOutTime = format.format(siteOutTimes.last);
    }

    // For Office
    if (officeInTimes.isNotEmpty) {
      officeInTimes.sort();
      data.overallOfficeInTime = format.format(officeInTimes.first);
    }
    if (officeOutTimes.isNotEmpty) {
      officeOutTimes.sort();
      data.overallOfficeOutTime = format.format(officeOutTimes.last);
    }
  }

  DateTime parseDDMMYYYY(String dateStr) {
    final parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  List<FilterAttendanceData> generateAttendanceWithAllDates({
    required String fromDateStr, // format: dd-MM-yyyy
    required String toDateStr,
    required List<FilterAttendanceData> existingData, // format: dd-MM-yyyy
  }) {
    final DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    final DateTime fromDate = inputFormat.parse(fromDateStr);
    final DateTime toDate = inputFormat.parse(toDateStr);

    // Map existing data by date for fast lookup
    final Map<String, FilterAttendanceData> dataMap = {
      for (var item in existingData) item.date!: item
    };

    List<FilterAttendanceData> finalList = [];

    for (DateTime current = fromDate;
        !current.isAfter(toDate);
        current = current.add(Duration(days: 1))) {
      String formattedDate = inputFormat.format(current);

      if (dataMap.containsKey(formattedDate)) {
        // Data exists → mark Present
        FilterAttendanceData item = dataMap[formattedDate]!;
        item.attendanceStatus = 'P';
        finalList.add(item);
      } else {
        // Data missing
        String status = current.weekday == DateTime.sunday ? 'Week Off' : 'A';

        finalList.add(FilterAttendanceData()
          ..date = formattedDate
          ..attendanceStatus = status);
      }
    }

    return finalList;
  }

  void filterAttendanceListBySite(String siteId) {
    filterSiteAttendanceData.clear();

    if (siteId == "0") {
      // Show all items
      filterSiteAttendanceData.addAll(siteAttendanceData);
      return;
    }

    printData("selected siteId", siteId);

    printData("Atendance List Length", siteAttendanceData.length.toString());

    for (var item in siteAttendanceData) {
      printData("head ID", "${item.siteName ?? ""} - ${item.headId}");

      if (item.headId.toString() == siteId) {
        printData("Added", "${item.siteName ?? ""} - ${item.headId}");
        filterSiteAttendanceData.add(item);
      }
    }
  }
}
