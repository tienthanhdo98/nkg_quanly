import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../model/document_unprocess/document_filter.dart';
import '../../model/proflie_model/profile_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class ProfileViewModel extends GetxController {
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<int> selectedChartButton = 0.obs;
  ScrollController controller = ScrollController();
  ProfileModel profileModel = ProfileModel();

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }


  Future<void> getFilterForChart(String url) async {

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



  Rx<int> selectedBottomButton = 4.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<ProfileItems> rxProfileItems = <ProfileItems>[].obs;
  Rx<ProfileStatisticModel> rxProfileStatistic = ProfileStatisticModel().obs;
  Rx<ProfileStatisticModel> rxProfileStatisticTotal = ProfileStatisticModel().obs;

  @override
  void onInit() {
    getFilterForChart("${apiGetProfileFilter}0");
    getFilterUnitEditor();
    getFilterTypeSubmission();
    getFilterSubmissProblem();
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

  Rx<String> rxUnitEditorSelected = "".obs;
  Rx<String> rxSubmissProblemSelected = "".obs;
  Rx<String> rxTypeSubmissSelected = "".obs;
  Rx<String> rxStateSelected = "".obs;

  void clearSelectedFilter()
  {
    mapUnitEditorFilter.clear();
    mapSubmissProblem.clear();
    mapTypeSubmission.clear();
    mapState.clear();
    mapAllFilter.clear();
    rxUnitEditorSelected.value = "";
    rxSubmissProblemSelected.value = "";
    rxTypeSubmissSelected.value = "";
    rxStateSelected.value = "";
  }

  Future<void> getFilterUnitEditor() async {
    http.Response response = await http
        .get(Uri.parse("http://123.31.31.237:6002/api/profiles/unit-editor"),headers: headers);

    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListUnitEditor.value = listUnit;
  }

  Future<void> getFilterSubmissProblem() async {
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/profiles/submission-problem"),headers: headers);

    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListSubmissProblem.value = listUnit;
  }

  Future<void> getFilterTypeSubmission() async {
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/profiles/type-submission"),headers: headers);

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


  void switchBottomButton(int button) {
    selectedBottomButton.value = button;
  }

 

  // profile ho so trinh data
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {

    http.Response response = await http.get(Uri.parse(url),headers: headers);
    
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }

  Future<void> postProfileStatistic() async {
    final url = Uri.parse(apiGetProfile);

    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    profileModel = ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileStatisticTotal.value = profileModel.statistic!;
    rxProfileStatistic.value = profileModel.statistic!;
    rxProfileItems.value = profileModel.items!;
    switchBottomButton(4);
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
  
  Future<void> getProfileByDiffDate(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetProfile);

    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
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

  
  Future<void> postProfileByFilter(String state, String unitEditor,
      String submissionProblem, String typeSubmission) async {
    final url = Uri.parse(apiGetProfile);

    String json =
        '{"pageIndex":1,"pageSize":10,"typeSubmission":"$typeSubmission","submissionProblem":"$submissionProblem","unitEditor":"$unitEditor","state":"$state"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
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
