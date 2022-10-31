import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../model/analysis_report/analysis_report_filter_model.dart';
import '../../model/analysis_report/preschool_chart_model.dart';

class AnalysisReportViewModel extends GetxController {
  Rx<int> rxIndexItemRegion = 0.obs;
  RxList<AnalysisReportFilterModel> rxListAllProvince =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListProvinceByRegion =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListRegion =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListSemester =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListSchoolYear =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListSchoolLevel =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListPoint =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListClass =
      <AnalysisReportFilterModel>[].obs;
  RxList<AnalysisReportFilterModel> rxListSubject =
      <AnalysisReportFilterModel>[].obs;
  final RxMap<int, String> mapSemesterFilter = <int, String>{}.obs;
  final RxMap<int, String> mapProvinceFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSchoolYearFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSchoolLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapPointFilter = <int, String>{}.obs;
  final RxMap<int, String> mapClassFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSubjectFilter = <int, String>{}.obs;
  final RxMap<int, String> mapClasstifiFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  Rx<String> rxSelectedSemester = "".obs;
  Rx<String> rxSelectedProvince = "".obs;
  Rx<String> rxSelectedRegion = "".obs;
  Rx<String> rxSelectedRegionID = "".obs;
  Rx<String> rxSelectedSchoolYear = "".obs;
  Rx<String> rxSelectedSchoolLevel = "".obs;
  Rx<String> rxSelectedSchoolYearID = "".obs;
  Rx<String> rxSelectedSchoolLevelID = "".obs;
  Rx<String> rxSelectedPoint = "".obs;
  Rx<String> rxSelectedPointId = "".obs;
  Rx<String> rxSelectedSubject = "".obs;
  Rx<String> rxSelectedClasstifi = "".obs;
  Rx<String> rxSelectedClass = "".obs;
  Rx<String> rxSelectedClassId = "".obs;
  Rx<bool> rxIsLoadingData = true.obs;
  Rx<int> rxTypeScreen = 0.obs;

  Rx<String> rxfilterType = "".obs;
  ScrollController? controller;
  @override
  void onInit() {
    controller = ScrollController();
    super.onInit();
  }

  void scrollToTop()
  {
    if(controller!.hasClients) {
      controller!.jumpTo(
       0
      );
      print("scroll");
    }
  }
  void changeValuefilterType(String value) {
    rxfilterType.value = value;
  }

  void changeValueDataId(String value, Rx<String> rxString) {
    rxString.value = value;
  }

  void getDataEducationScreen() async {
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    await getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    changeValueDataId(rxListRegion.first.id!, rxSelectedRegionID);
    getEducationChart(rxListRegion.first.id!, "");
  }

  void getDataPreSchoolScreen() async {
    getDataFilter();
    getChartPreSchool("1", "", "1", "", "");
    // rxSelectedRegion.value = rxListRegion.first.name!;
    // changeValueDataId(rxListRegion.first.id!,rxSelectedRegionID);
    // getEducationChart(rxListRegion.first.id!, "");
  }

  void getDataCoSoVatChat() async {
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
  }

  void getListProvinceByRegion() {
    rxListProvinceByRegion.clear();
    mapAllFilter.clear();
    rxSelectedProvince.value = "";
    mapProvinceFilter.clear();
    print("getListProvinceByRegion ${rxSelectedRegionID.value}");
    for (var element in rxListAllProvince) {
      if (element.areaId == rxSelectedRegionID.value) {
        rxListProvinceByRegion.add(element);
      }
    }
  }

  void clearSelectedFilter() {
    // mapSemesterFilter.clear();
    // mapProvinceFilter.clear();
    // mapSchoolYearFilter.clear();
    // mapSchoolLevelFilter.clear();
    // mapPointFilter.clear();
    // mapClassFilter.clear();
    // mapSubjectFilter.clear();
    // mapClasstifiFilter.clear();
    // mapAllFilter.clear();
    // rxSelectedSemester.value = "";
    // rxSelectedProvince.value = "";
    // rxSelectedRegion.value = "";
    // rxSelectedRegionID.value = "";
    // rxSelectedSchoolYear.value = "";
    // rxSelectedSchoolLevel.value = "";
    // rxSelectedSchoolYearID.value = "";
    // rxSelectedSchoolLevelID.value = "";
    // rxSelectedPoint.value = "";
    // rxSelectedPointId.value = "";
    // rxSelectedSubject.value = "";
    // rxSelectedClasstifi.value = "";
    // rxSelectedClass.value = "";
    // rxSelectedClassId.value = "";
  }

