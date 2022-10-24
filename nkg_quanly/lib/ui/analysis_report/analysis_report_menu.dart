import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/analysis_report/report_cosovatchat/analysis_report_cosovatchat_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_doi_tuong_chinh_sach/analysis_report_dtcs_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_education_quality/report_education_quality_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_gd_khuyet_tat/report_giaoduckhuyettat_screen.dart';
import 'package:nkg_quanly/ui/home/home_screen.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import 'analysis_report_education_screen.dart';
import 'analysis_report_type_screen.dart';
import 'giao_duc_thuong_xuyen/report_giaoducthuongxuyen_screen.dart';

const typePreSchool = "preSchool";
const typePrimarySchool = "primarySchool";
const typeMiddleSchool = "middleSchool";
const typeHighSchool = "highSchool";

class AnalysisReportMenu extends StatelessWidget {
  const AnalysisReportMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerWidget("Phân tích hiển thị số", context),
          SizedBox(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(listMenuAnalysisReport.length, (index) {
                return InkWell(
                  onTap: () {
                    toAnalysisReportScreen(
                        listMenuAnalysisReport[index].type!,
                        listMenuAnalysisReport[index].title,
                        listMenuAnalysisReport[index].img);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        listMenuAnalysisReport[index].img!,
                        width: 50,
                        height: 50,
                      ),
                      Flexible(
                        child: Text(
                          listMenuAnalysisReport[index].title!,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      )),
    );
  }
}

List<MenuListItem> listMenuAnalysisReport = [
  MenuListItem('Phổ cập giáo dục', 'assets/icons/ic_analy_report_1.png', "", 1),
  MenuListItem('Giáo dục mầm non', 'assets/icons/ic_analy_report_3.png', "", 2),
  MenuListItem(
      'Giáo dục tiểu học', 'assets/icons/ic_analy_report_4.png', "", 3),
  MenuListItem('Giáo dục THCS', 'assets/icons/ic_analy_report_5.png', "", 4),
  MenuListItem('Giáo dục THPT', 'assets/icons/ic_analy_report_6.png', "", 5),
  MenuListItem(
      'Giáo dục khuyêt tật', 'assets/icons/ic_analy_report_7.png', "", 6),
  MenuListItem(
      'Giáo dục thường xuyên', 'assets/icons/ic_analy_report_8.png', "", 7),
  MenuListItem(
      'Quản lý chất lượng GD', 'assets/icons/ic_analy_report_9.png', "", 8),
  MenuListItem(
      'Hỗ trợ đối tượng chính sách', 'assets/icons/ic_analy_report_2.png', "", 9),
  MenuListItem(
      'Báo cáo cơ sở vật chất', 'assets/icons/ic_analy_report_10.png', "", 10),
];

void toAnalysisReportScreen(int type, String? header, String? icon) {
  switch (type) {
    case 1:
      Get.to(() => AnalysisReportEducationScreen());
      break;
    case 2:
      Get.to(() => AnalysisReportDTCSMenu());
      break;
    case 3:
      Get.to(() => AnalysisReportTypeMenu("Giáo dục mầm non", typePreSchool));
      break;
    case 4:
      Get.to(
          () => AnalysisReportTypeMenu("Giáo dục Tiểu học", typePrimarySchool));
      break;
    case 5:
      Get.to(() => AnalysisReportTypeMenu(
          "Giáo dục cấp trung học cơ sở", typeMiddleSchool));
      break;
    case 6:
      Get.to(() => AnalysisReportTypeMenu(
          "Giáo dục cấp trung học phổ thông", typeHighSchool));
      break;
    case 7:
      Get.to(
          () => ReportGiaoDucKhuyetTatScreen());
      break;
    case 8:
      Get.to(() =>
          ReportGiaoDucThuongXuyenScreen());
      break;
    case 9:
      Get.to(() =>
          ReportEducationQualityScreen());
      break;
    case 10:
      Get.to(() =>
          AnalysisReportCoSoVatChatMenu());
      break;
  }
}
