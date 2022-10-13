import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../model/document_out_model/document_out_model.dart';

class DocumentOutViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};

  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;

  RxList<DocumentOutItems> rxDocumentOutItems = <DocumentOutItems>[].obs;

  @override
  void onInit() {
    getDocumentOutByDay(formatDateToString(dateNow));
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    getDocumentOutByDay(strSelectedDay);
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
  }

  Future<void> getDocumentOutByMonth() async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"isMonth": true}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
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
  }
//end filet

}
