import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/MenuByUserModel.dart';
import '../../model/event_model/event_model.dart';
import '../../model/widget_item_model.dart';


class ChartViewModel extends GetxController {
  Rx<EventModel> rxEventDes = EventModel().obs;
  RxList<WidgetItemModel> rxListWidgetItem = <WidgetItemModel>[].obs;

  LoginViewModel loginViewModel = Get.find();
  Rx<bool> isShowCase = false.obs;
  Rx<double> positionWidget = 0.0.obs;
  RxList listBeforeClose = [].obs;


  @override
  void onInit() {

    super.onInit();
  }

  setPositionWidget(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size; // or _widgetKey.currentContext?.size
    print('Size: ${size.width}, ${size.height}');

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    print('Offset: ${offset.dx}, ${offset.dy}');
    print('Position: ${(offset.dx + size.width + 15) / 2}, ${(offset.dy + size.height) / 2}');
    positionWidget.value = (offset.dx + size.width + 15) / 2;
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
    http.Response response = await http.get(Uri.parse(apiGetLatestEvent),headers: headers);
    EventModel eventModel = EventModel.fromJson(jsonDecode(response.body));
    rxEventDes.value = eventModel;
    await getListWidgetKgs(token);
  }
  getListWidgetKgs(String token) async {
    http.Response response = await http.get(Uri.parse(apiGetListWidget),headers: headers);
    var listSearch = <WidgetItemModel>[];
    List a = json.decode(response.body) ;
    listSearch = a.map((e) => WidgetItemModel.fromJson(e)).toList();



    rxListWidgetItem.value = listSearch;
    listBeforeClose.clear();
    for (var element in listSearch) {
      if(!getCheckedWidgetItem(element.id! + element.code!)) {
        listBeforeClose.add(getCheckedWidgetItem(element.id! + element.code!));
        continue;
      } else {
        setCheckedWidgetItem(element.id! + element.code!, true);
        listBeforeClose.add(getCheckedWidgetItem(element.id! + element.code!));
      }
    }
  }

}
