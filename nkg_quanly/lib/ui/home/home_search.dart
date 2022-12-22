import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../document_out/search_controller.dart';
import 'home_screen.dart';

class HomeSearch extends GetView {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.rxListSearchHome.value = listMenuHome;
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
                                    searchByKeywork(value, searchController);
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

void searchByKeywork(String keywork, SearchController searchController) {
  List<MenuListItem> listResult = [];
  listMenuHome.forEach((element) {
    if (element.title!.toLowerCase().contains(keywork.toLowerCase())) {
      listResult.add(element);
    }
  });
  searchController.rxListSearchHome.value = listResult;
}

List<MenuListItem> listMenuHome = [
  //menu
  MenuListItem('Thông tin nhân sự', 'assets/icons/ic_pmis.png', "/PMisScreen", 5,""),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "/HelpDeskScreen", 8,""),
  //kgs
  MenuListItem('Báo cáo', 'assets/icons/ic_report.png', "/ReportScreen", 9,""),
  MenuListItem(
      'Văn bản đi chờ phát hành', 'assets/icons/ic_doc_push.png', "/DocumentOutList", 10,""),
  MenuListItem('Hồ sơ trình', 'assets/icons/ic_doc_doc.png', "/ProfileEOfficeList", 11,""),
  MenuListItem('Nhiệm vụ', 'assets/icons/ic_mission.png', "/MissionEOfficeList", 12,""),
  MenuListItem('Sinh nhật', 'assets/icons/ic_birthday.png', "/BirthDayScreen", 13,""),
  MenuListItem(
      'Thủ tục hành chính', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfilesProcedureListWithStatistic", 14,""),
  MenuListItem(
      'Thông kê hồ sơ', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfileProcReportScreen", 14,""),
  MenuListItem('Sổ tay công việc', 'assets/icons/ic_sotay.png', "/WorkBookList", 15,""),
  //e offile
  MenuListItem('Lịch làm việc', 'assets/icons/ic_job.png', "/CalendarWorkScreen", 16,""),
  MenuListItem('Văn bản đến', 'assets/icons/ic_doc_in.png', "/DocumentInEOfficeList", 17,""),
  MenuListItem('Hồ sơ công việc', 'assets/icons/ic_hoso_cv.png', "/ProfileWorkEOfficeList", 18,""),
  MenuListItem('Bố trí phòng họp', 'assets/icons/ic_meeting.png', "/BookRoomEOfficeList", 19,""),
  MenuListItem(
      'Bố trí và điều động xe ô tô', 'assets/icons/ic_booking_car.png', "/BookingEOfficeCarList", 20,""),
  //report ana
  MenuListItem('Phổ cập giáo dục', 'assets/icons/ic_analy_report_1.png', "/AnalysisReportEducationScreen", 1,""),
  MenuListItem('Giáo dục mầm non', 'assets/icons/ic_analy_report_3.png', "/ReportPreSchoolScreen", 2,""),
  MenuListItem(
      'Giáo dục tiểu học', 'assets/icons/ic_analy_report_4.png', "/ReportPrimarySchoolScreen", 3,""),
  MenuListItem('Giáo dục THCS', 'assets/icons/ic_analy_report_5.png', "/ReportSecondarySchoolScreen", 4,""),
  MenuListItem('Giáo dục THPT', 'assets/icons/ic_analy_report_6.png', "/ReportHighSchoolScreen", 5,""),
  MenuListItem(
      'Giáo dục khuyêt tật', 'assets/icons/ic_analy_report_7.png', "/ReportDisabilityEducationScreen", 6,""),
  MenuListItem(
      'Giáo dục thường xuyên', 'assets/icons/ic_analy_report_8.png', "/ReportContinuingEducationScreen", 7,""),
  MenuListItem(
      'Quản lý chất lượng GD', 'assets/icons/ic_analy_report_9.png', "/ReportEducationQualityScreen", 8,""),
  MenuListItem('Hỗ trợ đối tượng chính sách',
      'assets/icons/ic_analy_report_2.png', "/ReportBeneficiaryScreen", 9,""),
  MenuListItem(
      'Báo cáo cơ sở vật chất', 'assets/icons/ic_analy_report_10.png', "/ReportInfrastructureChatScreen", 10,""),
  //tien ich
  MenuListItem('Lịch âm', 'assets/icons/ic_lunar_cal.png', "/LunarCalendarScreen", 1,""),
  MenuListItem('Hướng dẫn sử dụng', 'assets/icons/ic_hdsd.png', "/GuidelineList", 2,""),
  MenuListItem(
      'Quản lý DBĐT tổ chức', 'assets/icons/ic_dbdt_tochuc.png', "/GroupContactsList", 3,""),
  MenuListItem(
      'Quản lý DBĐT cá nhân', 'assets/icons/ic_dbdt_canhan.png', "/IndividualContactsList", 4,""),
  MenuListItem(
      'Quản lý nhóm Sổ tay CV', 'assets/icons/ic_ql_nhomcv.png', "/GroupWorkBookList", 6,""),
];
