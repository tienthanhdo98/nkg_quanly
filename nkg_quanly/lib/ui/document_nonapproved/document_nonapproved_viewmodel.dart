import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../main.dart';
import '../../model/document/document_model.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../viewmodel/home_viewmodel.dart';

class DocumentNonApproveViewModel extends GetxController {
  //
  Rx<int> selectedChartButton = 0.obs;

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

  Rx<int> selectedBottomButton = 0.obs;

  RxList<DocumentInListItems> rxItems = <DocumentInListItems>[].obs;
  Rx<DocumentInStatistic> rxDocumentInStatistic = DocumentInStatistic().obs;
  Rx<DocumentInStatistic> rxDocumentInStatisticTotal = DocumentInStatistic().obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  ScrollController controller = ScrollController();
  DocumentInModel documentInModel = DocumentInModel();
  Map<String,String> headers = {};
  @override
  void onInit() {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    getFilterForChart("${apiGetDocumentApproveFilterChart}0");
    getDocumentDefault();
    getDocumentStatisticTotal();
    super.onInit();
  }

  Future<void> getFilterForChart(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    
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

  Future<void> getDocumentStatisticTotal() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    
    DocumentInModel res = DocumentInModel.fromJson(jsonDecode(response.body));
    rxDocumentInStatisticTotal.value = res.statistic!;
  }

  Future<DocumentInListItems> getDocumentDetail(int id) async {
    final url = Uri.parse("${apiGetDocumentDetail}id=$id");
    print('loading detail');
    http.Response response = await http.get(url,headers: headers);
    
    return DocumentInListItems.fromJson(jsonDecode(response.body));
  }

  Future<void> getDocumentDefault() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
      }
    });
  }

  Future<void> getDocumentByDay(String day) async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore m at $page");
      }
    });
  }

  Future<void> getDocumentByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocument);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore m at $page");
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
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';
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
    String json =
        '{"pageIndex":1,"pageSize":10,"level":"$level","status": "$status","departmentPublic":"$department"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    documentInModel = DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = documentInModel.items!;
    rxDocumentInStatistic.value = documentInModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"level":"$level","status": "$status","departmentPublic":"$department"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        documentInModel =
            DocumentInModel.fromJson(jsonDecode(response.body));
        rxItems.addAll(documentInModel.items!);
        print("loadmore m at $page");
      }
    });
  }
}
