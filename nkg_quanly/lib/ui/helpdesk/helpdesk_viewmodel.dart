import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/helpdesk_model/helpdesk_model.dart';

import '../../model/document_unprocess/document_filter.dart';
import '../../model/helpdesk_model/helpdesk_filter_model.dart';

class HelpdeskViewModel extends GetxController {
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<int> selectedChartButton = 0.obs;
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  RxList<HelpDeskListItems> rxHelpdeskListItems = <HelpDeskListItems>[].obs;
  RxList<HelpDeskStatistic> rxHelpdeskListStatistic = <HelpDeskStatistic>[].obs;
  Rx<HelpdeskModel> rxHelpdeskModel = HelpdeskModel().obs;
  ScrollController controller = ScrollController();
  HelpdeskModel helpdeskModel = HelpdeskModel();

  //filter
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

  @override
  void onInit() {
    postHelpdeskListAndStatistic();
    getChartRecently();
    getListFilterStatus();
    super.onInit();
  }

  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }

  //filter
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  void checkboxStatus(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapStatusFilter.addAll(map);
    } else {
      mapStatusFilter.remove(key);
    }
  }

  RxList<HelpdeskFilterModel> rxHelpdeskFilterList =
      <HelpdeskFilterModel>[].obs;

  void getListFilterStatus() async {
    final url = Uri.parse(apiGetHelpdeskFilter);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('BranchLis ${response.body}');
    var list = <HelpdeskFilterModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => HelpdeskFilterModel.fromJson(e)).toList();
    rxHelpdeskFilterList.value = list;
  }

  //end filter

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  Future<void> postHelpdeskListAndStatistic() async {
    final url = Uri.parse(apiPostHelpDesk);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListStatistic.value = helpdeskModel.statistic!;
    rxHelpdeskListItems.value = helpdeskModel.items!;
    rxHelpdeskModel.value = helpdeskModel;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore Helpdesk");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(helpdeskModel.items!);
        print("loadmore Helpdesk at $page");
      }
    });
  }

  Future<void> posHelpdeskListByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    print(datefrom);
    print(dateTo);
    String json =
        '{"pageIndex":1,"pageSize":10,"createdDateFrom":"$datefrom","createdDateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    HelpdeskModel res = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListItems.value = res.items!;
  }

  Future<void> postHelpdeskListByFilter(String status) async {
    final url = Uri.parse(apiPostHelpDesk);
    print('loading');
    String json = "";
    if (status != "") {
      json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    } else {
      json = '{"pageIndex":1,"pageSize":10}';
    }
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListItems.value = helpdeskModel.items!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore Helpdesk");
        page++;
        if (status != "") {
          json = '{"pageIndex":$page,"pageSize":10,"status":"$status"}';
        } else {
          json = '{"pageIndex":$page,"pageSize":10}';
        }
        http.Response response =
            await http.post(url, headers: headers, body: json);
        helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(helpdeskModel.items!);
        print("loadmore Helpdesk at $page");
      }
    });
  }

  RxList<HelpDeskStatistic> rxListRecen = <HelpDeskStatistic>[].obs;

  Future<void> getChartRecently() async {
    final url = Uri.parse(apiGetChartRecentlyHelpDesk);
    http.Response response = await http.get(url);
    print(response.body);
    var listStatistic = <HelpDeskStatistic>[];
    List a = json.decode(response.body) as List;
    listStatistic = a.map((e) => HelpDeskStatistic.fromJson(e)).toList();
    rxListRecen.value = listStatistic;
  }
}
