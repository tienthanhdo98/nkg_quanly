import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/document/document_model.dart';
import '../../model/document_unprocess/document_filter.dart';

class DocumentUnprocessViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<DocumentInListItems> rxItems = <DocumentInListItems>[].obs;
  Rx<DocumentInStatistic> rxDocumentInStatistic = DocumentInStatistic().obs;
  Rx<DocumentInStatistic> rxDocumentInStatisticTotal = DocumentInStatistic().obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  ScrollController controller = ScrollController();
  DocumentInModel documentInModel = DocumentInModel();
  @override
  void onInit() {
    getFilterForChart("${apiGetDocumentUnprocessFilterChart}0");

    getFilterDepartment();
    getDocumentStatistic();
    getDocumentByDay(formatDateToString(dateNow));
    super.onInit();
  }

  Future<void> getFilterForChart(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
    rxDocumentFilterModel.refresh();
    print('updatedat');
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    getDocumentByDay(strSelectedDay);
  }

  //document unprocess
  Future<DocumentInListItems> getDocumentDetail(int id) async {
    final url = Uri.parse("${apiGetDocumentDetail}id=$id");
    print('loading detail');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentInListItems.fromJson(jsonDecode(response.body));
  }

  Future<void> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentInModel res = DocumentInModel.fromJson(jsonDecode(response.body));
    rxDocumentInStatisticTotal.value = res.statistic!;
  }

  Future<void> getDocumentByDay(String day) async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    if (controller.hasClients) {
      controller.jumpTo(0);
    }
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> getDocumentByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocument);
    print(datefrom);
    print(dateTo);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
     documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> getDocumentByMonth() async {
    final url = Uri.parse(apiGetDocument);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dateFrom":"${formatDateToString(dateNow)}"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore m at $page");
      }
    });
  }

  Future<void> getDocumentByFilter(
      String status, String level, String department) async {
    final url = Uri.parse(apiGetDocument);
    print('loading');
    String json = "";
    json =
        '{"pageIndex":1,"pageSize":10,"level":"$level","status": "$status","departmentPublic":"$department"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.jumpTo(0);
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        json =
            '{"pageIndex":$page,"pageSize":10,"level":"$level","status": "$status","departmentPublic":"$department"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore m at $page");
      }
    });
  }

  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
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
    http.Response response = await http.get(Uri.parse(
        "http://123.31.31.237:6002/api/documentin/department-public"));
    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListDepartmentFilter.value = listUnit;
    print(rxListDepartmentFilter.value);
  }
}
