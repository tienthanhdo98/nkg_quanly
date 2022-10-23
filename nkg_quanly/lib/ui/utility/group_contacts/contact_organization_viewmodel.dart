import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../../../model/contact_model/contact_model.dart';
import '../../../model/contact_model/organ_model.dart';


class ContactOrganizationViewModel extends GetxController {
  Rx<int> selectedButton = 0.obs;
  ScrollController controller = ScrollController();
  ContactModel contactModel = ContactModel();
  RxList<ContactListItems> rxContactListItems = <ContactListItems>[].obs;
  RxList<OrganModel> rxOrganList = <OrganModel>[].obs;
  RxList<String> rxListOrganFilter = <String>[].obs;
  final RxMap<int, String> rxMapOrganFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  @override
  void onInit() {
    getOrganList();
    getContactList();
    super.onInit();
  }
  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }
  // void checkboxOrgan(bool value, int key, String filterValue) {
  //   if (value == true) {
  //     var map = {key: filterValue};
  //     rxMapOrganFilter.addAll(map);
  //   } else {
  //     rxMapOrganFilter.remove(key);
  //   }
  // }

  Future<void> getOrganList() async {
    var url = Uri.parse(apiOrganList);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var listEpg = <OrganModel>[];
      List a = json.decode(response.body) as List;
      listEpg = a.map((e) => OrganModel.fromJson(e)).toList();
       rxOrganList.value = listEpg;
    }
  }
  void searchInOrganList(String keySearch) async {
    if(keySearch != "") {
      var list = rxOrganList.toList().where((element) =>
          element.name!.contains(keySearch)).toList();
      rxOrganList.value = list;
    }
    else
      {
        getOrganList();
      }

  }

  Future<void> getContactList() async {

      var url = Uri.parse(apiPostSearchListContactOrganization);
      print('loading');
      String json = '{"pageIndex":1,"pageSize":10}';
      http.Response response = await http.post(
          url, headers: headers, body: json);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        contactModel = ContactModel.fromJson(jsonDecode(response.body));
        rxContactListItems.value = contactModel.items!;
        //loadmore
        var page = 1;
        controller.addListener(() async {
          if (controller.position.maxScrollExtent ==
              controller.position.pixels) {
            print("loadmore day");
            page++;
            String json = '{"pageIndex":$page,"pageSize":10}';
            http.Response response =
            await http.post(url, headers: headers, body: json);
            contactModel = ContactModel.fromJson(jsonDecode(response.body));
            rxContactListItems.addAll(contactModel.items!);
            print("loadmore day at $page");
          }
        });
      }

  }
  Future<void> getContactListByFilter(String organizationId ) async {
    var url = Uri.parse(apiPostSearchListContactOrganization);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10, "organizationId": "$organizationId"}';
    http.Response response = await http.post(url,headers: headers,body : json);
    print(response.body);
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

  Future<void> deleteWorkBookItem(String id) async {
    final url = Uri.parse("$apiContactOrgan$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
    print(id);
    print(response.body);
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
    final url = Uri.parse("$apiContactOrganDetail$id");
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
    final url = Uri.parse(apiContactOrgan);
    print('loading');
    String json = """{
      "employeeName": "$employeeName",
      "organizationId": "$organizationId",
      "phoneNumber": "$phoneNumber",
      "email": "$email",
      "address": "$address",
      "position": "$position"
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      getContactList();
      Get.snackbar(
        "Thông báo",
        "Thêm danh bạ thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    } else {
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
    final url = Uri.parse(apiContactOrgan);
    print('loading');
    String json = """{
      "id" : "$id",
      "employeeName": "$employeeName",
      "organizationId": "$organizationId",
      "phoneNumber": "$phoneNumber",
      "email": "$email",
      "address": "$address",
      "position": "$position"
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
    print(response.body);
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
