import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/ultils.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';
import '../../model/document_out_model/document_out_model.dart';

class DocumentOutViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<DocumentOutItems> rxDocumentOutItems =
      <DocumentOutItems>[].obs;

  @override
  void onInit() {
    initCurrentDate();
    print(rxDate.value);
    getDocumentOutByDay(rxDate.value);
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
    getDocumentOutByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  //document out
  Future<void> getDocumentOutByDay(String day) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    DocumentOutModel res =  DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value= res.items!;
  }
  Future<void> getDocumentOutByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    DocumentOutModel res =  DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
  }
  Future<void> getDocumentOutByMonth() async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"isMonth": true}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    DocumentOutModel res =  DocumentOutModel.fromJson(jsonDecode(response.body));
    rxDocumentOutItems.value = res.items!;
  }

}
