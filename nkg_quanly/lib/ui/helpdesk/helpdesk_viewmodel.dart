import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/helpdesk_model/helpdesk_model.dart';

import '../../const/const.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/helpdesk_model/helpdesk_filter_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class HelpdeskViewModel extends GetxController {
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 1.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  RxList<HelpDeskListItems> rxHelpdeskListItems = <HelpDeskListItems>[].obs;
  RxList<HelpDeskStatistic> rxHelpdeskListStatistic = <HelpDeskStatistic>[].obs;
  Rx<HelpdeskModel> rxHelpdeskModel = HelpdeskModel().obs;
  ScrollController controller = ScrollController();
  HelpdeskModel helpdeskModel = HelpdeskModel();
  Rx<bool> rxIsLoadingScreen = true.obs;

  Rx<String> rxStatusSelected = "".obs;

  void changeLoadingState(bool value)
  {
    rxIsLoadingScreen.value = value;
  }
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

  //filter
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

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
    String json = '{"currentPage":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);

    helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListStatistic.value = helpdeskModel.statistic!;
    rxHelpdeskListItems.value = helpdeskModel.items!;
    rxHelpdeskModel.value = helpdeskModel;
    changeLoadingState(false);
    //loadmore
    controller.dispose();
    controller = ScrollController();
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore Helpdesk");
        page++;
        String json = '{"currentPage":$page,"pageSize":10}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(helpdeskModel.items!);
        print("loadmore Helpdesk all at $page");
      }
    });
  }

  Future<void> getHelpdeskListByDiffDate(String dateFrom, String dateTo) async {
    final url = Uri.parse(apiPostHelpDesk);
    print('loading');
    print(dateFrom);
    print(dateTo);
    String json =
        '{"currentPage":1,"pageSize":10,"createdDateFrom":"$dateFrom","createdDateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListItems.value = helpdeskModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore Helpdesk");
        page++;
        String json =
            '{"currentPage":2,"pageSize":10,"createdDateFrom":"$dateFrom","createdDateTo":"$dateTo"}';
        response =
        await http.post(url, headers: headers, body: json);
        helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(helpdeskModel.items!);
        print("loadmore Helpdesk week at $page");
      }
    });
  }


  Future<void> postHelpdeskListByFilter(String status) async {
    final url = Uri.parse(apiPostHelpDesk);
    print('loading');
    String json = "";
    print(status);
    if (status != "") {
      json = '{"currentPage":1,"pageSize":10,"status":"$status"}';
    } else {
      json = '{"currentPage":1,"pageSize":10}';
    }
    http.Response response = await http.post(url, headers: headers, body: json);

    helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListItems.value = helpdeskModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore Helpdesk");
        page++;
        if (status != "") {
          json = '{"currentPage":$page,"pageSize":10,"status":"$status"}';
        } else {
          json = '{"currentPage":$page,"pageSize":10}';
        }
        http.Response response =
            await http.post(url, headers: headers, body: json);
        helpdeskModel = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(helpdeskModel.items!);
        print("loadmore Helpdesk filter at $page");
      }
    });
  }

  RxList<HelpDeskStatistic> rxListRecen = <HelpDeskStatistic>[].obs;

  Future<void> getChartRecently() async {
    final url = Uri.parse(apiGetChartRecentlyHelpDesk);
    http.Response response = await http.get(url,headers: headers);

    var listStatistic = <HelpDeskStatistic>[];
    List a = json.decode(response.body) as List;
    listStatistic = a.map((e) => HelpDeskStatistic.fromJson(e)).toList();
    rxListRecen.value = listStatistic;
  }
}
