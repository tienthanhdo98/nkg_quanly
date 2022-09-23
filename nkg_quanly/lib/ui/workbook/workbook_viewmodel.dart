import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/const/api.dart';

import '../../const/ultils.dart';
import '../../model/workbook/workbook_model.dart';

class WorkBookViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<WorkBookListItems> rxWorkBookListItems = <WorkBookListItems>[].obs;
  Rx<bool> rxSwitchState = false.obs;


  @override
  void onInit() {
    initCurrentDate();
    postWorkBookByDay(rxDate.value);
    super.onInit();
  }

  void switchChangeState(bool value) {
    rxSwitchState.value = value;
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
    postWorkBookByDay(rxDate.value);
  }

  void switchFormat(CalendarFormat format) {
    rxCalendarFormat.value = format;
  }

  //calendar work

  Future<void> postWorkBookAll() async {
    final url = Uri.parse(apiPostWorkBookSearch);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":30}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
    print(res.items![0].worker);
  }

  Future<void> postWorkBookByDay(String date) async {
    final url = Uri.parse(apiPostWorkBookSearch);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":30, "date": "$date"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
  }

  Future<void> deleteWorkBookItem(String id) async {
    final url = Uri.parse(apiWorkBookDelete);
    print('loading');
    String json = '["$id"]';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(id);
    print(response.body);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Xóa công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> addWorkBookAll(String workName, String groupWorkName,
      String description, String worker, bool status, bool important) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "e22c45a7-d701-40c8-78de-08da970326d9",
      "description": "$description",
      "worker": "$worker",
      "workBy": "Cao Sơn Cao",
      "status": $status,
      "important": $important
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Xóa công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> updateWorkBook(String workName, String groupWorkName,
      String description, String worker, bool status, bool important) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "e22c45a7-d701-40c8-78de-08da970326d9",
      "description": "$description",
      "worker": "$worker",
      "workBy": "Cao Sơn Cao",
      "status": $status,
      "important": $important
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Cập nhật công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<WorkBookListItems> getWorkbookModelDetail(String id) async {
    final url = Uri.parse("${apiWorkBookDetail}$id");
    http.Response response = await http.get(url);
    return WorkBookListItems.fromJson(jsonDecode(response.body));
  }

  //filter
  final RxMap<int, String> mapDepartmentFilter = <int, String>{}.obs;
  final RxMap<int, String> mapLevelFilter = <int, String>{}.obs;
  final RxMap<int, String> mapStatusFilter = <int, String>{}.obs;
  final RxMap<int, String> mapAllFilter = <int, String>{}.obs;
  RxList<String> rxListDepartmentFilter = <String>[].obs;
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

  void checkboxDepartment(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapDepartmentFilter.addAll(map);
    } else {
      mapDepartmentFilter.remove(key);
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
}
