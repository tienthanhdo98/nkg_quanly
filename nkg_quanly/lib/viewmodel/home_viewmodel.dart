import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_model.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../model/birthday_model/birthday_model.dart';
import '../model/document_out_model/document_out_model.dart';
import '../model/document_unprocess/document_filter.dart';
import '../model/misstion/mission_model.dart';
import '../model/proflie_model/profile_model.dart';
import '../model/proflie_model/profile_statistic.dart';
import '../model/report_model/report_model.dart';
import '../model/report_model/report_statistic_model.dart';
import '../model/weather_model/weather_model.dart';


class HomeViewModel extends GetxController {
  RxList<Items> listData = <Items>[].obs;
  Rx<int> selectedButton = 0.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<WeatherModel> rxWeatherModel = WeatherModel().obs;
  @override
  void onInit() {
    getWeather();
    getFilterForChart(apiGetReportChart0);
    super.onInit();
  }
  void swtichButton(int button){
      selectedButton.value = button;
  }

  Future<void> getWeather() async {
    var url = 'http://123.31.31.237:6002/api/weather?Lat=21.028511&Lon=105.804817';
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    WeatherModel weatherModel=  WeatherModel.fromJson(jsonDecode(response.body));
    rxWeatherModel.value =  weatherModel;
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel = DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  Map<String, String> headers = {"Content-type": "application/json"};
  Future<DocumentModel> getDocument() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    return DocumentModel.fromJson(jsonDecode(response.body));
  }

  Future<DocumentStatisticModel> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocumentStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentStatisticModel.fromJson(jsonDecode(response.body));
  }




  //document unprocess
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }


  //doc non approve
  void searchData(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentModel res =DocumentModel.fromJson(jsonDecode(response.body));
    listData.value = res.items!;
  }







}
