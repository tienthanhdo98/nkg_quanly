import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../const/const.dart';
import '../model/document_unprocess/document_filter.dart';
import '../model/weather_model/weather_model.dart';

class HomeViewModel extends GetxController {
  Rx<int> selectedButton = 0.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<WeatherModel> rxWeatherModel = WeatherModel().obs;

  @override
  void onInit() {
    getWeather();
    getFilterForChart(apiGetReportChart0);
    super.onInit();
  }

  void swtichButton(int button) {
    selectedButton.value = button;
  }

  Future<void> getWeather() async {
    var url =
        'http://123.31.31.237:6002/api/weather?Lat=21.028511&Lon=105.804817';
    print('loading');
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    
    WeatherModel weatherModel =
        WeatherModel.fromJson(jsonDecode(response.body));
    rxWeatherModel.value = weatherModel;
    print(weatherModel.linkIcon);
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }



  Future<DocumentStatisticModel> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocumentStatistic);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    
    return DocumentStatisticModel.fromJson(jsonDecode(response.body));
  }

  //document unprocess
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }
}
