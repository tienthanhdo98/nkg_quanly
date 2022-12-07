import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../const/utils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/misstion/mission_detail.dart';
import '../../model/misstion/mission_model.dart';

class MissionViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;

  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<MissionItem> rxMissionItem = <MissionItem>[].obs;
  Rx<MissionStatistic> rxMissionStatistic = MissionStatistic().obs;
  Rx<MissionStatistic> rxMissionStatisticTotal = MissionStatistic().obs;
  ScrollController controller = ScrollController();
  MissionModel missionModel = MissionModel();



  @override
  void onInit() {
    getDataInWidget();

    super.onInit();
  }

  void changeValueSelectedFilter(Rx<String> rxSelected, String value) {
    rxSelected.value = value;
  }

  void getDataInScreen() {
    getFilterDepartment();
    getMissionDefault(true);
  }

  void getDataInWidget() {
    getFilterForChart("${apiGetMissionChart}0");
    getMissionDefault(false);
  }

  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  Rx<String> rxDepartmentSelected = "".obs;
  Rx<String> rxLevelSelected = "".obs;
  Rx<String> rxStatusSelected = "".obs;


  void clearSelectedFilter()
  {
    mapDepartmentFilter.clear();
    mapLevelFilter.clear();
    mapStatusFilter.clear();
    mapAllFilter.clear();
    rxLevelSelected.value = "";
    rxDepartmentSelected.value = "";
    rxStatusSelected.value = "";
  }

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
    String json =
        '{"pageIndex":1,"pageSize":10,"state":"$status","level":"$level","organizationName":"$department"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    missionModel = MissionModel.fromJson(jsonDecode(response.body));
    rxMissionItem.value = missionModel.items!;
    rxMissionStatistic.value = missionModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"state":"$status","level":"$level","organizationName":"$department"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        missionModel = MissionModel.fromJson(jsonDecode(response.body));
        rxMissionItem.addAll(missionModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  //filter

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));

    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  Future<void> getMissionDefault(bool isInScreen) async {
    final url = Uri.parse(apiGetMission);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);

    missionModel = MissionModel.fromJson(jsonDecode(response.body));
    if (isInScreen) {
      rxMissionItem.value = missionModel.items!;
      rxMissionStatisticTotal.value = missionModel.statistic!;
      rxMissionStatistic.value = missionModel.statistic!;
      //loadmore
      var page = 1;
      controller.dispose();
      controller = ScrollController();
      controller.addListener(() async {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          page++;
          String json = '{"pageIndex":$page,"pageSize":10}';
          http.Response response =
              await http.post(url, headers: headers, body: json);
          missionModel = MissionModel.fromJson(jsonDecode(response.body));
          rxMissionItem.addAll(missionModel.items!);
        }
      });
    } else {
      rxMissionStatisticTotal.value = missionModel.statistic!;
    }
  }

  Future<void> getMissionByFromAndToDate(String datefrom, String dateTo) async {
    if (datefrom != "" || dateTo != "") {
      final url = Uri.parse(apiGetMission);
      print('loading');
      print('date from $datefrom');
      print('date to $dateTo');
      String json =
          '{"pageIndex":1,"pageSize":10,"fromDate":"$datefrom","toDate":"$dateTo"}';
      http.Response response =
          await http.post(url, headers: headers, body: json);

      missionModel = MissionModel.fromJson(jsonDecode(response.body));
      rxMissionItem.value = missionModel.items!;
      rxMissionStatistic.value = missionModel.statistic!;
      //loadmore
      var page = 1;
      controller.dispose();
      controller = ScrollController();
      controller.addListener(() async {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          print("loadmore week");
          page++;
          String json =
              '{"pageIndex":$page,"pageSize":10,"fromDate":"$datefrom","toDate":"$dateTo"}';
          http.Response response =
              await http.post(url, headers: headers, body: json);
          missionModel = MissionModel.fromJson(jsonDecode(response.body));
          rxMissionItem.addAll(missionModel.items!);
          print("loadmore w at $page");
        }
      });
    }
  }

  Future<MissionItem> getMissionDetail(int id) async {
    final url = Uri.parse("$apiGetMissionDetail$id");
    print(url);
    http.Response response = await http.get(url);

    return MissionItem.fromJson(jsonDecode(response.body));
  }

//e office

}
