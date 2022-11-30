import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/event_model/event_model.dart';
import '../../model/widget_item_model.dart';


class ChartViewModel extends GetxController {
  Rx<EventModel> rxEventDes = EventModel().obs;
  RxList<WidgetItemModel> rxListWidgetItem = <WidgetItemModel>[].obs;
  LoginViewModel loginViewModel = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  setCheckedWidgetItem(String key, bool value) async {
    await loginViewModel.initPrefs();
    loginViewModel.pref!.setBool(key, value);
  }
  bool getCheckedWidgetItem(String key) => loginViewModel.pref?.getBool(key) ?? true;

  clearCheckedWidgetItem() async {
    await loginViewModel.initPrefs();
    final keys = loginViewModel.pref!.getKeys();
    for(String key in keys) {
      if(key == "tokenIOC" || key == "tokenSSO"){
        continue;
      }
      setCheckedWidgetItem(key, false);
    }
  }

  restoreCheckedWidget() async {//true
    await loginViewModel.initPrefs();
    final keys = loginViewModel.pref!.getKeys();
    for(String key in keys) {
      if(key == "tokenIOC" || key == "tokenSSO"){
        continue;
      }
      setCheckedWidgetItem(key, true);
    }
  }

  Future<void> getLatestEvent(String token) async {
    http.Response response = await http.get(Uri.parse(apiGetLatestEvent),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    EventModel eventModel = EventModel.fromJson(jsonDecode(response.body));
    rxEventDes.value = eventModel;
    await getListWidget(token);
  }
  getListWidget(String token) async {
    http.Response response = await http.get(Uri.parse(apiGetListWidget),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var listSearch = <WidgetItemModel>[];
    List a = json.decode(response.body) as List;
    listSearch = a.map((e) => WidgetItemModel.fromJson(e)).toList();
    rxListWidgetItem.value = listSearch;
    for (var element in listSearch) {
      if(!getCheckedWidgetItem(element.id! + element.code!)) {
        continue;
      }
      setCheckedWidgetItem(element.id! + element.code!, true);
    }
  }
}
