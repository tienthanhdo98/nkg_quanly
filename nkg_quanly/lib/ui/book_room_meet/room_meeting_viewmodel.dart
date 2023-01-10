import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/model/booking_car/booking_car_model;.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../main.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../../viewmodel/home_viewmodel.dart';

class RoomMeetingViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 4.obs;

  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<MeetingRoomItems> rxMeetingRoomItems = <MeetingRoomItems>[].obs;
  Rx<BookingStatistic> rxMeetingRoomStatistic = BookingStatistic().obs;
  Map<String,String> headers = {};
  @override
  void onInit() {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    getMeetingRoomDefault();
    super.onInit();
  }


  void swtichBottomButton(int button) {
    selectedBottomButton.value = button;
  }





  //Meeting room
   getMeetingRoomDefault() async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);

    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);

    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));

    rxMeetingRoomStatistic.value = res.statistic!;
    rxMeetingRoomItems.value = res.items!;
    swtichBottomButton(4);
  }

  Future<void> getMeetingRoomByDay(String day) async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));

    // rxMeetingRoomStatistic.value = res.statistic!;
    rxMeetingRoomStatistic.value = res.statistic!;
    rxMeetingRoomItems.value = res.items!;
  }


  Future<void> getMeetingRoomListByDiffDate(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);
    print('loading');
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));

    rxMeetingRoomStatistic.value = res.statistic!;
    rxMeetingRoomItems.value = res.items!;

  }

  Future<void> getMeetingRoomByMonth() async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);
    print('loading');
    http.Response response =
        await http.post(url, headers: headers, body: jsonGetByMonth);

    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));

    rxMeetingRoomStatistic.value = res.statistic!;
    rxMeetingRoomItems.value = res.items!;
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

  Future<void> getMeetingRoomByFilter(String status) async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    
    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));
    rxMeetingRoomItems.value = res.items!;
  }

//end filter



}
