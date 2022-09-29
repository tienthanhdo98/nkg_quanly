import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/ultils.dart';
import '../../const.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';
import '../../model/document/document_model.dart';
import '../../model/document/document_statistic_model.dart';
import '../../model/document_unprocess/document_filter.dart';

class DocumentNonApproveViewModel extends GetxController {
  //
  Rx<int> selectedChartButton = 0.obs;
  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }
  //
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<DocumentInListItems> rxItems =
      <DocumentInListItems>[].obs;
  Rx<DocumentInStatistic> rxDocumentInStatistic =
      DocumentInStatistic().obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  @override
  void onInit() {
    getFilterForChart("${apiGetDocumentApproveFilterChart}0");
    initCurrentDate();
    print(rxDate.value);
    getDocumentByDay(rxDate.value);
    super.onInit();
  }
  Future<void> getFilterForChart(String url) async {

    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    DocumentFilterModel documentFilterModel = DocumentFilterModel.fromJson(jsonDecode(response.body));
    print(response.body);
    rxDocumentFilterModel.update((val) {
      val!.totalRecords = documentFilterModel.totalRecords;
      val.items = documentFilterModel.items;
    });
    rxDocumentFilterModel.refresh();
    print('updatedat');
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
    getDocumentByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }
  //document unprocess
  Future<DocumentFilterModel> getQuantityDocumentBuUrl(String url) async {
    print('loading');
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }
  Future<void> getDocumentStatistic() async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    DocumentInModel res =  DocumentInModel.fromJson(jsonDecode(response.body));
    rxDocumentInStatistic.value = res.statistic!;
  }
  Future<DocumentInListItems> getDocumentDetail(int id) async {
    final url = Uri.parse("${apiGetDocumentDetail}id=$id");
    print('loading detail');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentInListItems.fromJson(jsonDecode(response.body));
  }
  Future<void> getDocumentByDay(String day) async {
    final url = Uri.parse(apiGetDocument);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    DocumentInModel res =  DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = res.items!;
  }
  Future<void> getDocumentByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetDocument);
  String json =
      '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    DocumentInModel res =  DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = res.items!;
  }
  Future<void> getDocumentByMonth() async {
    final url = Uri.parse(apiGetDocument);
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: jsonGetByMonth);
    DocumentInModel res =  DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = res.items!;
  }
  Future<void> getDocumentByFilter(String status,String level,String department) async {
    final url = Uri.parse(apiGetDocument);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10,"level":"$level","status": "$status","departmentPublic":"$department"}';
    http.Response response = await http.post(url,headers: headers,body: json);
    DocumentInModel res =  DocumentInModel.fromJson(jsonDecode(response.body));
    rxItems.value = res.items!;
  }

}
