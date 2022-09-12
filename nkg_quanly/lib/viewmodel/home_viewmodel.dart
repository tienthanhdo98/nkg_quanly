import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_model.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';


class HomeViewModel extends GetxController {
  Future<DocumentModel> getDocument() async {
    final url = Uri.parse(apiGetDocument);
    http.Response response = await http.get(url);

    return DocumentModel.fromJson(jsonDecode(response.body));
  }

  Future<DocumentStatisticModel> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocumentStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentStatisticModel.fromJson(jsonDecode(response.body));
  }

  Future<Items> getDocumentDetail(int id) async {
    final url = Uri.parse("${apiGetDocumentDetail}id=$id");
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return Items.fromJson(jsonDecode(response.body));
  }
}
