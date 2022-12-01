import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';

import '../../../model/contact_model/contact_model.dart';
import '../../../model/contact_model/department_model.dart';


class ContactIndividualViewModel extends GetxController {
  Rx<int> selectedButton = 0.obs;
  ScrollController controller = ScrollController();
  ContactModel contactModel = ContactModel();
  RxList<ContactListItems> rxContactListItems = <ContactListItems>[].obs;
  RxList<DepartmentModel> rxDepartmentList = <DepartmentModel>[].obs;
  RxList<String> rxListOrganFilter = <String>[].obs;
  final RxMap<int, String> rxMapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;

  Rx<bool> isValueNull = true.obs;

  Rx<bool> showErrorTextEmployeeName = false.obs;
  Rx<bool> showErrorTextPosition = false.obs;
  Rx<bool> showErrorTextPhoneNumber = false.obs;
  Rx<String> rxPhoneNumber = "".obs;
  Rx<bool> showErrorTextEmail = false.obs;
  Rx<String> rxEmail = "".obs;
  Rx<bool> showErrorTextAddress = false.obs;

  clearTextField(){
    showErrorTextEmployeeName.value = false;
    showErrorTextPosition.value = false;
    rxEmail.value = "";
    showErrorTextPhoneNumber.value = false;
    rxPhoneNumber.value = "";
    showErrorTextEmail.value = false;
    showErrorTextAddress.value = false;
    isValueNull.value = true;
  }

  @override
  void onInit() {
    getDepartmentList();
    getContactList();
    super.onInit();
  }
  void changeValidateValue(bool isNull,Rx<bool> rxIsValidate)
  {
    rxIsValidate.value = isNull;
  }

  phoneNumberValidator(){
    if(rxPhoneNumber.value.length > 11 || rxPhoneNumber.value.length < 10) {
      return false;
    }
    if(!rxPhoneNumber.value.isPhoneNumber) {
      return false;
    }
    return true;
  }


  Future<void> getDepartmentList() async {
    var url = Uri.parse(apiGetDepartmentList);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var listEpg = <DepartmentModel>[];
      List a = json.decode(response.body) as List;
      listEpg = a.map((e) => DepartmentModel.fromJson(e)).toList();
      rxDepartmentList.value = listEpg;
    }
  }
  void searchInDepartList(String keySearch) async {
    if(keySearch != "") {
      var list = rxDepartmentList.toList().where((element) =>
          element.name!.contains(keySearch)).toList();
      rxDepartmentList.value = list;
    }
    else
      {
        getDepartmentList();
      }

  }

  Future<void> getContactList() async {
    var url = Uri.parse(apiSearhIndividualContact);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url,headers: headers,body : json);
  
    contactModel =  ContactModel.fromJson(jsonDecode(response.body));
    rxContactListItems.value = contactModel.items!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        contactModel =  ContactModel.fromJson(jsonDecode(response.body));
        rxContactListItems.addAll(contactModel.items!);
        print("loadmore day at $page");
      }
    });
  }
  Future<void> getContactListByFilter(String departmentId ) async {
    var url = Uri.parse(apiSearhIndividualContact);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10, "departmentId": "$departmentId"}';
    http.Response response = await http.post(url,headers: headers,body : json);
  
    contactModel =  ContactModel.fromJson(jsonDecode(response.body));
    rxContactListItems.value = contactModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10, "departmentId": "$departmentId"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        contactModel =  ContactModel.fromJson(jsonDecode(response.body));
        contactModel.items!.removeWhere((element) => element.departmentId != departmentId);
        rxContactListItems.addAll(contactModel.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> deleteWorkBookItem(String id) async {
    final url = Uri.parse("$apiActionIndividualContact/$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
  
    if (response.statusCode == 200) {
      getContactList();
      Get.snackbar(
        "Thông báo",
        "Xóa danh bạ thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<ContactListItems> getWorkbookModelDetail(String id) async {
    final url = Uri.parse("$apiIndividualContactDetail$id");
    http.Response response = await http.get(url);
    return ContactListItems.fromJson(jsonDecode(response.body));
  }

  Future<void> addContact(
      String employeeName,
      String position,
      String organizationId,
      String phoneNumber,
      String address,
      String email) async {
    final url = Uri.parse(apiActionIndividualContact);
    String json = """{
      "employeeName": "$employeeName",
      "departmentId": "$organizationId",
      "phoneNumber": "$phoneNumber",
      "email": "$email",
      "address": "$address",
      "position": "$position"
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
  
    if (response.statusCode == 200) {
      getContactList();
      Get.snackbar(
        "Thông báo",
        "Thêm danh bạ thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
      clearTextField();
      Get.snackbar(
        "Thông báo",
        "Thêm danh bạ thất bại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }
  Future<void> updateContact(
      String id,
      String employeeName,
      String position,
      String organizationId,
      String phoneNumber,
      String address,
      String email) async {
    final url = Uri.parse(apiActionIndividualContact);
    String json = """{
      "id" : "$id",
      "employeeName": "$employeeName",
      "departmentId": "$organizationId",
      "phoneNumber": "$phoneNumber",
      "email": "$email",
      "address": "$address",
      "position": "$position"
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
  
    if (response.statusCode == 200) {
      getContactList();
      Get.snackbar(
        "Thông báo",
        "Cập nhật danh bạ thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
      Get.snackbar(
        "Thông báo",
        "Cập nhật danh bạ thất bại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }




}
