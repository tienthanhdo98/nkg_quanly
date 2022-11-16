import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../const/utils.dart';
import '../../model/notification_model/notification_model.dart';
import 'database_helper.dart';
import 'notification_model_db.dart';

class NotificationViewModel extends GetxController {
  Rx<NotificationModel> rxNotificationModel = NotificationModel().obs;
  RxList<NotificationItems> rxListNotificationItems = <NotificationItems>[].obs;
  RxList<NotificationModelDB> rxListNotificationItemsDB =
      <NotificationModelDB>[].obs;
  ScrollController controller = ScrollController();

  Rx<bool> isShowNotificationAction = false.obs;

  Rx<bool> isNewNotification = false.obs;
  final dbHelper = DatabaseHelper.db;

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }

  Future<void> getNotificationList() async {
    final url = Uri.parse(apiPostGetNotificationList);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    NotificationModel notificationModel =
        NotificationModel.fromJson(jsonDecode(response.body));
    rxListNotificationItems.value = notificationModel.items!;
    var count = 0;
    if( notificationModel.items!.isNotEmpty) {
      for (var element in rxListNotificationItems) {
        if(element.status == false)
          {
            count++;
          }

      }
      if(count > 0)
        {
          isNewNotification.value = true;
        }
      else
        {
          isNewNotification.value = false;
        }

    }
    else
      {
        isNewNotification.value = false;
      }
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
        notificationModel =
            NotificationModel.fromJson(jsonDecode(response.body));
        rxListNotificationItems.addAll(notificationModel.items!);
      }
    });
  }

  Future<void> deleteNotification(String id) async {
    final url = Uri.parse(apiPostDeleteNotification);
    print(id);
    String json = """
        [
           $id
        ]
        """;
    http.Response response = await http.post(url, headers: headers, body: json);


    if (response.statusCode == 200) {
      getNotificationList();
      Get.snackbar(
        "Thông báo",
        "Xóa thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> changeNotificationStatus(String id) async {
    final url = Uri.parse("$apiGetChangeNotificationStatus$id");
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      getNotificationList();
    }
  }
  Future<void> changeAllNotificationStatus() async {
    final url = Uri.parse(apiGetChangeAllNotificationStatus);
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      getNotificationList();
    }
  }
}
