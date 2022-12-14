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
                                    hintText: 'Nh???p t??n ch???c n??ng',
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  onSubmitted: (value) {
                                    searchController.searchDataReport(value);
                                  },
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
  MenuListItem('Th??ng tin nh??n s???', 'assets/icons/ic_pmis.png', "/PMisScreen", 5),
  MenuListItem('Helpdesk', 'assets/icons/ic_helpdesk.png', "/HelpDeskScreen", 8),
  //kgs
  MenuListItem('B??o c??o', 'assets/icons/ic_report.png', "/ReportScreen", 9),
  MenuListItem(
      'V??n b???n ??i ch??? ph??t h??nh', 'assets/icons/ic_doc_push.png', "/DocumentOutList", 10),
  MenuListItem('H??? s?? tr??nh', 'assets/icons/ic_doc_doc.png', "/ProfileEOfficeList", 11),
  MenuListItem('Nhi???m v???', 'assets/icons/ic_mission.png', "/MissionEOfficeList", 12),
  MenuListItem('Sinh nh???t', 'assets/icons/ic_birthday.png', "/BirthDayScreen", 13),
  MenuListItem(
      'Th??? t???c h??nh ch??nh', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfilesProcedureListWithStatistic", 14),
  MenuListItem(
      'Th??ng k?? h??? s??', 'assets/icons/ic_thutuc_hanhchinh.png', "/ProfileProcReportScreen", 14),
  MenuListItem('S??? tay c??ng vi???c', 'assets/icons/ic_sotay.png', "/WorkBookList", 15),
  //e offile
  MenuListItem('L???ch l??m vi???c', 'assets/icons/ic_job.png', "/CalendarWorkScreen", 16),
  MenuListItem('V??n b???n ?????n', 'assets/icons/ic_doc_in.png', "/DocumentInEOfficeList", 17),
  MenuListItem('H??? s?? c??ng vi???c', 'assets/icons/ic_hoso_cv.png', "/ProfileWorkEOfficeList", 18),
  MenuListItem('B??? tr?? ph??ng h???p', 'assets/icons/ic_meeting.png', "/BookRoomEOfficeList", 19),
  MenuListItem(
      'B??? tr?? v?? ??i???u ?????ng xe ?? t??', 'assets/icons/ic_booking_car.png', "/BookingEOfficeCarList", 20),
  //report ana
  MenuListItem('Ph??? c???p gi??o d???c', 'assets/icons/ic_analy_report_1.png', "/AnalysisReportEducationScreen", 1),
  MenuListItem('Gi??o d???c m???m non', 'assets/icons/ic_analy_report_3.png', "/ReportPreSchoolScreen", 2),
  MenuListItem(
      'Gi??o d???c ti???u h???c', 'assets/icons/ic_analy_report_4.png', "/ReportPrimarySchoolScreen", 3),
  MenuListItem('Gi??o d???c THCS', 'assets/icons/ic_analy_report_5.png', "/ReportSecondarySchoolScreen", 4),
  MenuListItem('Gi??o d???c THPT', 'assets/icons/ic_analy_report_6.png', "/ReportHighSchoolScreen", 5),
  MenuListItem(
      'Gi??o d???c khuy??t t???t', 'assets/icons/ic_analy_report_7.png', "/ReportDisabilityEducationScreen", 6),
  MenuListItem(
      'Gi??o d???c th?????ng xuy??n', 'assets/icons/ic_analy_report_8.png', "/ReportContinuingEducationScreen", 7),
  MenuListItem(
      'Qu???n l?? ch???t l?????ng GD', 'assets/icons/ic_analy_report_9.png', "/ReportEducationQualityScreen", 8),
  MenuListItem('H??? tr??? ?????i t?????ng ch??nh s??ch',
      'assets/icons/ic_analy_report_2.png', "/ReportBeneficiaryScreen", 9),
  MenuListItem(
      'B??o c??o c?? s??? v???t ch???t', 'assets/icons/ic_analy_report_10.png', "/ReportInfrastructureChatScreen", 10),
  //tien ich
  MenuListItem('L???ch ??m', 'assets/icons/ic_lunar_cal.png', "/LunarCalendarScreen", 1),
  MenuListItem('H?????ng d???n s??? d???ng', 'assets/icons/ic_hdsd.png', "/GuidelineList", 2),
  MenuListItem(
      'Qu???n l?? DB??T t??? ch???c', 'assets/icons/ic_dbdt_tochuc.png', "/GroupContactsList", 3),
  MenuListItem(
      'Qu???n l?? DB??T c?? nh??n', 'assets/icons/ic_dbdt_canhan.png', "/IndividualContactsList", 4),
  MenuListItem(
      'Qu???n l?? nh??m S??? tay CV', 'assets/icons/ic_ql_nhomcv.png', "/GroupWorkBookList", 6),
];
