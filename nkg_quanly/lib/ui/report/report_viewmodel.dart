import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/report_model/report_model.dart';

class ReportViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<ReportListItems> rxReportListItems = <ReportListItems>[].obs;
  Rx<ReportStatistic>   rxReportStatistic= ReportStatistic().obs;
  Rx<ReportStatistic>   rxReportStatisticTotal = ReportStatistic().obs;
  ScrollController controller = ScrollController();
  ReportModel  reportMode =  ReportModel();
  @override
  void onInit() {
    getFilterForChart(apiGetReportChart0);
    getReportStatisticTotal();
    getReportDeparmentFilter();
    super.onInit();
  }

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postReportByDay(strSelectedDay);
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  Future<void> getReportStatisticTotal() async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    reportMode = ReportModel.fromJson(jsonDecode(response.body));
    rxReportStatisticTotal.value = reportMode.statistic!;
    rxReportListItems.value = reportMode.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        response = await http.post(url, headers: headers, body: json);
        print(response.body);
        reportMode =
            ReportModel.fromJson(jsonDecode(response.body));
        rxReportListItems.addAll(reportMode.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> postReportByDay(String day) async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    reportMode = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = reportMode.items!;
    rxReportStatistic.value = reportMode.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        response = await http.post(url, headers: headers, body: json);
        print(response.body);
        reportMode =
            ReportModel.fromJson(jsonDecode(response.body));
        rxReportListItems.addAll(reportMode.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> postReportByWeek(String datefrom, String dateTo) async {
    if(datefrom != "" || dateTo != "" ) {
      final url = Uri.parse(apiGetReportModel);
      String json =
          '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
      print('loading');
      print('$datefrom');
      print('$dateTo');
      http.Response response = await http.post(
          url, headers: headers, body: json);
      reportMode = ReportModel.fromJson(jsonDecode(response.body));
      rxReportListItems.value = reportMode.items!;
      rxReportStatistic.value = reportMode.statistic!;
      //loadmore
      var page = 1;
      controller.dispose();
      controller = ScrollController();
      controller.addListener(() async {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          print("loadmore day");
          page++;
          String json =
              '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
          response = await http.post(url, headers: headers, body: json);
          print(response.body);
          reportMode =
              ReportModel.fromJson(jsonDecode(response.body));
          rxReportListItems.addAll(reportMode.items!);
          print("loadmore day at $page");
        }
      });
    }
  }

  Future<void> postReportByMonth() async {
    final url = Uri.parse(apiGetReportModel);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    reportMode = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = reportMode.items!;
    rxReportStatistic.value = reportMode.statistic!;
    print(reportMode.statistic!.tong!);
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dateFrom":"${formatDateToString(dateNow)}"}';
        response = await http.post(url, headers: headers, body: jsonGetByMonth);
        print(response.body);
        reportMode =
            ReportModel.fromJson(jsonDecode(response.body));
        rxReportListItems.addAll(reportMode.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> postReportByFilter(String status, String level) async {
    final url = Uri.parse(apiGetReportModel);
    String json =
        '{"pageIndex":1,"pageSize":10,"level":"$level","status": "$status"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    reportMode = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = reportMode.items!;
    rxReportStatistic.value = reportMode.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"level":"$level","status": "$status"}';
        response = await http.post(url, headers: headers, body: json);
        print(response.body);
        reportMode =
            ReportModel.fromJson(jsonDecode(response.body));
        rxReportListItems.addAll(reportMode.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<ReportListItems> getReportDetail(int id) async {
    final url = Uri.parse("${apiGetReportDetail}id=$id");
    http.Response response = await http.get(url);
    return ReportListItems.fromJson(jsonDecode(response.body));
  }
  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;
  Rx<String> rxSelectedDeparment = "".obs;
  Rx<String> rxSelectedStatus= "".obs;


  void changeValueSelectedDepartment(String value)
  {
    rxSelectedDeparment.value = value;
  }
  void changeValueSelectedStatus(String value)
  {
    rxSelectedStatus.value = value;
  }

  Future<void> getReportDeparmentFilter() async {
    final url = Uri.parse(apiGetDepartmentFilter);
    http.Response response = await http.get(url);
    List<String> listDeparmentFilter = [];
    List listRes = json.decode(response.body) as List;
    listDeparmentFilter= listRes.map((e) => e as String).toList();
    rxListDepartmentFilter.value = listDeparmentFilter;
    print(listDeparmentFilter);
  }

  Future<void> postReportInMenuByFilter(String state, String departmentHandle,String endDate) async {
    final url = Uri.parse(apiGetReportModel);
    String json = "";
    if(endDate != "") {
      json =
          '{"pageIndex":1,"pageSize":10,"state":"$state","departmentHandle": "$departmentHandle","endDate":"$endDate"}';
    }
    else
      {
        json =
        '{"pageIndex":1,"pageSize":10,"state":"$state","departmentHandle": "$departmentHandle"}';
      }
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    reportMode = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = reportMode.items!;
    rxReportStatistic.value = reportMode.statistic!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        if(endDate != "") {
          json =
          '{"pageIndex":$page,"pageSize":10,"state":"$state","departmentHandle": "$departmentHandle","endDate":"$endDate"}';
        }
        else
        {
          json =
          '{"pageIndex":$page,"pageSize":10,"state":"$state","departmentHandle": "$departmentHandle"}';
        }
        response = await http.post(url, headers: headers, body: json);
        print(response.body);
        reportMode =
            ReportModel.fromJson(jsonDecode(response.body));
        rxReportListItems.addAll(reportMode.items!);
        print("loadmore day at $page");
      }
    });
  }
}
