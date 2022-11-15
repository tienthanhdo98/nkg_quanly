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
  ScrollController controller = ScrollController();

  final dbHelper = DatabaseHelper.db;

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

        dbHelper.database;
        for (var element in notificationModel.items!) {
          NotificationModelDB dbModel = NotificationModelDB(
            id: element.id,
            workbookId: element.workbookId,
            workName: element.workName,
            status: element.status,
            action: element.action,
            isDeleted: element.isDeleted,
            createdDate: element.createdDate,
            lastModifiedDate: element.lastModifiedDate,
            createdBy: element.createdBy,
            lastModifiedBy: element.lastModifiedBy,
            isClick: false,
          );
          dbHelper.insertDB(dbModel);
        }
      }
    });
  }



}
