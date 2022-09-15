import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_model.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../model/birthday_model/birthday_model.dart';
import '../model/calendarwork_model/calendarwork_model.dart';
import '../model/document_out_model/document_out_model.dart';
import '../model/document_unprocess/document_filter.dart';
import '../model/meeting_room/meeting_room_model.dart';
import '../model/meeting_room/meeting_room_statistic_model.dart';
import '../model/misstion/mission_model.dart';
import '../model/misstion/misstion_statistic.dart';
import '../model/proflie_model/profile_model.dart';
import '../model/proflie_model/profile_statistic.dart';


class HomeViewModel extends GetxController {
  RxList<Items> listData = <Items>[].obs;

  Map<String, String> headers = {"Content-type": "application/json"};
  Future<DocumentModel> getDocument() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    return DocumentModel.fromJson(jsonDecode(response.body));
  }

  Future<DocumentStatisticModel> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocumentStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentStatisticModel.fromJson(jsonDecode(response.body));
  }

  Future<Items> getDocumentDetail(int id) async {
    final url = Uri.parse("${apiGetDocumentDetail}id=$id");
    print('loading detail');
    http.Response response = await http.get(url);
    print(response.body);
    return Items.fromJson(jsonDecode(response.body));
  }

  //calendar work

  Future<CalendarWorkModel> postCalendarWork() async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers:headers, body: json);
    print(response.body);
    return CalendarWorkModel.fromJson(jsonDecode(response.body));
  }
  //document out
  Future<DocumentOutModel> getDocumentOut() async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    return DocumentOutModel.fromJson(jsonDecode(response.body));
  }

  //document unprocess
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }
  // Future<List<DocumentFilterModel>> getQuantityDocumentBuUrl(String url) async {
  //   print('loading');
  //   http.Response response = await http.get(Uri.parse(url));
  //   print(response.body);
  //   var list = <DocumentFilterModel>[];
  //   List a = json.decode(response.body) as List;
  //   list = a.map((e) => DocumentFilterModel.fromJson(e)).toList();
  //   return list;
  // }

  //doc non approve
  void searchData(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentModel res =DocumentModel.fromJson(jsonDecode(response.body));
    listData.value = res.items!;

  }
  // profile ho so trinh
  Future<ProfileStatisticModel> getProfileStatistic() async {
    final url = Uri.parse(apiGetProfileStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return ProfileStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<ProfileModel> postProfile() async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers:headers, body: json);
    print(response.body);
    return ProfileModel.fromJson(jsonDecode(response.body));
  }
  //mission
  Future<DocumentFilterModel> getMissionStatistic() async {
    final url = Uri.parse(apiGetMissionStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }
  Future<MissionModel> getMissionModel() async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    return MissionModel.fromJson(jsonDecode(response.body));
  }
  //Meeting room
  Future<MeetingRoomStatisticModel> getMeetingRoomStatistic() async {
    final url = Uri.parse(apiGetMeetingroomStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return MeetingRoomStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<MeetingRoomModel> getMeetingRoom() async {
    final url = Uri.parse(apiPostAllMeetingroom);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    return  MeetingRoomModel.fromJson(jsonDecode(response.body));
  }
  //birthday
  Future<BirthDayModel> postBirthDay() async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers:headers, body: json);
    print(response.body);
    return BirthDayModel.fromJson(jsonDecode(response.body));
  }




}
