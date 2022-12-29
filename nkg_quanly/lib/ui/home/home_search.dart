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

  @override
  Widget build(BuildContext context) {
    var listMenu = getListMenuSearch(homeController);
    searchController.rxListSearchHome.value = listMenu;
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
                                    searchByKeywork(value, searchController,listMenu);
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
                height: double.infinity,
                child: SizedBox(
                  height: 200,
                  child: Obx(() => ListView.builder(
                      itemCount: searchController.rxListSearchHome.length,
                      itemBuilder: (context, index) {
                        var item = searchController.rxListSearchHome[index];
                        return InkWell(
                          onTap: () {
                           // Get.toNamed(item.url!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(item,
                                style: const TextStyle(
                                    color: kBlueButton,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto')),
                          ),
                        );
                      })),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void searchByKeywork(String keywork, SearchController searchController,List<String> listMenu) {
  List<String> listResult = [];
  listMenu.forEach((element) {
    if (element.toLowerCase().contains(keywork.toLowerCase())) {
      listResult.add(element);
    }
  });
  searchController.rxListSearchHome.value = listResult;
}

List<String> getListMenuSearch(HomeViewModel homeViewModel)
{
  List<String> listTitleMenu = [];
  List<MenuByUserModel> listMenu = homeViewModel.rxListMenuByUser;
  for (var element in listMenu) {
    listTitleMenu.add(element.name!);
    for (var elementChildren in element.childrens!) {
      listTitleMenu.add(elementChildren.name!);
    }}
  print(listTitleMenu);
  return listTitleMenu;
}

List<MenuListItem> listMenuHome = [
  MenuListItem('Không gian số', 'assets/icons/ic_kgs.png', "", 1,"4dc309c9-4091-4032-c2a9-08da96fb114d"),
  MenuListItem('Hệ thống E-office', 'assets/icons/ic_eoffice.png', "", 2,"097cf497-b374-47ee-957f-08da97870319"),
  MenuListItem('Dịch vụ công', 'assets/icons/ic_dichvucong.png', "", 5,"c7101788-690f-43df-d4dd-08da9ad94c09"),
  MenuListItem('Báo cáo bộ', 'assets/icons/ic_report_bo.png', "", 7,"faabab32-2a15-490c-6aaf-08da9ad96ea2"),
  MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "", 3,"258fda3e-669a-4134-540c-08da9b7bdabe"),
  MenuListItem('Phân tích hiển thị chỉ số', 'assets/icons/ic_phantich.png', "", 6,"f277e743-cd4b-408b-5400-08da9b7bdabe"),
  MenuListItem('Tiện ích', 'assets/icons/ic_tienich.png', "", 8,"84849e1f-e7fa-4654-540e-08da9b7bdabe"),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "", 4,"a12b42dd-b971-4e31-ac13-08da9bb8bee8"),
  //
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "", 1, "41b72d4a-c3ff-4522-537b-08da949256b0"),
  MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "", 2, "ddc1a609-99c6-47e1-0b81-08da99eba680"),
  MenuListItem('Văn bản đến chưa xử lý', 'assets/icons/ic_doc.png', "", 3, "d548eb3f-7139-4184-0b77-08da99eba680"),
  MenuListItem(
      'Văn bản đến chưa bút phê', 'assets/icons/ic_doc_sign.png', "", 4, "a0c524ad-fb03-4842-0b7b-08da99eba680"),
  MenuListItem(
      'Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "", 5, "4a09555d-65fb-45b9-0b78-08da99eba680"),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "", 6, "8c3c7c86-1553-466a-0b7a-08da99eba680"),
  MenuListItem('Phòng họp', 'assets/icons/ic_meet.png', "", 7, "de5a2a3c-c0d9-4517-0b79-08da99eba680"),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "", 8, "09ede2a1-e81e-4f9c-0b7c-08da99eba680"),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "", 9, "beb9bd3b-cde3-43b8-0b7e-08da99eba680"),
  MenuListItem('Hồ sơ thủ tục hành chính',
      'assets/icons/ic_thutuc_hanhchinh.png', "", 10, "d845ea9d-cd97-4c02-0b7f-08da99eba680"),
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "", 11, ""),
  //
  MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png', "", 1, "1bd2d42f-f1d0-4251-6677-08da9bacfaac"),
  MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png', "", 2,"12eb578a-d004-455a-540f-08da9b7bdabe"),
  MenuListItem(
      'Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png', "", 3,"71362e11-9614-4276-ac11-08da9bb8bee8"),
  MenuListItem(
      'Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png', "", 4,
      "cb90574e-3568-468f-84ab-08da9f9ff797"),
  MenuListItem(
      'Quản lý sổ tay công việc', 'assets/icons/ic_ql_sotay.png', "", 5,"b2a7b093-b233-458f-ac14-08da9bb8bee8"),
  MenuListItem(
      'Quản lý nhóm sổ tay CV', 'assets/icons/ic_ql_nhomcv.png', "", 6,"bad3efae-1cc6-40ca-8655-08da9d04724c"),
];
// List<MenuListItem> listMenuHome = [
//   //menu
//   MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "/PMisScreen", 5,""),
//   MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "/HelpDeskScreen", 8,""),
//   //kgs
//   MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "/ReportScreen", 9,""),
//   MenuListItem(
//       'Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "/DocumentOutList", 10,""),
//   MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "/ProfileEOfficeList", 11,""),
//   MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "/MissionEOfficeList", 12,""),
//   MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "/BirthDayScreen", 13,""),
//   MenuListItem(
//       'Thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfilesProcedureListWithStatistic", 14,""),
//   MenuListItem(
//       'Thông kê hồ sơ', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfileProcReportScreen", 14,""),
//   MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "/WorkBookList", 15,""),
//   //e offile
//   MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "/CalendarWorkScreen", 16,""),
//   MenuListItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "/DocumentInEOfficeList", 17,""),
//   MenuListItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "/ProfileWorkEOfficeList", 18,""),
//   MenuListItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "/BookRoomEOfficeList", 19,""),
//   MenuListItem(
//       'Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png', "/BookingEOfficeCarList", 20,""),
//   //report ana
//   MenuListItem('Phổ cập giáo dục', 'assets/icons/ic_analy_report_1.png', "/AnalysisReportEducationScreen", 1,""),
//   MenuListItem('Giáo dục mầm non', 'assets/icons/ic_analy_report_3.png', "/ReportPreSchoolScreen", 2,""),
//   MenuListItem(
//       'Giáo dục tiểu học', 'assets/icons/ic_analy_report_4.png', "/ReportPrimarySchoolScreen", 3,""),
//   MenuListItem('Giáo dục THCS', 'assets/icons/ic_analy_report_5.png', "/ReportSecondarySchoolScreen", 4,""),
//   MenuListItem('Giáo dục THPT', 'assets/icons/ic_analy_report_6.png', "/ReportHighSchoolScreen", 5,""),
//   MenuListItem(
//       'Giáo dục khuyêt tật', 'assets/icons/ic_analy_report_7.png', "/ReportDisabilityEducationScreen", 6,""),
//   MenuListItem(
//       'Giáo dục thường xuyên', 'assets/icons/ic_analy_report_8.png', "/ReportContinuingEducationScreen", 7,""),
//   MenuListItem(
//       'Quản lý chất lượng GD', 'assets/icons/ic_analy_report_9.png', "/ReportEducationQualityScreen", 8,""),
//   MenuListItem('Hỗ trợ đối tượng chính sách',
//       'assets/icons/ic_analy_report_2.png', "/ReportBeneficiaryScreen", 9,""),
//   MenuListItem(
//       'Báo cáo cơ sở vật chất', 'assets/icons/ic_analy_report_10.png', "/ReportInfrastructureChatScreen", 10,""),
//   //tien ich
//   MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png', "/LunarCalendarScreen", 1,""),
//   MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png', "/GuidelineList", 2,""),
//   MenuListItem(
//       'Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png', "/GroupContactsList", 3,""),
//   MenuListItem(
//       'Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png', "/IndividualContactsList", 4,""),
//   MenuListItem(
//       'Quản lý nhóm Sổ tay CV', 'assets/icons/ic_ql_nhomcv.png', "/GroupWorkBookList", 6,""),
// ];
