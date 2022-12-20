import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../../const/utils.dart';
import '../../../model/group_workbook/group_workbook_model.dart';


class GroupWorkBookViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};

  ScrollController controller = ScrollController();
  RxList<GroupWorkBookItems> rxListGroupWorkBookItems= <GroupWorkBookItems>[].obs;
  GroupWorkBookModel groupWorkBookModel = GroupWorkBookModel();
  Rx<bool> rxSwitchState = false.obs;
  Rx<bool> isValueNull = true.obs;

  Rx<bool> showErrorTextNameWB = false.obs;
  Rx<bool> showErrorTextDesNameWB = false.obs;


  clearTextField(){
    showErrorTextNameWB.value = false;
    showErrorTextDesNameWB.value = false;
    isValueNull.value = true;
  }

  @override
  void onInit() {

    postGroupWorkBookAll();

    super.onInit();
  }

  void switchChangeState(bool value) {
    rxSwitchState.value = value;
  }

  void changeValidateValue(bool isNull,Rx<bool> rxIsValidate)
  {
    rxIsValidate.value = isNull;
  }

  Future<void> postGroupWorkBookAll() async {
    final url = Uri.parse(apiSearchGroupWorkBook);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    groupWorkBookModel = GroupWorkBookModel.fromJson(jsonDecode(response.body));
    rxListGroupWorkBookItems.value = groupWorkBookModel.items!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        groupWorkBookModel =  GroupWorkBookModel.fromJson(jsonDecode(response.body));
        rxListGroupWorkBookItems.addAll(groupWorkBookModel.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> deleteGroupWorkBookItem(String id) async {
    final url = Uri.parse("$apiActionSearchGroupWorkBook/$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
    print(id);
    
    if (response.statusCode == 200) {
      postGroupWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Xóa nhóm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> addGroupWorkBookAll(
      String name,
      String description,
      ) async {
    final url = Uri.parse(apiActionSearchGroupWorkBook);
    print('loading');
    String json = """{
      "groupWorkName": "$name",
      "description": "$description"
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
    
    if (response.statusCode == 200) {
      postGroupWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Thêm nhóm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
      clearTextField();
      Get.snackbar(
        "Thông báo",
        "Thêm nhóm công việc thất bại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> updateGroupWorkBook(
      String id,
      String name,
      String dess) async {
    final url = Uri.parse(apiActionSearchGroupWorkBook);
    print('loading');
    String json = """{
      "id": "$id",
      "groupWorkName": "$name",
      "description": "$dess"
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
    
    if (response.statusCode == 200) {
      postGroupWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Cập nhật nhóm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<GroupWorkBookItems> getGroupWorkbookModelDetail(String id) async {
    final url = Uri.parse("$apiGroupWorkBookDetail$id");
    http.Response response = await http.get(url,headers: headers);
    return GroupWorkBookItems.fromJson(jsonDecode(response.body));
  }


}
