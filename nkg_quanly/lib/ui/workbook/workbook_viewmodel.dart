import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/const.dart';
import 'package:nkg_quanly/const/api.dart';

import '../../const/ultils.dart';
import '../../model/workbook/group_workbook_model.dart';
import '../../model/workbook/workbook_model.dart';

class WorkBookViewModel extends GetxController {
  Map<String, String> headers = {"Content-type": "application/json"};
  Rx<String> rxDate = "".obs;
  Rx<int> selectedBottomButton = 0.obs;
  Rx<DateTime> rxSelectedDay = dateNow.obs;
  Rx<CalendarFormat> rxCalendarFormat = CalendarFormat.week.obs;
  RxList<WorkBookListItems> rxWorkBookListItems = <WorkBookListItems>[].obs;
  RxList<GroupWorkbookListItems> rxGroupWorkBookListItems = <GroupWorkbookListItems>[].obs;
  Rx<bool> rxSwitchState = false.obs;


  @override
  void onInit() {
    initCurrentDate();
    // postWorkBookByDay(rxDate.value);
    postGroupWorkBook();
    postWorkBookAll();

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
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
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
    final url = Uri.parse("${apiWorkBookDelete}$id");
    print('loading');
    http.Response response = await http.delete(url, headers: headers);
    print(id);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Xóa công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );
    }
  }

  Future<void> addWorkBookAll(String workName, String groupWorkName,
      String description, String worker, String status, bool important,String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "worker": "$worker",
      "workBy": "$worker",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
      Get.snackbar(
        "Thông báo",
        "Thêm công việc thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kWhite,
      );

    }
    else
      {
        Get.snackbar(
          "Thông báo",
          "Thêm công việc thất bại",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kWhite,
        );
      }
  }

  Future<void> updateWorkBook(String id,String workName, String groupWorkName,
      String description, String worker, String status, bool important,String groupWorkId) async {
    final url = Uri.parse(apiAddWorkBook);
    print('loading');
    String json = """{
      "id": "$id",
      "workName": "$workName",
      "groupWorkName": "$groupWorkName",
      "groupWorkId": "$groupWorkId",
      "description": "$description",
      "worker": "$worker",
      "workBy": "$worker",
      "status": "$status",
      "important": $important
    }""";
    http.Response response = await http.put(url, headers: headers, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      postWorkBookAll();
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
  final RxMap<int, String> mapImportantFilter = <int, String>{}.obs;
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

  void checkboxmapImportantFilter(bool value, int key, String filterValue) {
    if (value == true) {
      var map = {key: filterValue};
      mapImportantFilter.addAll(map);
    } else {
      mapImportantFilter.remove(key);
    }
  }
  Future<void> postWorkBookByFilter(String important,String status) async {
    final url = Uri.parse(apiPostWorkBookSearch);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":30, "important": "$important","status":"$status"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
  }
  Future<void> postGroupWorkBook() async {
    final url = Uri.parse(apiGroupBookList);
    print('loading');
    String json = '{"pageIndex":1,"pageSize":10}';
    http.Response response = await http.post(url, headers: headers, body: json);
    print(response.body);
    GroupWorkbookModel res = GroupWorkbookModel.fromJson(jsonDecode(response.body));
    rxGroupWorkBookListItems.value = res.items!;
  }

}
