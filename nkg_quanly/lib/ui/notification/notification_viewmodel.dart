import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../const/utils.dart';
import '../../model/notification_model/notification_model.dart';

class NotificationViewModel extends GetxController {



  Rx<NotificationModel> rxNotificationModel = NotificationModel().obs;
  RxList<NotificationItems> rxListNotificationItems = <NotificationItems>[].obs;
  ScrollController controller = ScrollController();

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }


  Future<void> getNotificationList() async {
    final url = Uri.parse(apiPostNotificationList);
    String json =
        '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
  
    NotificationModel notificationModel = NotificationModel.fromJson(jsonDecode(response.body));
    rxListNotificationItems.value = notificationModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        notificationModel = NotificationModel.fromJson(jsonDecode(response.body));
        rxListNotificationItems.addAll(notificationModel.items!);
      }
    });
  }



}
