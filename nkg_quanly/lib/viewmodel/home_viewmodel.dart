import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_model.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../model/calendarwork_model/calendarwork_model.dart';
import '../model/document_unprocess/document_filter.dart';
import '../model/misstion/mission_model.dart';
import '../model/misstion/misstion_statistic.dart';
import '../model/proflie_model/profile_model.dart';
import '../model/proflie_model/profile_statistic.dart';


class HomeViewModel extends GetxController {
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
  Future<MissionStatisticModel> getMissionStatistic() async {
    final url = Uri.parse(apiGetMissionStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return MissionStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<MissionModel> getMissionModel() async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return MissionModel.fromJson(jsonDecode(response.body));
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

  //document unprocess
  Future<List<DocumentFilterModel>> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    var list = <DocumentFilterModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => DocumentFilterModel.fromJson(e)).toList();
    return list;
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




}
