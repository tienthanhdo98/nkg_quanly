import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/profile_procedure_model/ProfileProcStatisticModel.dart';
import '../../model/profile_procedure_model/filter_profile_proc_model.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';



class ProfilesProcedureViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<String> rxDate = "".obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<ProfileProcedureListItems> rxProfileProcedureListItems =
      <ProfileProcedureListItems>[].obs;
  @override
  void onInit() {
    getFilterForChart(apiGetProfileProcedureChart0);
    initCurrentDate();
    getAgenciesList();
    getBranchList();
    getStatusList();
    getProcedureList();
    getGroupProcedureList();
    postProfileProcByDay(rxDate.value);
    super.onInit();
  }

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }
  void swtichBottomButton (int button) {
    selectedBottomButton.value = button;
  }

  void initCurrentDate() {
    rxDate.value = DateFormat('yyyy-MM-dd').format(dateNow);
  }

  void onSelectDay(DateTime selectedDay) {
    rxSelectedDay.value = selectedDay;
    var a = DateFormat('yyyy-MM-dd').format(selectedDay);
    print("a $a");
    rxDate.value = formatDateToString(selectedDay);
    print("data ${rxDate.value}");
    postProfileProcByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel = DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }


//report
  Map<String, String> headers = {"Content-type": "application/json"};
 Future<ProfileProcedureStatisticModel> geProfileProcStatistic() async {
   final url = Uri.parse(apiGetProfileProcedureStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return ProfileProcedureStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<void> postProfileProcByDay(String day) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
  }

  Future<void> postProfileProcByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
  }

  Future<void> postProfileProcByMonth() async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: jsonGetByMonth);
    print('rxProfileProcedureListItems ${response.body}');
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
    print('rxProfileProcedureListItems ${rxProfileProcedureListItems.length}');
  }


  Future<ProfileProcedureListItems> getProfileProcDetail(String id) async {
    final url = Uri.parse("${apiPostProfileProcedureDetail}id=$id");
    http.Response response = await http.get(url);
    return ProfileProcedureListItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapAgenciesFilter = <int, String>{}.obs;
  final RxMap<int, String> mapBranchFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter= <int, String>{}.obs;
  final RxMap<int, String> mapProcedureFilter= <int, String>{}.obs;
  final RxMap<int, String> mapGroupProcedureFilter= <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<FilterProfileProcModel> rxListAgenciesList = <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListBranch= <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListStatus= <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListProcedure = <FilterProfileProcModel>[].obs;
  RxList<FilterProfileProcModel> rxListGroupProcedure = <FilterProfileProcModel>[].obs;
  RxList<String> rxListLevelFilter  = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;
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
    http.Response response = await http.get(url,headers: headers);
    print('rxProfileProcedureListItems ${response.body}');
    var listAgencies = <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    listAgencies = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListAgenciesList.value = listAgencies;
  }
  Future<void> getBranchList() async {
    final url = Uri.parse(apiGetBranch);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    print('BranchLis ${response.body}');
    var list= <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListBranch.value = list;
  }
  Future<void> getStatusList() async {
    final url = Uri.parse(apiStatus);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    print('BranchLis ${response.body}');
    var list= <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListStatus.value = list;
  }
  Future<void> getProcedureList() async {
    final url = Uri.parse(apiProcedure);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    print('BranchLis ${response.body}');
    var list= <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListProcedure.value = list;
  }
  Future<void> getGroupProcedureList() async {
    final url = Uri.parse(apiGroupProcedure);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    print('BranchLis ${response.body}');
    var list= <FilterProfileProcModel>[];
    List a = json.decode(response.body) as List;
    list = a.map((e) => FilterProfileProcModel.fromJson(e)).toList();
    rxListGroupProcedure.value = list;
  }

  Future<void> postProfileProcByFilter(String agenciesId, String branch,String status,String procudereId,String groupProcudereId) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"coQuanId":"$agenciesId","linhVuc":"$branch","trangThaiHoSo":"$status","nttId":"$groupProcudereId","ttId":"$procudereId"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print('rxProfileProcedureListItems ${response.body}');
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
    print('rxProfileProcedureListItems ${rxProfileProcedureListItems.length}');
  }
//filter



}
