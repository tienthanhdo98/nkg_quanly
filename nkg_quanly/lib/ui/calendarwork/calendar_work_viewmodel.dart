import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';

class CalendarWorkViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};
  ScrollController controller = ScrollController();
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  CalendarWorkModel calendarWorkModel = CalendarWorkModel();

  RxList<CalendarWorkListItems> rxCalendarWorkListItems =
      <CalendarWorkListItems>[].obs;
  RxList<CalendarWorkListItems> rxCalendarWorkListItemsInHome =
      <CalendarWorkListItems>[].obs;

  @override
  void onInit() {
   // postCalendarWorkByDay(formatDateToString(dateNow));

    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postCalendarWorkByDay(strSelectedDay);
  }

  //calendar work
  Future<void> getDataCalendarWorkByDayInHomeScreen(String day) async {
    final url = Uri.parse(apiPostCalendarWork);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    calendarWorkModel = CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItemsInHome.value = calendarWorkModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        calendarWorkModel =
            CalendarWorkModel.fromJson(jsonDecode(response.body));
        rxCalendarWorkListItemsInHome.addAll(calendarWorkModel.items!);
      }
    });
  }

  postCalendarWorkAll() async {
    final url = Uri.parse(apiPostCalendarWork);
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    calendarWorkModel = CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = calendarWorkModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore all");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        calendarWorkModel =
            CalendarWorkModel.fromJson(jsonDecode(response.body));
        rxCalendarWorkListItems.addAll(calendarWorkModel.items!);
        print("loadmore day at $page");
      }
    });

  }

  Future<void> postCalendarWorkByDay(String day) async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading calen work by day');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    calendarWorkModel = CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = calendarWorkModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore day");
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"dayInMonth": "$day"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        calendarWorkModel =
            CalendarWorkModel.fromJson(jsonDecode(response.body));
        rxCalendarWorkListItems.addAll(calendarWorkModel.items!);
        print("loadmore day at $page");
      }
    });
  }

  Future<void> postCalendarWorkByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    calendarWorkModel = CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = calendarWorkModel.items!;
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
        calendarWorkModel =
            CalendarWorkModel.fromJson(jsonDecode(response.body));
        rxCalendarWorkListItems.addAll(calendarWorkModel.items!);
        print("loadmore w at $page");
      }
    });
  }

  Future<void> postCalendarWorkByMonth() async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    
    calendarWorkModel = CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = calendarWorkModel.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        print("loadmore m");
        page++;
        String jsonGetByMonth =
            '{"pageIndex":$page,"pageSize":10,"isMonth": true,"dateFrom":"${formatDateToString(dateNow)}"}';
        http.Response response =
            await http.post(url, headers: headers, body: jsonGetByMonth);
        calendarWorkModel =
            CalendarWorkModel.fromJson(jsonDecode(response.body));
        rxCalendarWorkListItems.addAll(calendarWorkModel.items!);
        print("loadmore m at $page");
      }
    });
  }
}
