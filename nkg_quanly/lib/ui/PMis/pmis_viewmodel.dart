import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../const/utils.dart';
import '../../model/pmis_model/pmis_chart_model.dart';
import '../../model/pmis_model/statistic_total.dart';
import '../../model/pmis_model/unit_model.dart';

class PmisViewModel extends GetxController {


  @override
  void onInit() {
    getStatisticTotal("");
    getPmisPieChartByYear();
    getPmisPieChartByUnit();
    getPmisPieChart("");
    getUnitPmis();

    super.onInit();
  }

  RxList<PmisUnitModel> rxListPmisUnitModel = <PmisUnitModel>[].obs;
  Rx<String> rxTotalBienChe = "0".obs;
  Rx<String> rxTotalCongChuc = "0".obs;
  RxList<PmisChartModel> rxListPmisChartModel = <PmisChartModel>[].obs;
  RxList<PmisChartModel> rxListPmisChartbYear = <PmisChartModel>[].obs;
  RxList<PmisChartModel> rxListPmisChartbUnit= <PmisChartModel>[].obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  final RxMap<int, String> rxMapUnitId = <int, String>{}.obs;
  //pmis

  Future<void> getUnitPmis() async {
    final url = Uri.parse(apiPmisGetUnit);

    http.Response response = await http.get(url);
    var listUnit = <PmisUnitModel>[];
    List a = json.decode(response.body) as List;
    listUnit = a.map((e) => PmisUnitModel.fromJson(e)).toList();
    rxListPmisUnitModel.value = listUnit;
  }
  void searchInnUnitList(String keySearch) async {
    if(keySearch != "") {
      var list = rxListPmisUnitModel.toList().where((element) =>
          element.ten!.toLowerCase().contains(keySearch.toLowerCase())).toList();
      rxListPmisUnitModel.value = list;
    }
    else
    {
      getUnitPmis();
    }
  }
  void checkboxUnitFilter(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      rxMapUnitId.addAll(map);
    } else {
      rxMapUnitId.remove(key);
    }
  }
  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }

  Future<void> getStatisticTotal(String unitId) async {
    Uri url;
    if(unitId == "")
      {
         url = Uri.parse("$apiStatisticTotal");
      }
    else
    {
       url = Uri.parse("$apiStatisticTotal?unit=$unitId");
    }

    http.Response response = await http.get(url);

    StatisticModel pmisStatisticModel =
        StatisticModel.fromJson(json.decode(response.body));
    rxTotalBienChe.value = pmisStatisticModel.tongSoBienChe!;
    rxTotalCongChuc.value = pmisStatisticModel.tongSoCongChuc!;
  }

  RxSet<List<PmisChartModel>> rxMapListChart = <List<PmisChartModel>>{}.obs;
  RxSet<String> rxListTypeChart = <String>{}.obs;

  Future<void> getPmisPieChart(String unitId) async {
    //final url = Uri.parse("$apiPmisPieChart$unitId");
    Uri url;
    if(unitId == "")
    {
      url = Uri.parse(apiPmisPieChart);
    }
    else
    {
      url = Uri.parse("$apiPmisPieChart?unit=$unitId");
    }
    print('$url');
    http.Response response = await http.get(url);

    var listUnit = <PmisChartModel>[];
    List a = json.decode(response.body) as List;
    listUnit = a.map((e) => PmisChartModel.fromJson(e)).toList();
    rxListPmisChartModel.value = listUnit;
    rxMapListChart.clear();
    for (int i = 0; i < rxListPmisChartModel.length; i++) {
      rxListTypeChart.add(rxListPmisChartModel[i].type!);
    }
    List<PmisChartModel> list = [];
    for (var element in rxListTypeChart) {
      for (int i = 0; i < rxListPmisChartModel.length; i++) {
          if(rxListPmisChartModel[i].type == element)
            {
              list = rxListPmisChartModel
                   .where((value) => value.type == element)
                   .toList();
            }
      }
      rxMapListChart.add(list);
    }
    rxMapListChart.refresh();
    print(rxMapListChart.length);

  }

  Future<void> getPmisPieChartByYear() async {
    final url = Uri.parse(apiPmisPieChartByYear);
    print('loading');
    http.Response response = await http.get(url);
    var listUnit = <PmisChartModel>[];
    List a = json.decode(response.body) as List;
    listUnit = a.map((e) => PmisChartModel.fromJson(e)).toList();
    rxListPmisChartbYear.value = listUnit;
  }
  Future<void> getPmisPieChartByUnit() async {
    final url = Uri.parse(apiPmisPieChartByUnit);
    print('loading');
    http.Response response = await http.get(url);
    //print(response.body);
    var listUnit = <PmisChartModel>[];
    List a = json.decode(response.body) as List;
    listUnit = a.map((e) => PmisChartModel.fromJson(e)).toList();
    rxListPmisChartbUnit.value = listUnit;
  }

}
