import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/api.dart';

import '../../const/utils.dart';
import '../../model/workbook/group_workbook_model.dart';
import '../../model/workbook/workbook_model.dart';

class WorkBookViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};

  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<WorkBookListItems> rxWorkBookListItems = <WorkBookListItems>[].obs;
  RxList<GroupWorkbookListItems> rxGroupWorkBookListItems =
      <GroupWorkbookListItems>[].obs;
  Rx<bool> rxSwitchState = false.obs;
  ScrollController controller = ScrollController();

  @override
  void onInit() {
    postGroupWorkBook();
    postWorkBookAll();

    super.onInit();
  }

  void switchChangeState(bool value) {
    rxSwitchState.value = value;
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  //calendar work

  Future<void> postWorkBookAll() async {
    final url = Uri.parse(apiPostWorkBookSearch);
    print('loading BookAll');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response;
    try {
      response = await http.post(
          url, headers: headers, body: json);
    }
    catch(_)
    {
      print("reload");
      response = await http.post(
          url, headers: headers, body: json);
    }
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = WorkbookModel.fromJson(jsonDecode(response.body));
        rxWorkBookListItems.addAll(res.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> deleteWorkBookItem(String id) async {
    final url = Uri.parse("${apiWorkBookDelete}$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
    print(id);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Xóa công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> addWorkBookAll(
      String workName,
      String groupWorkName,
      String description,
      String worker,
      String status,
      bool important,
      String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "worker": "$worker",
      "workBy": "$worker",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Thêm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
      Get.snackbar(
        "Thông báo",
        "Thêm công việc thất bại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> updateWorkBook(
      String id,
      String workName,
      String groupWorkName,
      String description,
      String worker,
      String status,
      bool important,
      String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "id": "$id",
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "worker": "$worker",
      "workBy": "$worker",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Cập nhật công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<WorkBookListItems> getWorkbookModelDetail(String id) async {
    final url = Uri.parse("${apiWorkBookDetail}$id");
    http.Response response = await http.get(url);
    return WorkBookListItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapImportantFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  Future<void> postWorkBookByFilter(String important, String status) async {
    final url = Uri.parse(apiPostWorkBookSearch);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":30, "important": "$important","status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
  }

  Future<void> postGroupWorkBook() async {
    final url = Uri.parse(apiGroupBookList);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response;
    response = await http.post(url, headers: headers, body: json);

    print(response.body);
    GroupWorkbookModel res =
        GroupWorkbookModel.fromJson(jsonDecode(response.body));
    rxGroupWorkBookListItems.value = res.items!;
    // if(res.totalRecords! > 10 )
    //   {
    //     String json = '{"pageIndex":2,"pageSize":${res.totalRecords}';
    //     http.Response response = await http.post(url, headers: headers, body: json);
    //     res =
    //     GroupWorkbookModel.fromJson(jsonDecode(response.body));
    //     rxGroupWorkBookListItems.addAll(res.items!);
    //   }
  }
}
