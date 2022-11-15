import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../model/event_model/event_model.dart';




class ChartViewModel extends GetxController {
  Rx<EventModel> rxEventDes = EventModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLatestEvent(String token) async {
    http.Response response = await http.get(Uri.parse(apiGetLatestEvent),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    EventModel eventModel = EventModel.fromJson(jsonDecode(response.body));
    rxEventDes.value = eventModel;
  }



}
