import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_report_screen.dart';

import '../../../../const/const.dart';
import '../../../../const/utils.dart';
import '../../../../model/document_unprocess/document_filter.dart';
import '../../../../model/profile_procedure_model/profile_proc_chart_model.dart';
import '../../../../viewmodel/home_viewmodel.dart';

class ProfilesProcReportViewModel extends GetxController {
  Rx<int> selectedChartButton = 0.obs;
//chart
Rx<DocumentFilterModel> rxDataChart = DocumentFilterModel().obs;
RxList<ProfileProcChartModel> rxListProfileProcChartBranch = <ProfileProcChartModel>[].obs;
RxList<ProfileProcChartModel> rxListProfileProcChartAgencies = <ProfileProcChartModel>[].obs;
RxList<ProfileProcChartModel> rxListProfileProcChartReception = <ProfileProcChartModel>[].obs;
RxList<ProfileProcChartModel> rxListProfileProcChartDate= <ProfileProcChartModel>[].obs;
@override
void onInit() {
  postProfileProcCharStatusResolve("", "");
  postProfileProcCollumChart(apiPostChartByBranch,BY_BRANCH,"", "");
  postProfileProcCollumChart(apiPostChartByAgencies,BY_AGENCIES,"", "");
  postProfileProcCollumChart(apiPostChartByReceptionform,BY_RECEPTIONFORM,"", "");
  postProfileProcCollumChart(apiPostChartByDate,BY_DATE,"", "");
  super.onInit();

}
  void swtichChartButton(int button) {
    selectedChartButton.value = button;
  }

Future<void> postProfileProcCharStatusResolve(String datefrom,
    String dateto) async {
  final url = Uri.parse(apiPostChartStatusResolve);
  String json = "";
  if (datefrom != "" && dateto != "") {
    json = '{"dateFrom":"$datefrom","dateTo":"$dateto"}';
  } else {
    json = '{}';
  }
  http.Response response = await http.post(url, headers: headers, body: json);
  print('${response.body}');
  DocumentFilterModel res =
  DocumentFilterModel.fromJson(jsonDecode(response.body));
  rxDataChart.value = res;
}

Future<void> postProfileProcCollumChart(String urlBase,String type,String dateFrom,
    String dateTo) async {
  final url = Uri.parse(urlBase);
  String bodyJson = "";
  if (dateFrom != "" && dateTo != "") {
    bodyJson = '{"dateFrom":"$dateFrom","dateTo":"$dateTo"}';
  } else {
    bodyJson = '{}';
  }
  http.Response response = await http.post(url, headers: headers, body: bodyJson);
  print('get collum chart ${response.body}');
  List<ProfileProcChartModel> listChart = [];
   List listRes = json.decode(response.body);
  listChart = listRes.map((e) => ProfileProcChartModel.fromJson(e)).toList();
  if(type == BY_BRANCH)
    {
      rxListProfileProcChartBranch.value = listChart;
    }
  else if(type == BY_AGENCIES)
    {
      rxListProfileProcChartAgencies.value = listChart;
    }
  else if(type == BY_RECEPTIONFORM)
    {
      rxListProfileProcChartReception.value = listChart;
    }
  else if(type == BY_DATE)
  {
    rxListProfileProcChartDate.value = listChart;
  }

}


}
