import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/model/misstion/mission_model.dart';
import 'package:nkg_quanly/ui/misstion/mission_list.dart';
import '../../const/api.dart';
import '../../model/document_out_model/document_out_model.dart';

class SearchController extends GetxController {
  RxList<DocumentOutItems> listDataDocOut = <DocumentOutItems>[].obs;
  RxList<MisstionItem> listDataMission = <MisstionItem>[].obs;

  Map<String, String> headers = {"Content-type": "application/json"};
  void searchDataDocOut(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentOutModel res =DocumentOutModel.fromJson(jsonDecode(response.body));
    listDataDocOut.value = res.items!;
  }
  void searchDataMission(String keyword) async {
    final url = Uri.parse(apiGetMission);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    MissionModel res =MissionModel.fromJson(jsonDecode(response.body));
    listDataMission.value = res.items!;
  }
}
