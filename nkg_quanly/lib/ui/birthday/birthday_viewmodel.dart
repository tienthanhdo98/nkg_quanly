import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/birthday_model/birthday_model.dart';

class BirthDayViewModel extends GetxController {
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<BirthDayListItems> rxBirthDayListItems = <BirthDayListItems>[].obs;
  Rx<BirthDayModel> rxBirthDayModel = BirthDayModel().obs;

  @override
  void onInit() {
    postBirthDayByDay(formatDateToString(dateNow));
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postBirthDayByDay(strSelectedDay);
  }

  //birthday
  Future<void> postBirthDayByDay(String day) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
  }

  Future<void> postBirthDayByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
  }

  Future<void> postBirthDayByMonth() async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
  }
}
