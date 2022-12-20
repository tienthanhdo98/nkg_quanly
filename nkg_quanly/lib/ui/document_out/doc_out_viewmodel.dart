import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/document_out_model/document_out_model.dart';

class DocumentOutViewModel extends GetxController {


  Rx<int> selectedBottomButton = 4.obs;

  RxList<DocumentOutItems> rxDocumentOutItems = <DocumentOutItems>[].obs;
  ScrollController controller = ScrollController();
  @override
  void onInit() {
    getFilterDepartment();
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

 getDocumentOutDefault() async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
    swtichBottomButton(4);
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


  Future<void> getDocumentOutListByDiffDate(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    
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


  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;

  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;

  Rx<String> rxDepartmentSelected = "".obs;

  Future<void> getFilterDepartment() async {
    print('loading');
    http.Response response = await http.get(
        Uri.parse("http://123.31.31.237:6002/api/documentout/department-public"),headers: headers);
    List<dynamic> listRes = jsonDecode(response.body);
    List<String> listUnit = listRes.map((e) => e.toString()).toList();
    rxListDepartmentFilter.value = listUnit;
    print(rxListDepartmentFilter.value);
  }

  void checkboxFilterAll(bool value, int key) {
    if (value == true) {
      var map = {key: ""};
      mapAllFilter.addAll(map);
    } else {
      mapAllFilter.remove(key);
    }
  }


  Future<void> postDocOutByFilter(String departmentPublic) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"departmentPublic":"$departmentPublic"}';
    print('loading');
    print('$departmentPublic');
    http.Response response = await http.post(url, headers: headers, body: json);
    
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
        String json = '{"pageIndex":$page,"pageSize":10,"departmentPublic":"$departmentPublic"}';
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
