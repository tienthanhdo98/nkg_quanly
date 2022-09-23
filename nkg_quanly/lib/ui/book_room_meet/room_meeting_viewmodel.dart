import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';

import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../../model/meeting_room/meeting_room_statistic_model.dart';

class RoomMeetingViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<String> rxDate = "".obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<MeetingRoomItems> rxMeetingRoomItems=
      <MeetingRoomItems>[].obs;

  Map<String, String> headers = {"Content-type": "application/json"};
  @override
  void onInit() {
    getFilterForChart(apiGetReportChart0);
    initCurrentDate();
    getMeetingRoomByDay(rxDate.value);
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
    getMeetingRoomByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
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


  //Meeting room
  Future<MeetingRoomStatisticModel> getMeetingRoomStatistic() async {
    final url = Uri.parse(apiGetMeetingroomStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return MeetingRoomStatisticModel.fromJson(jsonDecode(response.body));
  }
  Future<void> getMeetingRoomByDay(String day) async {
    final url = Uri.parse(apiPostAllMeetingroom);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    MeetingRoomModel res=   MeetingRoomModel.fromJson(jsonDecode(response.body));
    rxMeetingRoomItems.value = res.items!;
  }
  Future<void> getMeetingRoomByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostAllMeetingroom);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    MeetingRoomModel res=   MeetingRoomModel.fromJson(jsonDecode(response.body));
    rxMeetingRoomItems.value = res.items!;
  }
  Future<void> getMeetingRoomByMonth() async {
    final url = Uri.parse(apiPostAllMeetingroom);
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: jsonGetByMonth);
    print(response.body);
    MeetingRoomModel res=   MeetingRoomModel.fromJson(jsonDecode(response.body));
    rxMeetingRoomItems.value = res.items!;
  }


  Future<MeetingRoomItems> getRoomMeetingDetail(int id) async {
    final url = Uri.parse("${apiGetMeetingDetail}id=$id");
    http.Response response = await http.get(url);
    return MeetingRoomItems.fromJson(jsonDecode(response.body));
  }
}
