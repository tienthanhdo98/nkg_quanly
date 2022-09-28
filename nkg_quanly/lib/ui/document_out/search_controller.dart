import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/model/misstion/mission_model.dart';

import '../../const/api.dart';
import '../../model/birthday_model/birthday_model.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';
import '../../model/document_out_model/document_out_model.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../../model/misstion/mission_detail.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../model/proflie_model/profile_model.dart';
import '../../model/report_model/report_model.dart';

class SearchController extends GetxController {
  RxList<DocumentOutItems> listDataDocOut = <DocumentOutItems>[].obs;
  RxList<MissionItem> listDataMission = <MissionItem>[].obs;
  RxList<MeetingRoomItems> listDataRoomMeeting = <MeetingRoomItems>[].obs;
  RxList<CalendarWorkListItems> listDataCalendarWork = <CalendarWorkListItems>[].obs;
  RxList<BirthDayListItems> listDataBirthDay = <BirthDayListItems>[].obs;
  RxList<ProfileItems> listDataProfile = <ProfileItems>[].obs;
  RxList<ReportListItems> listDataReport= <ReportListItems>[].obs;
  RxList<ProfileProcedureListItems> listDataProfileProc = <ProfileProcedureListItems>[].obs;


  Map<String, String> headers = {"Content-type": "application/json"};
  void searchDataDocOut(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentOutModel res =DocumentOutModel.fromJson(jsonDecode(response.body));
    listDataDocOut.value = res.items!;
  }
  void searchDataMission(String keyword) async {
    final url = Uri.parse(apiGetMission);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    MissionModel res =MissionModel.fromJson(jsonDecode(response.body));
    listDataMission.value = res.items!;
  }
  void searchDataRoomMeeting(String keyword) async {
    final url = Uri.parse(apiPostAllMeetingroom);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));
    print(res.totalRecords);
    listDataRoomMeeting.value = res.items!;
  }
  void searchDataCalendarWork(String keyword) async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    CalendarWorkModel res = CalendarWorkModel.fromJson(jsonDecode(response.body));
    print(res.totalRecords);
    listDataCalendarWork.value = res.items!;
  }
  void searchDataBirthDay(String keyword) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    print(res.totalRecords);
    listDataBirthDay.value = res.items!;
  }

  void searchDataProfile(String keyword) async {
    final url = Uri.parse(apiGetProfile);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    ProfileModel res = ProfileModel.fromJson(jsonDecode(response.body));
    listDataProfile.value = res.items!;
  }
  void searchDataReport(String keyword) async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ReportModel reportModel =  ReportModel.fromJson(jsonDecode(response.body));
    listDataReport.value = reportModel.items!;
  }
  void searchDataProfileProc(String keyword) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    ProfileProcedureModel reportModel =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    listDataProfileProc.value = reportModel.items!;
  }

}
