import 'dart:convert';

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

  Map<String, String> headers = {"Content-type": "application/json"};

  @override
  void onInit() {
    getFilterForChart(apiGetReportChart0);

    postBookingCarStatistic();
    // postBookingCarByDay(formatDateToString(dateNow));
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void onSelectDay(DateTime selectedDay) {
    var strSelectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    postBookingCarByDay(strSelectedDay);
  }

  Future<void> getFilterForChart(String url) async {
    rxDocumentFilterModel.refresh();
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel =
        DocumentFilterModel.fromJson(jsonDecode(response.body));
    
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
  }

  //book car
  Future<void> postBookingCarByDay(String day) async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
    rxBookingCarStatistic.value = res.statistic!;
  }

  Future<void> postBookingCarStatistic() async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarStatistic.value = res.statistic!;
    rxBookingCarItems.value = res.items!;
  }

  Future<void> postookingCarByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
    rxBookingCarStatistic.value = res.statistic!;
  }

  Future<void> postBookingCarByMonth() async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
    rxBookingCarStatistic.value = res.statistic!;
  }

  Future<MeetingRoomItems> getRoomMeetingDetail(int id) async {
    final url = Uri.parse("${apiGetMeetingDetail}id=$id");
    http.Response response = await http.get(url);
    return MeetingRoomItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
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

  void checkboxLevel(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapLevelFilter.addAll(map);
    } else {
      mapLevelFilter.remove(key);
    }
  }

  Future<void> getBookingCarByFilter(String status) async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));
    rxBookingCarItems.value = res.items!;
  }
//end filter

}
