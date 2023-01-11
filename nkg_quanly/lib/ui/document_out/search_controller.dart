import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nkg_quanly/model/misstion/mission_model.dart';

import '../../const/api.dart';
import '../../main.dart';
import '../../model/birthday_model/birthday_model.dart';
import '../../model/booking_car/booking_car_model;.dart';
import '../../model/calendarwork_model/calendarwork_model.dart';
import '../../model/contact_model/contact_model.dart';
import '../../model/document/document_model.dart';
import '../../model/document_out_model/document_out_model.dart';
import '../../model/group_workbook/group_workbook_model.dart';
import '../../model/guildline_model/guildline_model.dart';
import '../../model/helpdesk_model/helpdesk_model.dart';
import '../../model/meeting_room/meeting_room_model.dart';
import '../../model/misstion/mission_detail.dart';
import '../../model/profile_procedure_model/profile_procedure_model.dart';
import '../../model/profile_work/profile_work_model.dart';
import '../../model/proflie_model/profile_model.dart';
import '../../model/report_model/report_model.dart';
import '../../model/workbook/workbook_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../home/home_search.dart';

class SearchController extends GetxController {
  ScrollController controller = ScrollController();
  RxList<DocumentOutItems> listDataDocOut = <DocumentOutItems>[].obs;
  RxList<MissionItem> listDataMission = <MissionItem>[].obs;
  RxList<MeetingRoomItems> listDataRoomMeeting = <MeetingRoomItems>[].obs;
  RxList<CalendarWorkListItems> listDataCalendarWork =
      <CalendarWorkListItems>[].obs;
  RxList<BirthDayListItems> listDataBirthDay = <BirthDayListItems>[].obs;
  RxList<ProfileItems> listDataProfile = <ProfileItems>[].obs;
  RxList<ReportListItems> listDataReport = <ReportListItems>[].obs;
  RxList<ProfileProcedureListItems> listDataProfileProc =
      <ProfileProcedureListItems>[].obs;
  RxList<DocumentInListItems> listData = <DocumentInListItems>[].obs;
  RxList<HelpDeskListItems> rxHelpdeskListItems = <HelpDeskListItems>[].obs;
  RxList<SearchMenuItem> rxListSearchHome = <SearchMenuItem>[].obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isHaveData = false.obs;
  Map<String,String> headers = {};
  HomeViewModel homeController = Get.put(HomeViewModel());
  void onInit() {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $tokenIOC',
    };
    getListItemSearch();
    super.onInit();
  }

  getListItemSearch() async
  {
    await  homeController.getListAllMenuByUserRole();
    var listMenu = getListSearchMenu(homeController);
    rxListSearchHome.value = listMenu;
  }

  void changeLoadingState(bool value) {
    isLoading.value = value;
  }
  void clearData(){
    listDataMission.clear();
    rxBookingCarItems.clear();
    rxMeetingRoomItems.clear();
    rxProfileWorkList.clear();
    rxProfileItems.clear();
    listData.clear();
    listDataCalendarWork.clear();
    listDataProfileProc.clear();
    listDataReport.clear();
    rxWorkBookListItems.clear();
    isHaveData.value = false;
  }

  void searchDataDocOut(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentOutModel res = DocumentOutModel.fromJson(jsonDecode(response.body));
    listDataDocOut.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = DocumentOutModel.fromJson(jsonDecode(response.body));
        listDataDocOut.addAll(res.items!);

      }
    });
  }

  void searchDataMission(String keyword) async {
    final url = Uri.parse(apiGetMission);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    MissionModel res = MissionModel.fromJson(jsonDecode(response.body));

    listDataMission.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {

        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = MissionModel.fromJson(jsonDecode(response.body));
        listDataMission.addAll(res.items!);

      }
    });
  }

  void searchDataRoomMeeting(String keyword) async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);

    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));
    listDataRoomMeeting.value = res.items!;
  }

  void searchDataCalendarWork(String keyword) async {
    final url = Uri.parse(apiPostCalendarWork);

    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    CalendarWorkModel res =
        CalendarWorkModel.fromJson(jsonDecode(response.body));
    listDataCalendarWork.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"keyword":"$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = CalendarWorkModel.fromJson(jsonDecode(response.body));
        listDataCalendarWork.addAll(res.items!);
          
      }
    });
  }

  void searchDataBirthDay(String keyword) async {
    final url = Uri.parse(apiPostBirthDay);

    String json = '{"pageIndex":1,"pageSize":10,"keyword":"$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    BirthDayModel res = BirthDayModel.fromJson(jsonDecode(response.body));
    listDataBirthDay.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"keyword":"$keyword"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        res = BirthDayModel.fromJson(jsonDecode(response.body));
        listDataBirthDay.addAll(res.items!);

      }
    });
  }

  void searchDataProfile(String keyword) async {
    final url = Uri.parse(apiGetProfile);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    ProfileModel res = ProfileModel.fromJson(jsonDecode(response.body));
    listDataProfile.value = res.items!;
  }

  void searchDataReport(String keyword) async {
    final url = Uri.parse(apiGetReportModel);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);

    ReportModel reportModel = ReportModel.fromJson(jsonDecode(response.body));
    listDataReport.value = reportModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {

        page++;
        String json = '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
        await http.post(url, headers: headers, body: json);
        reportModel = ReportModel.fromJson(jsonDecode(response.body));
        listDataReport.addAll(reportModel.items!);

      }
    });
  }

  void searchDataProfileProc(String keyword) async {
    final url = Uri.parse(apiPostProfileProcedureModel);
    String json = '{"currentPage":1,"pageSize":10,"tuKhoa" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    ProfileProcedureModel reportModel =
        ProfileProcedureModel.fromJson(jsonDecode(response.body));
    listDataProfileProc.value = reportModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {

        page++;
        String json =
            '{"currentPage":$page,"pageSize":10,"tuKhoa" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        reportModel = ProfileProcedureModel.fromJson(jsonDecode(response.body));
        listDataProfileProc.addAll(reportModel.items!);

      }
    });
  }

  //doc non approve
  void searchData(String keyword) async {
    final url = Uri.parse(apiGetDocumentOut);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    DocumentInModel res = DocumentInModel.fromJson(jsonDecode(response.body));
    listData.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = DocumentInModel.fromJson(jsonDecode(response.body));
        listData.addAll(res.items!);
          
      }
    });
  }

  RxList<ProfileWorkListItems> rxProfileWorkList = <ProfileWorkListItems>[].obs;

  void searchProfileWork(String keyword) async {
    final url = Uri.parse(apiPostProfile);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    ProfileWorkModel res = ProfileWorkModel.fromJson(jsonDecode(response.body));
    rxProfileWorkList.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = ProfileWorkModel.fromJson(jsonDecode(response.body));
        rxProfileWorkList.addAll(res.items!);
          
      }
    });
  }

  Future<void> searchHelpdesk(String keyword) async {
    final url = Uri.parse(apiPostHelpDesk);

    String json = '{"currentPage":1,"pageSize":10,"subject" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    HelpdeskModel res = HelpdeskModel.fromJson(jsonDecode(response.body));
    rxHelpdeskListItems.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"currentPage":$page,"pageSize":10,"subject" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = HelpdeskModel.fromJson(jsonDecode(response.body));
        rxHelpdeskListItems.addAll(res.items!);
          
      }
    });
  }

  //booking car
  RxList<BookingCarListItems> rxBookingCarItems = <BookingCarListItems>[].obs;

  void searchBookingCar(String keyword) async {
    final url = Uri.parse(apiGetBookingCarListItems);
    print(keyword);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    BookingCarModel res = BookingCarModel.fromJson(jsonDecode(response.body));

    rxBookingCarItems.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = BookingCarModel.fromJson(jsonDecode(response.body));
        rxBookingCarItems.addAll(res.items!);
          
      }
    });
  }

  //booking room
  RxList<MeetingRoomItems> rxMeetingRoomItems = <MeetingRoomItems>[].obs;

  void searchRoomMeeting(String keyword) async {
    final url = Uri.parse(apiPostAllMeetingroomSearch);
    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';

    http.Response response = await http.post(url, headers: headers, body: json);
    MeetingRoomModel res = MeetingRoomModel.fromJson(jsonDecode(response.body));

    rxMeetingRoomItems.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = MeetingRoomModel.fromJson(jsonDecode(response.body));
        rxMeetingRoomItems.addAll(res.items!);
          
      }
    });
  }

  //oran contact
  RxList<ContactListItems> rxGroupContactListItems = <ContactListItems>[].obs;

  Future<void> searchOrganContact(String keyword) async {
    final url = Uri.parse(apiPostSearchListContactOrganization);

    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    ContactModel contactModel =
        ContactModel.fromJson(jsonDecode(response.body));
    rxGroupContactListItems.value = contactModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        contactModel = ContactModel.fromJson(jsonDecode(response.body));
        rxGroupContactListItems.addAll(contactModel.items!);
          
      }
    });
  }

  //individual contact
  RxList<ContactListItems> rxIndividualContactListItems =
      <ContactListItems>[].obs;

  Future<void> searchIndividualContact(String keyword) async {
    var url = Uri.parse(apiSearhIndividualContact);

    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    ContactModel contactModel =
        ContactModel.fromJson(jsonDecode(response.body));
    rxIndividualContactListItems.value = contactModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        contactModel = ContactModel.fromJson(jsonDecode(response.body));
        rxIndividualContactListItems.addAll(contactModel.items!);
          
      }
    });
  }

  //workbook
  RxList<WorkBookListItems> rxWorkBookListItems = <WorkBookListItems>[].obs;

  Future<void> searchWorkbook(String keyword) async {
    final url = Uri.parse(apiPostWorkBookSearch);

    String json = '{"pageIndex":1,"pageSize":10,"keyword" : "$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    WorkbookModel res = WorkbookModel.fromJson(jsonDecode(response.body));
    rxWorkBookListItems.value = res.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        String json =
            '{"pageIndex":$page,"pageSize":10,"keyword" : "$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        res = WorkbookModel.fromJson(jsonDecode(response.body));
        rxWorkBookListItems.addAll(res.items!);

      }
    });
  }

  //group workbook
  RxList<GroupWorkBookItems> rxListGroupWorkBookItems =
      <GroupWorkBookItems>[].obs;

  Future<void> searchGroupWorkbook(String keyword) async {
    final url = Uri.parse(apiSearchGroupWorkBook);

    String json = '{"pageIndex":1,"pageSize":10, "keyword":"$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    GroupWorkBookModel groupWorkBookModel =
        GroupWorkBookModel.fromJson(jsonDecode(response.body));
    rxListGroupWorkBookItems.value = groupWorkBookModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json = '{"pageIndex":$page,"pageSize":10, "keyword":"$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        groupWorkBookModel =
            GroupWorkBookModel.fromJson(jsonDecode(response.body));
        rxListGroupWorkBookItems.addAll(groupWorkBookModel.items!);
          
      }
    });
  }

  //profile
  RxList<ProfileItems> rxProfileItems = <ProfileItems>[].obs;

  Future<void> searchProfile(String keyword) async {
    final url = Uri.parse(apiGetProfile);

    String json = '{"pageIndex":1,"pageSize":10, "keyword":"$keyword"}';
    http.Response response = await http.post(url, headers: headers, body: json);

    ProfileModel profileModel =
        ProfileModel.fromJson(jsonDecode(response.body));
    rxProfileItems.value = profileModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
         
        page++;
        String json = '{"pageIndex":$page,"pageSize":10, "keyword":"$keyword"}';
        http.Response response =
            await http.post(url, headers: headers, body: json);
        profileModel = ProfileModel.fromJson(jsonDecode(response.body));
        rxProfileItems.addAll(profileModel.items!);
          
      }
    });
  }

  //guideline
  RxList<GuidelineListItems> rxListGuideline = <GuidelineListItems>[].obs;

  Future<void> searchGuideLine(String keyword) async {
    var url = Uri.parse(
        "http://123.31.31.237:6002/api/guidelines/search?Keyword=$keyword&PageIndex=1&PageSize=10");
    http.Response response = await http.get(url,headers: headers);
    GuidelineModel groupWorkBookModel =
        GuidelineModel.fromJson(jsonDecode(response.body));
    rxListGuideline.value = groupWorkBookModel.items!;
    changeLoadingState(false);
    isHaveData.value = true;
    //loadmore
    var page = 1;
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        page++;
        url = Uri.parse(
            "http://123.31.31.237:6002/api/guidelines/search?Keyword=$keyword&PageIndex=$page&PageSize=10");
        http.Response response = await http.get(url,headers: headers);
        groupWorkBookModel = GuidelineModel.fromJson(jsonDecode(response.body));
        rxListGuideline.addAll(groupWorkBookModel.items!);
      }
    });
  }
}
