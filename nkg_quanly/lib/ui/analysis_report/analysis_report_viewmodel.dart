import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/analysis_report/report_continuingEducation/report_continuing_ducation_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_disability_education/report_disability_education_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_highschool/report_high_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_preschool/report_pre_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_primaryschool/report_primary_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_secondaryschool/report_secondary_school_screen.dart';
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
  RxList<AnalysisReportFilterModel> rxListClassification =
      <AnalysisReportFilterModel>[].obs;
  final RxMap<int, String> mapSemesterFilter = <int, String>{}.obs;
  final RxMap<int, String> mapProvinceFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSchoolYearFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSchoolLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapPointFilter = <int, String>{}.obs;
  final RxMap<int, String> mapClassFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSubjectFilter = <int, String>{}.obs;
  final RxMap<int, String> mapClassificationFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  Rx<String> rxSelectedSemester = "".obs;
  Rx<String> rxSelectedSemesterId = "".obs;
  Rx<String> rxSelectedProvince = "".obs;
  Rx<String> rxSelectedProvinceId = "".obs;
  Rx<String> rxSelectedRegion = "".obs;
  Rx<String> rxSelectedRegionID = "".obs;
  Rx<String> rxSelectedSchoolYear = "".obs;
  Rx<String> rxSelectedSchoolYearID = "".obs;
  Rx<String> rxSelectedSchoolLevel = "".obs;
  Rx<String> rxSelectedSchoolLevelID = "".obs;
  Rx<String> rxSelectedPoint = "".obs;
  Rx<String> rxSelectedPointId = "".obs;
  Rx<String> rxSelectedSubject = "".obs;
  Rx<String> rxSelectedSubjectID = "".obs;
  Rx<String> rxSelectedClassification = "".obs;
  Rx<String> rxSelectedClassificationID = "".obs;
  Rx<String> rxSelectedClass = "".obs;
  Rx<String> rxSelectedClassId = "".obs;

  Rx<int> rxTypeScreen = 0.obs;

  Rx<String> rxfilterType = "".obs;
  ScrollController? controller;

  @override
  void onInit() {
    controller = ScrollController();
    super.onInit();
  }

  void scrollToTop() {
    if (controller!.hasClients) {
      controller!.jumpTo(0);
      print("scroll");
    }
  }

  void clearSelectedFilter() {
    mapSemesterFilter.clear();
    mapProvinceFilter.clear();
    mapSchoolYearFilter.clear();
    mapSchoolLevelFilter.clear();
    mapPointFilter.clear();
    mapClassFilter.clear();
    mapSubjectFilter.clear();
    mapClassificationFilter.clear();
    mapAllFilter.clear();
    rxSelectedSemester.value = "";
    rxSelectedProvince.value = "";
    rxSelectedSchoolYear.value = "";
    rxSelectedSchoolLevel.value = "";
    rxSelectedSchoolYearID.value = "";
    rxSelectedSchoolLevelID.value = "";
    rxSelectedPoint.value = "";
    rxSelectedPointId.value = "";
    rxSelectedSubject.value = "";
    rxSelectedClassification.value = "";
    rxSelectedClass.value = "";
    rxSelectedClassId.value = "";
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
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

  void getListProvinceByRegion() {
    rxListProvinceByRegion.clear();
    mapAllFilter.clear();
    rxSelectedProvince.value = "";
    rxSelectedProvinceId.value = "";
    mapProvinceFilter.clear();
    print("getListProvinceByRegion ${rxSelectedRegionID.value}");
    for (var element in rxListAllProvince) {
      if (element.areaId == rxSelectedRegionID.value) {
        rxListProvinceByRegion.add(element);
      }
    }
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
  RxList<AnalysisChartModel> rxListChartAnalysis = <AnalysisChartModel>[].obs;


  //giáo dục khyết tật
  Rx<bool> isLoadingData = true.obs;
  Rx<AnalysisChartModel> rxInfoReport = AnalysisChartModel().obs;

  void changeStateLoadingData(bool value) {
    isLoadingData.value = value;
  }

  void getDataDisabilityEducation() async {
    getDisabilityEducation("1", "", "", "", "", listReportGDKT[0]);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    getDisabilityEducation("1", "", "", "", "", listReportGDKT[0]);
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
  }

  Future<void> getDisabilityEducation(
      String type,
      String semester,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postChartDsabilityEducation);
    print("type : $type");
    print("semester : $semester");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
      "type": "$type",
      "semester": "$semester",
      "areaId": "$rxSelectedRegionID",
      "provinceId": "$provinceId",
      "schoolYearId": "$rxSelectedSchoolYearID"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    if (typeScreen == listReportGDKT[0]) {
      listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
      rxListChartAnalysis.value = listRes;
      changeStateLoadingData(false);
    } else if (typeScreen == listReportGDKT[1]) {
      listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
      rxListChartAnalysis.value = listRes;
      rxInfoReport.value = listRes[listRes.length - 1];
      listRes.removeAt(listRes.length - 1);
      listRes.removeWhere((element) => element.chartName == "Revoke");
      changeStateLoadingData(false);
    } else if (typeScreen == listReportGDKT[2]) {
      listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
      rxListChartAnalysis.value = listRes;
      rxInfoReport.value = listRes[listRes.length - 1];
      listRes.removeAt(listRes.length - 1);
      listRes.removeWhere((element) => element.chartName == "Revoke");
      changeStateLoadingData(false);
    }
  }

  void getDataInfrastructure() async {
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartInfrastructure("", rxSelectedRegionID.value, "", "");
  }

  Future<void> getListChartInfrastructure(
    String typeSchool,
    String areaId,
    String provinceId,
    String schoolYearId,
  ) async {
    final url = Uri.parse(postChartInfrastructure);
    print("typeSchool : $typeSchool");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    var jsonBody = """
       {
      "typeSchool": "$typeSchool",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    listRes.removeAt(0);
    rxListChartAnalysis.value = listRes;
    changeStateLoadingData(false);
  }

  //
  void getDataBeneficiary() async {
    changeStateLoadingData(true);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartBeneficiary("", rxSelectedRegionID.value, "", "");
  }

  Future<void> getListChartBeneficiary(
    String semesterId,
    String areaId,
    String provinceId,
    String schoolYearId,
  ) async {
    final url = Uri.parse(postChartBeneficiary);
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    var jsonBody = """
       {
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    rxListChartAnalysis.value = listRes;
    changeStateLoadingData(false);
  }

  //
  void getDataQualityEducation() async {
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartBeneficiary("", rxSelectedRegionID.value, "", "");
    // getListFilter(getClass, rxListClass);
    // getListFilter(getSubject, rxListSubject);
  }

  Future<void> getListQualityEducation(
    String semesterId,
    String areaId,
    String provinceId,
    String schoolYearId,
  ) async {
    final url = Uri.parse(postChartBeneficiary);
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    var jsonBody = """
       {
      "typeSchool": "$semesterId",
      "type": "$areaId",
      "semester": "$provinceId",
      "areaId": "$schoolYearId",
      "provinceId": "$schoolYearId",
      "schoolYearId": "$schoolYearId",
      "classId": "$schoolYearId",
      "subjectId": "$schoolYearId",
      "pointId": "$schoolYearId",
      "classificationId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    rxListChartAnalysis.value = listRes;
    changeStateLoadingData(false);
  }

  //giao duc thong xuyen
  void getDataContinuingEducation() async {
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSchoolLevel, rxListSchoolLevel);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListContinuingEducation(
        "1", "", rxSelectedRegionID.value, "", "", listReportGDTX[0]);
  }

  Future<void> getListContinuingEducation(
      String type,
      String semesterId,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postContinuingEducation);
    print("type : $type");
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
        "type": "$type",
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    if (typeScreen == listReportGDTX[0]) {
      rxListChartAnalysis.value = listRes
          .where((element) =>
              element.chartName == "CoCauCoSoGDTXTheoLoaiTruong" ||
              element.chartName == "CoCauCoSoGDTXTheoDonViThanhLap" ||
              element.chartName == "BieuDoSoSanhCoSoGiaoDucThuongXuyen")
          .toList();
      ;
      changeStateLoadingData(false);
    } else if (typeScreen == listReportGDTX[1]) {
      listRes.removeWhere((element) =>
          element.chartName == "CoCauCoSoGDTXTheoLoaiTruong" ||
          element.chartName == "CoCauCoSoGDTXTheoDonViThanhLap" ||
          element.chartName == "BieuDoSoSanhCoSoGiaoDucThuongXuyen");
      rxInfoReport.value = listRes.last;
      listRes.removeLast();
      rxListChartAnalysis.value = listRes;
      changeStateLoadingData(false);
    } else if (typeScreen == listReportGDTX[2]) {
      var a = listRes
          .where((element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi")
          .toList();
      rxInfoReport.value = a.first;
      listRes.removeWhere(
          (element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi");
      rxListChartAnalysis.value = listRes;
      changeStateLoadingData(false);
    }
  }
  //mam non
  void getDataPreSchool() async {
    changeStateLoadingData(true);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartPreSchool(
        "1", "", rxSelectedRegionID.value, "", "", listReportPreSchoolType[0]);
  }

  Future<void> getListChartPreSchool(
      String type,
      String semesterId,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postPreSchool);
    print("type : $type");
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
       "type": "$type",
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
    await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    if (typeScreen == listReportPreSchoolType[0]) {
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportPreSchoolType[1]) {
      rxInfoReport.value = listRes
          .where((element) =>
      element.chartName == "HocSinhMoiTuyenLuuBanDanTocThieuSo")
          .first;
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportPreSchoolType[2]) {
      rxInfoReport.value = listRes
          .where((element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi")
          .first;
      rxListChartAnalysis.value = listRes;
    }
    changeStateLoadingData(false);
  }

  //tieu hoc
  void getDataPrimarySchool() async {
    changeStateLoadingData(true);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartPrimarySchool(
        "1", "", rxSelectedRegionID.value, "", "", listReportPriSchoolType[0]);
  }

  Future<void> getListChartPrimarySchool(
      String type,
      String semesterId,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postPrimarySchool);
    print("type : $type");
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
       "type": "$type",
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    if (typeScreen == listReportPriSchoolType[0]) {
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportPriSchoolType[1]) {
      rxInfoReport.value = listRes
          .where((element) =>
              element.chartName == "HocSinhMoiTuyenLuuBanDanTocThieuSo")
          .first;
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportPriSchoolType[2]) {
      rxInfoReport.value = listRes
          .where((element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi")
          .first;
      rxListChartAnalysis.value = listRes;
    }
    changeStateLoadingData(false);
  }

  // trung hoc co so
  void getDataSecondarySchool() async {
    changeStateLoadingData(true);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartSecondarySchool("1", "", rxSelectedRegionID.value, "", "",
        listReportSecondSchoolType[0]);
  }

  Future<void> getListChartSecondarySchool(
      String type,
      String semesterId,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postSecondarySchool);
    print("type : $type");
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
       "type": "$type",
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    if (typeScreen == listReportSecondSchoolType[0]) {
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportSecondSchoolType[1]) {
      rxInfoReport.value = listRes
          .where((element) =>
              element.chartName == "HocSinhMoiTuyenLuuBanDanTocThieuSo")
          .first;
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportSecondSchoolType[2]) {
      rxInfoReport.value = listRes
          .where((element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi")
          .first;
      rxListChartAnalysis.value = listRes;
    }
    changeStateLoadingData(false);
  }

  // trung hoc pho thong
  void getDataHighSchool() async {
    changeStateLoadingData(true);
    getListFilter(getAnalysisReportSchoolYear, rxListSchoolYear);
    getListFilter(getAnalysisReportSemester, rxListSemester);
    await getListFilter(getAnalysisReportRegion, rxListRegion);
    rxSelectedRegion.value = rxListRegion.first.name!;
    rxSelectedRegionID.value = rxListRegion.first.id!;
    await getListFilter(getAnalysisReportProvince, rxListAllProvince);
    getListProvinceByRegion();
    getListChartHighSchool(
        "1", "", rxSelectedRegionID.value, "", "", listReportHighSchoolType[0]);
  }

  Future<void> getListChartHighSchool(
      String type,
      String semesterId,
      String areaId,
      String provinceId,
      String schoolYearId,
      String typeScreen) async {
    final url = Uri.parse(postHighSchool);
    print("type : $type");
    print("semester : $semesterId");
    print("areaId : $areaId");
    print("provinceId : $provinceId");
    print("schoolYearId : $schoolYearId");
    print("typeScreen : $typeScreen");
    var jsonBody = """
       {
       "type": "$type",
      "semester": "$semesterId",
      "areaId": "$areaId",
      "provinceId": "$provinceId",
      "schoolYearId": "$schoolYearId"
     }
       """;
    http.Response response =
        await http.post(url, headers: headers, body: jsonBody);
    print(response.body);
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    if (typeScreen == listReportHighSchoolType[0]) {
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportHighSchoolType[1]) {
      rxInfoReport.value = listRes
          .where((element) =>
              element.chartName == "HocSinhMoiTuyenLuuBanDanTocThieuSo")
          .first;
      rxListChartAnalysis.value = listRes;
    } else if (typeScreen == listReportHighSchoolType[2]) {
      rxInfoReport.value = listRes
          .where((element) => element.chartName == "SoGiaoVienNghiHuuTuyenMoi")
          .first;
      rxListChartAnalysis.value = listRes;
    }
    changeStateLoadingData(false);
  }

  //pho cao giao duc
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
    var listRes = <AnalysisChartModel>[];
    List a = json.decode(response.body) as List;
    listRes = a.map((e) => AnalysisChartModel.fromJson(e)).toList();
    rxListChartAnalysis.value = listRes;
    changeStateLoadingData(false);
  }
}
