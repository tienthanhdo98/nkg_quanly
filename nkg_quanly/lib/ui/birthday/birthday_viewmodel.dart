import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  RxList<BirthDayListItems> rxBirthDayListItemsInCurDay = <BirthDayListItems>[].obs;
  Rx<BirthDayModel> rxBirthDayModel = BirthDayModel().obs;
  ScrollController controller = ScrollController();

  @override
  void onInit() {
    //postBirthDayDefault();
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
  Future<void> getBirthDayInHomeScreen(String day) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItemsInCurDay.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        rxBirthDayListItemsInCurDay.addAll(res.items!);
      }
    });
  }
  Future<void> postBirthDayDefault() async {
    final url = Uri.parse(apiPostBirthDay);
    print('loadingBirthDayDefault ');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        rxBirthDayListItems.addAll(res.items!);
      }
    });
  }

  Future<void> postBirthDayByDay(String day) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        rxBirthDayListItems.addAll(res.items!);
      }
    });
  }

  Future<void> postBirthDayByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        rxBirthDayListItems.addAll(res.items!);
      }
    });
  }

  Future<void> postBirthDayByMonth() async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        rxBirthDayListItems.addAll(res.items!);
      }
    });
  }
}
