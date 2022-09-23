import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/report_model/report_model.dart';
import '../../model/report_model/report_statistic_model.dart';

class ReportViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  Rx<String> rxDate = "".obs;
  RxList<ReportListItems> rxReportListItems= <ReportListItems>[].obs;
  @override
  void onInit() {
    getFilterForChart(apiGetReportChart0);
    initCurrentDate();
    print(rxDate.value);
    postReportByDay(rxDate.value);
    super.onInit();
  }

  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }
  void swtichBottomButton (int button) {
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
    postReportByDay(rxDate.value);
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


  Map<String, String> headers = {"Content-type": "application/json"};
  //report
  Future<ReportStatisticModel> getReportStatistic() async {
    final url = Uri.parse(apiGetReportStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return ReportStatisticModel.fromJson(jsonDecode(response.body));
  }

  Future<ReportModel> postReport() async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    return ReportModel.fromJson(jsonDecode(response.body));
  }
  Future<void> postReportByDay(String day) async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    ReportModel res = ReportModel.fromJson(jsonDecode(response.body));

    rxReportListItems.value = res.items!;
  }
  Future<void> postReportByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiGetReportModel);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: json);
    ReportModel res = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = res.items!;
  }
  Future<void> postReportByMonth() async {
    final url = Uri.parse(apiGetReportModel);
    print('loading');
    http.Response response = await http.post(url, headers: headers, body: jsonGetByMonth);
    print(response.body);
    ReportModel res = ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = res.items!;
  }
  Future<void> postReportByFilter(String status,String level) async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10,"level":"$level","status": "$status"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ReportModel res =  ReportModel.fromJson(jsonDecode(response.body));
    rxReportListItems.value = res.items!;
  }


  Future<ReportListItems> getReportDetail(int id) async {
    final url = Uri.parse("${apiGetReportDetail}id=$id");
    http.Response response = await http.get(url);
    return ReportListItems.fromJson(jsonDecode(response.body));
  }
}
