import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/profile_procedure_model/filter_profile_proc_model.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class ProfilesProcedureViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 4.obs;

  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<ProfileProcedureListItems> rxProfileProcedureListItems =
      <ProfileProcedureListItems>[].obs;
  Rx<ProfileProcedureStatistic> rxProfileProcedureStatistic =
      ProfileProcedureStatistic().obs;
  Rx<ProfileProcedureStatistic> rxProfileProcedureStatisticTotal =
      ProfileProcedureStatistic().obs;
  ScrollController controller = ScrollController();
  ProfileProcedureModel profileProcedureModel = ProfileProcedureModel();


  @override
  void onInit() {
    getFilterForChart(apiGetProfileProcedureChart0);
    postProfileDefault();
    getAgenciesList();
    getBranchList();
    getStatusList();
    getProcedureList();
    getGroupProcedureList();
    super.onInit();
  }

  void switchChartButton(int button) {
    selectedChartButton.value = button;
  }

  void switchBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    DocumentFilterModel documentFilterModel =
    DocumentFilterModel.fromJson(jsonDecode(response.body));

    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  Future<void> postProfileDefault() async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json = '{"currentPage":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    profileProcedureModel =
        ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = profileProcedureModel.items!;
    rxProfileProcedureStatistic.value = profileProcedureModel.statistic!;
    rxProfileProcedureStatisticTotal.value = profileProcedureModel.statistic!;
    selectedBottomButton(4);
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"currentPage":$page,"pageSize":10}';
        response = await http.post(url, headers: headers, body: json);
        profileProcedureModel =
            ProfileProcedureModel.fromJson(jsonDecode(response.body));
        rxProfileProcedureListItems.addAll(profileProcedureModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> getProfileProcListByDiffDate(String datefrom,
      String dateTo) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    print(datefrom);
    print(dateTo);
    String json =
        '{"currentPage":1,"pageSize":10,"tuNgay":"$datefrom","denNgay":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);

    profileProcedureModel =
        ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = profileProcedureModel.items!;
    rxProfileProcedureStatistic.value = profileProcedureModel.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json =
            '{"currentPage":$page,"pageSize":10,"tuNgay":"$datefrom","denNgay":"$dateTo"}';
        response = await http.post(url, headers: headers, body: json);

        profileProcedureModel =
            ProfileProcedureModel.fromJson(jsonDecode(response.body));
        rxProfileProcedureListItems.addAll(profileProcedureModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<ProfileProcedureListItems> getProfileProcDetail(String id) async {
    final url = Uri.parse("$apiPostProfileProcedureDetail$id");
    http.Response response = await http.get(url,headers: headers);
    return ProfileProcedureListItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapAgenciesFilter = <int, String>{}.obs;
  final RxMap<int, String> mapBranchFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapProcedureFilter = <int, String>{}.obs;
  final RxMap<int, String> mapGroupProcedureFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  Rx<String> rxSelectedAgencies = "".obs;
  Rx<String> rxSelectedBranch = "".obs;
  Rx<String> rxSelectedStatus = "".obs;
  Rx<String> rxSelectedProcedure = "".obs;
  Rx<String> rxSelectedGroupProcedure = "".obs;
  RxList<FilterProfileProcModel> rxListAgenciesList =
      <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListBranch = <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListStatus = <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListProcedure =
      <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListGroupProcedure =
      <FilterProfileProcModel>[].obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  void clearSelectedFilter() {
    mapAgenciesFilter.clear();
    mapBranchFilter.clear();
    mapStatusFilter.clear();
    mapProcedureFilter.clear();
    mapGroupProcedureFilter.clear();
    mapAllFilter.clear();
    rxSelectedAgencies.value = "";
    rxSelectedBranch.value = "";
    rxSelectedStatus.value = "";
    rxSelectedProcedure.value = "";
    rxSelectedGroupProcedure.value = "";
  }


  void changeValueSelectedFilter(Rx<String> rxSelected, String value) {
    rxSelected.value = value;
  }

  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
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

  void checkboxAgencies(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapAgenciesFilter.addAll(map);
    } else {
      mapAgenciesFilter.remove(key);
    }
  }

  void checkboxBranch(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapBranchFilter.addAll(map);
    } else {
      mapBranchFilter.remove(key);
    }
  }

  void checkboxProcedure(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapProcedureFilter.addAll(map);
    } else {
      mapProcedureFilter.remove(key);
    }
  }

  void checkboxGroupProcedure(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapGroupProcedureFilter.addAll(map);
    } else {
      mapGroupProcedureFilter.remove(key);
    }
  }

  Future<void> getAgenciesList() async {
    final url = Uri.parse(apiGetAgencies);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('rxProfileProcedureListItems ${response.body}');
    var listAgencies = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    listAgencies = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListAgenciesList.value = listAgencies;
  }

  Future<void> getBranchList() async {
    final url = Uri.parse(apiGetBranch);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('BranchLis ${response.body}');
    var list = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListBranch.value = list;
  }

  Future<void> getStatusList() async {
    final url = Uri.parse(apiStatus);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('BranchLis ${response.body}');
    var list = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListStatus.value = list;
  }

  Future<void> getProcedureList() async {
    final url = Uri.parse(apiProcedure);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('BranchLis ${response.body}');
    var list = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListProcedure.value = list;
  }

  Future<void> getGroupProcedureList() async {
    final url = Uri.parse(apiGroupProcedure);
    print('loading');
    http.Response response = await http.get(url, headers: headers);
    print('BranchLis ${response.body}');
    var list = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListGroupProcedure.value = list;
  }

  Future<void> postProfileProcByFilter(String agenciesId, String branch,
      String status, String procudereId, String groupProcudereId) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    print('loading');
    String json =
        '{"currentPage":1,"pageSize":10,"coQuanId":"$agenciesId","linhVuc":"$branch","trangThaiHoSo":"$status","nttId":"$groupProcudereId","ttId":"$procudereId"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print('rxProfileProcedureListItems ${response.body}');
    profileProcedureModel =
        ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = profileProcedureModel.items!;
    rxProfileProcedureStatistic.value = profileProcedureModel.statistic!;
    print('rxProfileProcedureListItems ${rxProfileProcedureListItems.length}');
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json =
            '{"currentPage":$page,"pageSize":10,"coQuanId":"$agenciesId","linhVuc":"$branch","trangThaiHoSo":"$status","nttId":"$groupProcudereId","ttId":"$procudereId"}';
        response = await http.post(url, headers: headers, body: json);

        profileProcedureModel =
            ProfileProcedureModel.fromJson(jsonDecode(response.body));
        rxProfileProcedureListItems.addAll(profileProcedureModel.items!);
        print("loadmore f at $page");
      }
    });
  }

//filter
}
