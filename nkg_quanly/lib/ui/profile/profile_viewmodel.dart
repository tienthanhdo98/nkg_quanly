import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../model/document_unprocess/document_filter.dart';
import '../../model/proflie_model/profile_model.dart';

class ProfileViewModel extends GetxController {
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<int> selectedChartButton = 0.obs;
  ScrollController controller = ScrollController();
  ProfileModel profileModel = ProfileModel();

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
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

  Map<String, String> headers = {"Content-type": "application/json"};

  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<ProfileItems> rxProfileItems = <ProfileItems>[].obs;
  Rx<ProfileStatisticModel> rxProfileStatistic = ProfileStatisticModel().obs;
  Rx<ProfileStatisticModel> rxProfileStatisticTotal = ProfileStatisticModel().obs;

  @override
  void onInit() {
    getFilterUnitEditor();
    getFilterTypeSubmission();
    getFilterSubmissProblem();
    getFilterForChart("${apiGetProfileFilter}0");

    postProfileStatistic();


    super.onInit();
  }

  //filter
  final RxMap<int, String> mapUnitEditorFilter = <int, String>{}.obs;
  final RxMap<int, String> mapSubmissProblem = <int, String>{}.obs;
  final RxMap<int, String> mapTypeSubmission = <int, String>{}.obs;
  final RxMap<int, String> mapState = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListUnitEditor = <String>[].obs;
  RxList<String> rxListTypeSubmission = <String>[].obs;
  RxList<String> rxListSubmissProblem = <String>[].obs;
  RxList<String> rxListState = <String>[].obs;

  Future<void> getFilterUnitEditor() async {
    print('loading');
    http.Response response = await http
        .get(Uri.parse("http://123.31.31.237:6002/api/profiles/unit-editor"));

    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListUnitEditor.value = listUnit;
  }

  Future<void> getFilterSubmissProblem() async {
    print('loading');
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/profiles/submission-problem"));

    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListSubmissProblem.value = listUnit;
  }

  Future<void> getFilterTypeSubmission() async {
    print('loading');
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/profiles/type-submission"));

    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListTypeSubmission.value = listUnit;
  }

  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }

  //by ui
  //filter
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

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

  //end filter

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postProfileByDay(strSelectedDay);
  }

  // profile ho so trinh data
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }

  Future<void> postProfileStatistic() async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    profileModel = ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatisticTotal.value = profileModel.statistic!;
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> postProfileByDay(String day) async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    ProfileModel res = ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileItems.value = res.items!;
    profileModel = ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatisticTotal.value = profileModel.statistic!;
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> postProfileByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    profileModel= ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
        print("loadmore w at $page");
      }
    });


  }

  Future<void> postProfileByMonth() async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    profileModel= ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> postProfileByFilter(String state, String unitEditor,
      String submissionProblem, String typeSubmission) async {
    final url = Uri.parse(apiGetProfile);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"typeSubmission":"$typeSubmission","submissionProblem":"$submissionProblem","unitEditor":"$unitEditor","state":"$state"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    profileModel= ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"typeSubmission":"$typeSubmission","submissionProblem":"$submissionProblem","unitEditor":"$unitEditor","state":"$state"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
        print("loadmore w at $page");
      }
    });
  }
}
