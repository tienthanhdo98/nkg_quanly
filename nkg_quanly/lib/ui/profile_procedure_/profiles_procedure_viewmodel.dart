import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';


import '../../const.dart';
import '../../const/ultils.dart';
import '../../model/document_unprocess/document_filter.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';



class ProfilesProcedureViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<String> rxDate = "".obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  Rx<DocumentFilterModel> rxDocumentFilterModel = DocumentFilterModel().obs;
  RxList<ProfileProcedureListItems> rxProfileProcedureListItems =
      <ProfileProcedureListItems>[].obs;
  @override
  void onInit() {
    getFilterForChart(apiGetProfileProcedureChart0);
    initCurrentDate();
    postProfileProcByDay(rxDate.value);
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
    postProfileProcByDay(rxDate.value);
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


//report
  Map<String, String> headers = {"Content-type": "application/json"};
 Future<DocumentFilterModel> geProfileProcStatistic() async {
   final url = Uri.parse(apiGetProfileProcedureStatistic);
    print('loading');
    http.Response response = await http.get(url);
    print(response.body);
    return DocumentFilterModel.fromJson(jsonDecode(response.body));
  }
  Future<void> postProfileProcByDay(String day) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json = '{"pageIndex":1,"pageSize":10,"dayInMonth": "$day"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
  }

  Future<void> postProfileProcByWeek(String datefrom, String dateTo) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json =
        '{"pageIndex":1,"pageSize":10,"dateFrom":"$datefrom","dateTo":"$dateTo"}';
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: json);
    print(response.body);
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
  }

  Future<void> postProfileProcByMonth() async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    print('loading');
    http.Response response = await http.post(url,headers: headers,body: jsonGetByMonth);
    print('rxProfileProcedureListItems ${response.body}');
    ProfileProcedureModel res =  ProfileProcedureModel.fromJson(jsonDecode(response.body));
    rxProfileProcedureListItems.value = res.items!;
    print('rxProfileProcedureListItems ${rxProfileProcedureListItems.length}');
  }


  Future<ProfileProcedureListItems> getProfileProcDetail(int id) async {
    final url = Uri.parse("${apiPostProfileProcedureDetail}id=$id");
    http.Response response = await http.get(url);
    return ProfileProcedureListItems.fromJson(jsonDecode(response.body));
  }



}
