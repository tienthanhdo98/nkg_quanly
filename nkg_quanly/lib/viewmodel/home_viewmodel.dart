import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/document/document_statistic_model.dart';

import '../const/const.dart';
import '../main.dart';
import '../model/MenuByUserModel.dart';
import '../model/document_unprocess/document_filter.dart';
import '../model/weather_model/weather_model.dart';

class HomeViewModel extends GetxController {
  Rx<int> selectedButton = 0.obs;

  // Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<WeatherModel> rxWeatherModel = WeatherModel().obs;
  RxList<MenuByUserModel> rxListMenuByUserRole = <MenuByUserModel>[].obs;
  RxList<MenuByUserModel> rxListMenuByUserForPermission =
      <MenuByUserModel>[].obs;
  Map<String, String> headers = {};

  void switchButton(int button) {
    selectedButton.value = button;
  }

  Future<void> getWeather() async {
    var url =
        'http://123.31.31.237:6002/api/weather?Lat=21.028511&Lon=105.804817';
    print('loading');

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      WeatherModel weatherModel =
          WeatherModel.fromJson(jsonDecode(response.body));
      rxWeatherModel.value = weatherModel;
    }
  }

  // Future<void> getFilterForChart(String url) async {
  //
  //   rxDocumentFilterModel.refresh();
  //   print('loading');
  //   http.Response response = await http.get(Uri.parse(url),headers: headers);
  //   DocumentFilterModel documentFilterModel =
  //       DocumentFilterModel.fromJson(jsonDecode(response.body));
  //
  //   rxDocumentFilterModel.update((val) {
  //     val!.totalRecords = documentFilterModel.totalRecords;
  //     val.items = documentFilterModel.items;
  //   });
  // }

  Future<DocumentStatisticModel> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocumentStatistic);
    http.Response response = await http.get(url, headers: headers);

    return DocumentStatisticModel.fromJson(jsonDecode(response.body));
  }

  //document unprocess
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }

  getInitDataHomeScreen() async {
    var token = await loginViewModel.loadFromShareFrefs(keyTokenIOC);
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    getListAllMenuByUserRole();
    getWeather();
  }

  getListAllMenuByUserRole() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    var body = """
    {
      "appId": "${loginViewModel.rxInfoLoginConfig.value.appId}"
     }
    """;
    http.Response response = await http.post(Uri.parse(apiGetAllListMenu),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      var listMenu = <MenuByUserModel>[];
      List a = json.decode(response.body) as List;
      listMenu = a.map((e) {
        // print("element: ${e}");
        return MenuByUserModel.fromJson(e);
      }).toList();

      listMenu.removeWhere((element) =>
          element.id == "6fe5fab6-6e02-4c8a-6cd9-08dac87e041c" ||
          element.id == "ec8c1097-fdd0-45e4-6cd8-08dac87e041c" ||
          element.id == "29b38589-cbf7-4d87-fb32-08dac38ca11b" ||
          element.id == "d4cc0019-29be-4286-fb31-08dac48ca11b" ||
          element.id == "326bbe12-4778-458e-5411-08da9b7bdabe");
      rxListMenuByUserRole.clear();
      rxListMenuByUserRole.value = listMenu;
      rxListMenuByUserRole.refresh();

    }
  }
}
