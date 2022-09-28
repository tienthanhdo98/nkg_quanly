import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/const/api.dart';

import '../../const/ultils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/misstion/mission_detail.dart';
import '../../model/misstion/mission_model.dart';
import '../../model/misstion/misstion_statistic.dart';

class MissionViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<String> rxDate = "".obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<MissionItem> rxMissionItem =
      <MissionItem>[].obs;
  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter= <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter  = <String>[].obs;
  RxList<String> rxListLevelFilter  = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;
  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }

  void checkboxDepartment(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapDepartmentFilter.addAll(map);
    } else {
      mapDepartmentFilter.remove(key);
    }
  }
  void checkboxStatus(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapStatusFilter.addAll(map);
    } else {
      mapStatusFilter.remove(key);
    }
  }
  void checkboxLevel(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapLevelFilter.addAll(map);
    } else {
      mapLevelFilter.remove(key);
    }
  }
  Future<void> getFilterDepartment() async {
    print('loading');
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/mission/department-public"));
    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListDepartmentFilter.value = listUnit;
   print(rxListDepartmentFilter.value);
  }
  Future<void> postMissionByFilter(String status, String level, String department) async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"state":"$status","level":"$level","organizationName":"$department"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    MissionModel res = MissionModel.fromJson(jsonDecode(response.body));
    rxMissionItem.value = res.items!;
  }
  //filter

  @override
  void onInit() {
    getFilterDepartment();
    getFilterForChart("${apiGetMissionChart}0");
    initCurrentDate();
    getMissionByDay(rxDate.value);
    getMissionStatisticInEOffice();
    super.onInit();
  }

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }
  void swtichBottomButton (int button) {
    selectedBottomButton.value = button;
  }
  void initCurrentDate() {
    rxDate.value = DateFormat('yyyy-MM-dd').format(dateNow);
  }

  void onSelectDay(DateTime selectedDay) {
    rxSelectedDay.value = selectedDay;
    var a = DateFormat('yyyy-MM-dd').format(selectedDay);
    print("a $a");
    rxDate.value = formatDateToString(selectedDay);
    print("data ${rxDate.value}");
    getMissionByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel = DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  Map<String, String> headers = {"Content-type": "application/json"};

  //mission
  Future<MissionStatisticModel> getMissionStatistic() async {
    final url = Uri.parse(apiGetMissionStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return MissionStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<void> getMissionByDay(String day) async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    MissionModel res =  MissionModel.fromJson(jsonDecode(response.body));
    rxMissionItem.value = res.items!;
  }
  Future<void> getMissionByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"fromDate":"$datefrom","toDate":"$dateTo"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    MissionModel res =  MissionModel.fromJson(jsonDecode(response.body));
    rxMissionItem.value = res.items!;
  }
  Future<void> getMissionByMonth() async {
    final url = Uri.parse(apiGetMission);
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: jsonGetByMonth);
    print(response.body);
    MissionModel res =  MissionModel.fromJson(jsonDecode(response.body));
    rxMissionItem.value = res.items!;
  }

  Future<MissionItem> getMissionDetail(int id) async {
    final url = Uri.parse("$apiGetMissionDetail$id");
    print(url);
    http.Response response = await http.get(url);
    print(response.body);
    return MissionItem.fromJson(jsonDecode(response.body));
  }
  //e office
  Rx<MissionStatisticModel> rxMissionStatisticModel = MissionStatisticModel().obs;
  Future<void> getMissionStatisticInEOffice() async {
    final url = Uri.parse(apiGetMissionStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    MissionStatisticModel res = MissionStatisticModel.fromJson(jsonDecode(response.body));
    rxMissionStatisticModel.value  = res;

  }



}