  void changeLoadingState(bool value) {
    rxIsLoadingData.value = value;
  }

  void changeValueSelectedFilter(Rx<String> rxSelected, String value) {
    rxSelected.value = value;
  }

  void changeValueIndexRegion(int value) {
    rxIndexItemRegion.value = value;
  }

  Future<void> getListFilter(
      String urlApi, RxList<AnalysisReportFilterModel> rxlist) async {
    final url = Uri.parse(urlApi);
    http.Response response = await http.get(url);
    print(response.body);
    var listRes = <AnalysisReportFilterModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisReportFilterModel.fromJson(e)).toList();
    rxlist.value = listRes;
  }

  Future<void> getListFilterWithParam(String id, String urlApi,
      RxList<AnalysisReportFilterModel> rxlist) async {
    final url = Uri.parse("$urlApi?typeSchool=$id");
    http.Response response = await http.get(url);
    print(response.body);
    var listRes = <AnalysisReportFilterModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisReportFilterModel.fromJson(e)).toList();
    rxlist.value = listRes;
  }

  void searchProvinceInFilterList(String keySearch) async {
    if (keySearch != "") {
      var list = rxListAllProvince
          .toList()
          .where((element) =>
              element.name!.toLowerCase().contains(keySearch.toLowerCase()))
          .toList();
      rxListProvinceByRegion.value = list;
    } else {
      getListProvinceByRegion();
    }
  }

  void searchRegionInFilterList(String keySearch) async {
    if (keySearch != "") {
      await getListFilter(getAnalysisReportRegion, rxListRegion);
      var list = rxListRegion
          .toList()
          .where((element) =>
              element.name!.toLowerCase().contains(keySearch.toLowerCase()))
          .toList();
      rxListRegion.value = list;
    } else {
      await getListFilter(getAnalysisReportRegion, rxListRegion);
    }
  }

  void searchSchoolYearInFilterList(String keySearch) async {
    if (keySearch != "") {
      await getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
      var list = rxListSchoolYear
          .toList()
          .where((element) =>
              element.name!.toLowerCase().contains(keySearch.toLowerCase()))
          .toList();
      rxListSchoolYear.value = list;
    } else {
      await getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    }
  }

  void searchSchoolLevelInFilterList(String keySearch) async {
    if (keySearch != "") {
      await getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
      var list = rxListSchoolLevel
          .toList()
          .where((element) =>
              element.name!.toLowerCase().contains(keySearch.toLowerCase()))
          .toList();
      rxListSchoolLevel.value = list;
    } else {
      await getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
    }
  }

  void getDataFilter() async {
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    getListProvinceByRegion();

    getListFilter(getAnalysisReportSemester, rxListSemester);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getPoint, rxListPoint);
    getListFilterWithParam("1;2;3;4", getClass, rxListClass);
    getListFilterWithParam("1;2;3;4", getSubject, rxListSubject);
    // getListFilterWithParam
  }

  //chart
  RxList<PreSchoolChartModel> rxListPreSchoolChartModel =
      <PreSchoolChartModel>[].obs;

  RxList<PreSchoolChartModel> rxListEducationChart =
      <PreSchoolChartModel>[].obs;

  Future<void> getChartPreSchool(String type, String semester, String areaId,
      String provinceId, String schoolYearId) async {
    final url = Uri.parse(postPreSchoolChart);
    print("type : $type");
    var jsonBody = """
       {
      "type": "$type",
      "semester" : "",
      "areaId": "1",
      "provinceId": "",
      "schoolYearId": ""
     }
        """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <PreSchoolChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => PreSchoolChartModel.fromJson(e)).toList();
    listRes.removeAt(listRes.length - 1);
    rxListPreSchoolChartModel.value = listRes;
    changeLoadingState(false);
  }

  Future<void> getEducationChart(String areaId, String schoolYearId) async {
    final url = Uri.parse(postEducationChart);
    print(areaId);
    print(schoolYearId);
    var jsonBody = """
       {
        "areaId": "$areaId",
        "schoolYearId": "$schoolYearId"
       }
        """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print("edu ${response.body}");
    var listRes = <PreSchoolChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => PreSchoolChartModel.fromJson(e)).toList();
    rxListEducationChart.value = listRes;
    changeLoadingState(false);
  }
}
