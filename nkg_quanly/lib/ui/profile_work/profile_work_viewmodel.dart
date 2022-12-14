import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/profile_work/profile_work_model.dart';

class ProfileWorkViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};

  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<ProfileWorkListItems> rxProfileWorkList = <ProfileWorkListItems>[].obs;
  Rx<ProfileWorkStatistic> rxProfileWorkStatistic = ProfileWorkStatistic().obs;

  @override
  void onInit() {
    postProfileWorkStatistic();
    postProfileWorkByDay(formatDateToString(dateNow));
    super.onInit();
  }

  //filter
  final RxMap<int, String> mapStatus = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;

  void checkboxStatus(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapStatus.addAll(map);
    } else {
      mapStatus.remove(key);
    }
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

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postProfileWorkByDay(strSelectedDay);
  }

  // profile work data
  Future<void> postProfileWorkStatistic() async {
    final url = Uri.parse(apiPostProfile);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkStatistic.value = res.statistic!;
  }

  Future<void> postProfileWorkByDay(String day) async {
    final url = Uri.parse(apiPostProfile);
    print('loading');
    //,"dayInMonth": "$day"
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkList.value = res.items!;
    rxProfileWorkStatistic.value = res.statistic!;
  }

  Future<void> postProfileWorkByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostProfile);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkList.value = res.items!;
    rxProfileWorkStatistic.value = res.statistic!;
  }

  Future<void> postProfileWorkByMonth() async {
    final url = Uri.parse(apiPostProfile);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkList.value = res.items!; rxProfileWorkStatistic.value = res.statistic!;

  }

  Future<void> postProfileWorkByFilter(String status) async {
    final url = Uri.parse(apiPostProfile);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkList.value = res.items!;
    rxProfileWorkStatistic.value = res.statistic!;
  }
}
