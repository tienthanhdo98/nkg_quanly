import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/ultils.dart';
import '../../const.dart';
import '../../model/birthday_model/birthday_model.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';

class BirthDayViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<BirthDayListItems> rxBirthDayListItems =
      <BirthDayListItems>[].obs;
  Rx<BirthDayModel> rxBirthDayModel =
      BirthDayModel().obs;

  @override
  void onInit() {
    initCurrentDate();
    print(rxDate.value);
    postBirthDayByDay(rxDate.value);
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
    postBirthDayByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  //birthday
  Future<void> postBirthDayByDay(String day) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url,headers:headers, body: json);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;

  }
  Future<void> postBirthDayByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url,headers:headers, body: json);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
  }
  Future<void> postBirthDayByMonth() async {
    final url = Uri.parse(apiPostBirthDay);
    print('loading');
    http.Response response = await http.post(url,headers:headers, body: jsonGetByMonth);
    print(response.body);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    rxBirthDayListItems.value = res.items!;
    rxBirthDayModel.value = res;
  }

}
