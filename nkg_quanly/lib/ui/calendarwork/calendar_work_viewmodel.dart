import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/ultils.dart';
import '../../const.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';

class CalendarWorkViewModel extends GetxController {

  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<CalendarWorkListItems> rxCalendarWorkListItems =
      <CalendarWorkListItems>[].obs;

  @override
  void onInit() {
    initCurrentDate();
    postCalendarWorkByDay(rxDate.value);
    super.onInit();
  }

  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }

  void initCurrentDate() {
    rxDate.value = DateFormat('yyyy-MM-dd').format(dateNow);
  }

  void onSelectDay(DateTime selectedDay) {
    rxSelectedDay.value = selectedDay;
    var a = DateFormat('yyyy-MM-dd').format(selectedDay);
    print("a $a");
    rxDate.value = formatDateToString(selectedDay);
    print("data ${rxDate.value}");
    postCalendarWorkByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  //calendar work


  Future<CalendarWorkModel> postCalendarWorkAll() async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    return CalendarWorkModel.fromJson(jsonDecode(response.body));
  }

  Future<void> postCalendarWorkByDay(String day) async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    CalendarWorkModel res =
        CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = res.items!;
  }

  Future<void> postCalendarWorkByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    CalendarWorkModel res =
        CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = res.items!;
  }

  Future<void> postCalendarWorkByMonth() async {
    final url = Uri.parse(apiPostCalendarWork);
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    CalendarWorkModel res =
        CalendarWorkModel.fromJson(jsonDecode(response.body));
    rxCalendarWorkListItems.value = res.items!;
  }
}
