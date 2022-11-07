import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/document_out_model/document_out_model.dart';

class DocumentOutViewModel extends GetxController {


  Rx<int> selectedBottomButton = 0.obs;

  RxList<DocumentOutItems> rxDocumentOutItems = <DocumentOutItems>[].obs;
  ScrollController controller = ScrollController();
  @override
  void onInit() {
    getDocumentOutDefault();
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    getDocumentOutByDay(strSelectedDay);
  }
 getDocumentOutDefault() async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
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
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        rxDocumentOutItems.addAll(res.items!);
      }
    });
  }
  //document out
  Future<void> getDocumentOutByDay(String day) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        rxDocumentOutItems.addAll(res.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> getDocumentOutByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        rxDocumentOutItems.addAll(res.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> getDocumentOutByMonth() async {
    final url = Uri.parse(apiGetDocumentOut);
    String jsonGetByMonth =
        '{"pageIndex":1,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dayInMonth":"${formatDateToString(dateNow)}"}';
        http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        rxDocumentOutItems.addAll(res.items!);
        print("loadmore w at $page");
      }
    });
  }

  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;

  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }

  void checkboxStatus(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapStatusFilter.addAll(map);
    } else {
      mapStatusFilter.remove(key);
    }
  }

  Future<void> postDocOutByFilter(String status) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore week");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"status":"$status"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        rxDocumentOutItems.addAll(res.items!);
        print("loadmore w at $page");
      }
    });
  }
//end filet

}
