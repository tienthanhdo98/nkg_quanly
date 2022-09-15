import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../const/api.dart';
import '../../model/document_out_model/document_out_model.dart';
import '../../model/proflie_model/profile_model.dart';

class ProfileController extends GetxController {
  RxList<ProfileItems> listData = <ProfileItems>[].obs;

  Map<String, String> headers = {"Content-type": "application/json"};
  void searchData(String keyword) async {
    final url = Uri.parse(apiGetProfile);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    ProfileModel res = ProfileModel.fromJson(jsonDecode(response.body));
    listData.value = res.items!;

  }
}
