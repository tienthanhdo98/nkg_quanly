import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../const/utils.dart';
import '../../main.dart';
import '../../model/workbook/group_workbook_model.dart';
import '../../model/workbook/workbook_model.dart';
import '../../model/workbook/worker_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class WorkBookViewModel extends GetxController {
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<WorkBookListItems> rxWorkBookListItems = <WorkBookListItems>[].obs;
  RxList<GroupWorkbookListItems> rxGroupWorkBookListItems =
      <GroupWorkbookListItems>[].obs;
  RxList<WorkerModel> rxListWorkerModel = <WorkerModel>[].obs;
  Rx<bool> rxSwitchState = false.obs;
  ScrollController controller = ScrollController();
  Rx<bool> isValueNull = true.obs;

  Rx<bool> showErrorTextWorkName = false.obs;
  Rx<bool> showErrorTextDescription = false.obs;
  Map<String, String> headers = {};

  clearTextField() {
    showErrorTextWorkName.value = false;
    showErrorTextDescription.value = false;
    isValueNull.value = true;
  }

  @override
  void onInit() {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    postGroupWorkBook();
    postWorkBookAll();
    getListWorkerWorkBook();
    super.onInit();
  }

  void switchChangeState(bool value) {
    rxSwitchState.value = value;
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void changeValidateValue(bool isNull, Rx<bool> rxIsValidate) {
    rxIsValidate.value = isNull;
  }

  //calendar work

  Future<void> postWorkBookAll() async {
    final url = Uri.parse(apiPostWorkBookSearch);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response;
    try {
      response = await http.post(url, headers: headers, body: json);
    } catch (_) {
      print("reload");
      response = await http.post(url, headers: headers, body: json);
    }
    if(response.statusCode == 200) {
      WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
      rxWorkBookListItems.value = res.items!;
      //loadmore
      var page = 1;
      controller.dispose();
      controller = ScrollController();
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
    else
      {
        print("postWorkBookAll ${response.statusCode}");
      }
  }

  Future<void> deleteWorkBookItem(String id) async {
    final url = Uri.parse("${apiWorkBookDelete}$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
    print(id);

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
      String description,
      String workerId,
      String status,
      bool important,
      String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "workName": "$workName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "workBy": "$workerId",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);

    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Thêm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
      clearTextField();
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
      String description,
      String workerId,
      String status,
      bool important,
      String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "id": "$id",
      "workName": "$workName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "workBy": "$workerId",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);

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
    final url = Uri.parse("$apiWorkBookDetail$id");
    http.Response response = await http.get(url, headers: headers);
    return WorkBookListItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapImportantFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  Rx<String> rxImportantSelected = "".obs;
  Rx<String> rxStatusSelected = "".obs;

  Future<void> postWorkBookByFilter(String important, String status) async {
    final url = Uri.parse(apiPostWorkBookSearch);
    var strImportant = "";
    print(important);
    if (important == "Quan trọng;") {
      strImportant = "true";
    } else if (important == "Không quan trọng;") {
      strImportant = "false";
    } else {
      strImportant = "";
    }
    print(strImportant);
    String json =
        '{"pageIndex":1,"pageSize":30, "important": "$strImportant","status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
    // controller.dispose();
    controller = ScrollController();
  }

  Future<void> postGroupWorkBook() async {
    final url = Uri.parse(apiGroupBookList);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response;
    response = await http.post(url, headers: headers, body: json);

    GroupWorkbookModel res =
        GroupWorkbookModel.fromJson(jsonDecode(response.body));
    rxGroupWorkBookListItems.value = res.items!;
    for (int i = 2; i < res.pageCount!; i++) {
      String json = '{"pageIndex":$i,"pageSize":10}';
      http.Response response =
          await http.post(url, headers: headers, body: json);
      res = GroupWorkbookModel.fromJson(jsonDecode(response.body));
      rxGroupWorkBookListItems.addAll(res.items!);
    }
  }

  Future<void> getListWorkerWorkBook() async {
    http.Response response =
        await http.get(Uri.parse(apiGetListWorkerWorkBook), headers: headers);
    print(response.body);
    var listWorkerModel = <WorkerModel>[];
    List listRes = json.decode(response.body) as List;
    listWorkerModel = listRes.map((e) => WorkerModel.fromJson(e)).toList();
    rxListWorkerModel.value = listWorkerModel;
    print("length: ${rxListWorkerModel.length}");
  }
}
