import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../model/booking_car/booking_car_model;.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/meeting_room/meeting_room_model.dart';

class BookingCarViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;

  Rx<DateTime> rxSelectedDay = dateNow.obs;

  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<BookingCarListItems> rxBookingCarItems = <BookingCarListItems>[].obs;
  Rx<BookingStatistic> rxBookingCarStatistic = BookingStatistic().obs;
  ScrollController controller = ScrollController();
  Map<String, String> headers = {"Content-type": "application/json"};

  @override
  void onInit() {
    getFilterForChart(apiGetReportChart0);

    postBookingCarStatistic();

    super.onInit();
  }

  void switchBottomButton(int button) {
    selectedBottomButton.value = button;
  }


  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
   
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }


  Future<void> postBookingCarStatistic() async {
    final url = Uri.parse(apiGetBookingCarListItems);
   
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarStatistic.value = res.statistic!;
    rxBookingCarItems.value = res.items!;
    switchBottomButton(4);
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
        res = BookingCarModel.fromJson(jsonDecode(response.body));
        rxBookingCarItems.addAll(res.items!);
      }
    });
  }

  Future<void> getBookingCarListByDiffDate(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetBookingCarListItems);
   
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
    rxBookingCarStatistic.value = res.statistic!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BookingCarModel.fromJson(jsonDecode(response.body));
        rxBookingCarItems.addAll(res.items!);
      }
    });
  }


  Future<MeetingRoomItems> getRoomMeetingDetail(int id) async {
    final url = Uri.parse("${apiGetMeetingDetail}id=$id");
    http.Response response = await http.get(url,headers: headers);
    return MeetingRoomItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListLevelFilter = <String>[].obs;
  RxList<String> rxListStatusFilter = <String>[].obs;


  Future<void> getBookingCarByFilter(String status) async {
    final url = Uri.parse(apiGetBookingCarListItems);
   
    String json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
    //loadmore
    var page = 1;
    controller.dispose();
    controller = ScrollController();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"status":"$status"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BookingCarModel.fromJson(jsonDecode(response.body));
        rxBookingCarItems.addAll(res.items!);
      }
    });
  }
//end filter

}
