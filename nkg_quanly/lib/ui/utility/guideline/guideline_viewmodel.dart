import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../../const/const.dart';
import '../../../main.dart';
import '../../../model/guildline_model/guildline_model.dart';
import '../../../viewmodel/home_viewmodel.dart';


class GuildlineViewModel extends GetxController {

  ScrollController controller = ScrollController();
  GuidelineModel guidelineModel = GuidelineModel();
  RxList<GuidelineListItems> rxGuideLineListItems= <GuidelineListItems>[].obs;
  Map<String,String> headers = {};
  @override
  void onInit() {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    getGuidelineList();
    super.onInit();
  }

  Future<void> getGuidelineList() async {
    var url = Uri.parse(getGuideline);
    print('loading');
    http.Response response = await http.get(url,headers: headers);
    
    guidelineModel =  GuidelineModel.fromJson(jsonDecode(response.body));
    rxGuideLineListItems.value = guidelineModel.items!;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        var url = Uri.parse("http://123.31.31.237:6002/api/guidelines/search?Keyword=%20&PageIndex=$page");
        http.Response response =
        await http.get(url,headers: headers);
        guidelineModel =  GuidelineModel.fromJson(jsonDecode(response.body));
        rxGuideLineListItems.addAll(guidelineModel.items!);
        print("loadmore day at $page");
      }
    });
  }
  Future<String> getLinkDowloadGuilde(String id)
  async {
    var url = Uri.parse("$getGuidelineDownload$id");
    http.Response response = await http.get(url,headers: headers);
    
    return response.body;
  }





}
