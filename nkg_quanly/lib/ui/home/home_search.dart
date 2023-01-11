import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/model/MenuByUserModel.dart';

import '../../const/const.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_out/search_controller.dart';
import 'home_screen.dart';

class HomeSearch extends GetView {
  final searchController = Get.put(SearchController());

  HomeViewModel homeController = Get.find();
  HomeSearch({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var listMenu = getListSearchMenu(homeController);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                      bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/icons/ic_arrow_back.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kgray,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(Icons.search)),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập tên chức năng',
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    //print(value);
                                    searchByKeyword(
                                        value, searchController, listMenu);
                                  },
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: Obx(() => ListView.builder(
                    itemCount: searchController.rxListSearchHome.length,
                    itemBuilder: (context, index) {
                      var item = searchController.rxListSearchHome[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(item.url!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(item.title!,
                              style: const TextStyle(
                                  color: kBlueButton,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                        ),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void searchByKeyword(String keyword, SearchController searchController,
    List<SearchMenuItem> listMenu) {
  List<SearchMenuItem> listResult = [];
  for (var element in listMenu) {
    if (element.title!.toLowerCase().contains(keyword.toLowerCase())) {
      listResult.add(element);
    }
  }
  searchController.rxListSearchHome.value = listResult;
}

List<MenuListItem> listMenuSearch = [
  //menu
  MenuListItem('Không gian làm việc số', 'assets/icons/ic_pmis.png',
      "/ListAllItemKGS", 5, "4dc309c9-4091-4032-c2a9-08da96fb114d"),
  MenuListItem('Hệ thống E-office', 'assets/icons/ic_pmis.png',
      "/ListAllItemEOffice", 5, "097cf497-b374-47ee-957f-08da97870319"),
  MenuListItem('Dịch vụ công', 'assets/icons/ic_pmis.png',
      "/ProfileProcMenuScreen", 5, "c7101788-690f-43df-d4dd-08da9ad94c09"),
  MenuListItem('Hệ thống báo cáo bộ GD&DT', 'assets/icons/ic_pmis.png',
      "/ReportInMenuHomeList", 5, "faabab32-2a15-490c-6aaf-08da9ad96ea2"),
  MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "/PMisScreen",
      5, "258fda3e-669a-4134-540c-08da9b7bdabe"),
  MenuListItem(
      'Báo cáo phân tích và hiển thị chỉ số',
      'assets/icons/ic_pmis.png',
      "/AnalysisReportMenu",
      5,
      "f277e743-cd4b-408b-5400-08da9b7bdabe"),
  MenuListItem('Tiệc ích', 'assets/icons/ic_pmis.png', "/UtilityScreen", 5,
      "84849e1f-e7fa-4654-540e-08da9b7bdabe"),
  MenuListItem('Helpdesk', 'assets/icons/ic_pmis.png', "/HelpDeskScreen", 5,
      "a12b42dd-b971-4e31-ac13-08da9bb8bee8"),
  //ksg
  MenuListItem('Văn bản đến chưa xử lý', 'assets/icons/ic_doc.png', "/DocumentUnProcessScreen", 3,
      "d548eb3f-7139-4184-0b77-08da99eba680"),
  MenuListItem('Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png', "/DocumentNonApprovedScreen",
      4, "a0c524ad-fb03-4842-0b7b-08da99eba680"),
  MenuListItem('Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "/DocumentOutList",
      5, "1a6233ce-d8f6-406e-f4c2-08da9ab327bc"),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "/BirthDayScreen", 9,
      "ce2cb981-1c0a-4ce8-f4c4-08da9ab327bc"),
  MenuListItem(
      'Hồ sơ thủ tục hành chính',
      'assets/icons/ic_thutuc_hanhchinh.png',
      "/ProfilesProcedureListWithStatistic",
      10,
      "fe6d274e-799a-4912-f4c1-08da9ab327bc"),
  //tien ich
  MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png',
      "/LunarCalendarScreen", 1, "1bd2d42f-f1d0-4251-6677-08da9bacfaac"),
  MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png',
      "/GuidelineList", 2, "12eb578a-d004-455a-540f-08da9b7bdabe"),
  MenuListItem('Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png',
      "/GroupContactsList", 3, "71362e11-9614-4276-ac11-08da9bb8bee8"),
  MenuListItem('Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png',
      "/IndividualContactsList", 4, "cb90574e-3568-468f-84ab-08da9f9ff797"),
  MenuListItem('Quản lý sổ tay công việc', 'assets/icons/ic_ql_sotay.png',
      "/WorkBookList", 5, "b2a7b093-b233-458f-ac14-08da9bb8bee8"),
  MenuListItem('Quản lý nhóm sổ tay CV', 'assets/icons/ic_ql_nhomcv.png',
      "/GroupWorkBookList", 6, "bad3efae-1cc6-40ca-8655-08da9d04724c"),
  //bao cao phan tich
  MenuListItem(
      'Phổ cập giáo dục',
      'assets/icons/ic_analy_report_1.png',
      "/AnalysisReportEducationScreen",
      1,
      "02ef7980-5e7f-45bf-5401-08da9b7bdabe"),
  MenuListItem('Giáo dục mầm non', 'assets/icons/ic_analy_report_3.png',
      "/ReportPreSchoolScreen", 2, "61e72fce-fc2f-485a-5403-08da9b7bdabe"),
  MenuListItem('Giáo dục tiểu học', 'assets/icons/ic_analy_report_4.png',
      "/ReportPrimarySchoolScreen", 3, "7b31bb6c-3553-4d3c-5404-08da9b7bdabe"),
  MenuListItem(
      'Giáo dục THCS',
      'assets/icons/ic_analy_report_5.png',
      "/ReportSecondarySchoolScreen",
      4,
      "bd3b9332-b615-4b98-5405-08da9b7bdabe"),
  MenuListItem('Giáo dục THPT', 'assets/icons/ic_analy_report_6.png',
      "/ReportHighSchoolScreen", 5, "a0e4cff7-e733-4097-5406-08da9b7bdabe"),
  MenuListItem(
      'Giáo dục khuyêt tật',
      'assets/icons/ic_analy_report_7.png',
      "/ReportDisabilityEducationScreen",
      6,
      "ede47203-5b92-4c3d-5407-08da9b7bdabe"),
  MenuListItem(
      'Giáo dục thường xuyên',
      'assets/icons/ic_analy_report_8.png',
      "/ReportContinuingEducationScreen",
      7,
      "e98f7b47-cf89-4cd5-5408-08da9b7bdabe"),
  MenuListItem(
      'Quản lý chất lượng GD',
      'assets/icons/ic_analy_report_9.png',
      "/ReportEducationQualityScreen",
      8,
      "aa750304-6bd4-45b4-5409-08da9b7bdabe"),
  MenuListItem(
      'Hỗ trợ đối tượng chính sách',
      'assets/icons/ic_analy_report_2.png',
      "/ReportBeneficiaryScreen",
      9,
      "fb7d8d16-a24d-4592-540a-08da9b7bdabe"),
  MenuListItem(
      'Báo cáo cơ sở vật chất',
      'assets/icons/ic_analy_report_10.png',
      "/ReportInfrastructureChatScreen",
      10,
      "5137f85b-3b4d-416d-540b-08da9b7bdabe"),
  //e office
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "/CalendarWorkEOfficeScreen", 1,
      "e001e3de-0cdf-4e9a-9580-08da97870319"),
  MenuListItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "/DocumentInEOfficeList", 2,
      "c58d8dd8-74d2-4abe-9581-08da97870319"),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "/ProfileEOfficeList", 3,
      "d49797df-e9b1-42ba-9582-08da97870319"),
  MenuListItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "/ProfileWorkEOfficeList", 4,
      "a0166eea-e9ed-468c-9583-08da97870319"),
  MenuListItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "/BookRoomEOfficeList", 5,
      "908e233d-013d-4351-9584-08da97870319"),
  MenuListItem('Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png',
      "/BookingEOfficeCarList", 6, "90e22b1b-a263-441b-9585-08da97870319"),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "/MissionEOfficeList", 7,
      "2451f554-c887-4874-9586-08da97870319"),
  //dich vu cong
  MenuListItem('Hồ sơ hành chính', 'assets/icons/ic_lunar_cal.png', "/ProfilesProcedureListWithStatistic", 1, "00628b59-be9a-4f0c-3bd5-08da9b727bd0"),
  MenuListItem('Thống kê hồ sơ', 'assets/icons/ic_hdsd.png', "/ProfileProcReportScreen", 2, "17e5dbb4-ef0d-497c-3bd6-08da9b727bd0"),
  //can permission
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_doc_push.png', "/DocumentOutList",
      5, "0b6ec0f7-67af-4873-f4c3-08da9ab327bc"),
];

class SearchMenuItem {
  String? title;
  String? url;
  String? id;

  SearchMenuItem({this.title, this.url, this.id});
}

List<SearchMenuItem> getListSearchMenu(HomeViewModel homeViewModel) {
  List<SearchMenuItem> listTitleMenu = [];
  List<MenuByUserModel> listMenu = homeViewModel.rxListMenuByUserRole;
  for (var element in listMenu) {
    SearchMenuItem searchMenuItem = SearchMenuItem(
        id: element.id, title: element.name, url: getNamedById(element.id!));
    listTitleMenu.add(searchMenuItem);
    for (var elementChildren in element.childrens!) {
      SearchMenuItem searchMenuItemChild = SearchMenuItem(
          id: elementChildren.id,
          title: elementChildren.name,
          url: getNamedById(elementChildren.id!));
      listTitleMenu.add(searchMenuItemChild);
    }
  }
  return listTitleMenu;
}

String getNamedById(String id) {
  var res = "";
  for (var element in listMenuSearch) {
    if (element.id == id) {
      res = element.url!;
    }
  }
  return res;
}
