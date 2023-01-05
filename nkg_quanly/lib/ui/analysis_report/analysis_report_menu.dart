import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/analysis_report/report_Infrastructure/report_infrastructure_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_beneficiary/report_beneficiary_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_continuingEducation/report_continuing_ducation_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_disability_education/report_disability_education_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_education_quality/report_education_quality_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_highschool/report_high_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_preschool/report_pre_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_primaryschool/report_primary_school_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/report_secondaryschool/report_secondary_school_screen.dart';
import 'package:nkg_quanly/ui/home/home_screen.dart';

import '../../const/const.dart';
import '../../const/utils.dart';
import '../../const/widget.dart';
import '../../model/MenuByUserModel.dart';
import 'analysis_report_education_screen.dart';

const typePreSchool = "preSchool";
const typePrimarySchool = "primarySchool";
const typeMiddleSchool = "middleSchool";
const typeHighSchool = "highSchool";

class AnalysisReportMenu extends StatelessWidget {
  const AnalysisReportMenu({Key? key, required this.listChildren})
      : super(key: key);
  final List<Childrens> listChildren;

  @override
  Widget build(BuildContext context) {
    listChildren.removeWhere((element) => element.id == "e8e57d75-1c6e-4798-5402-08da9b7bdabe" || element.id == "c04a436a-dc82-4772-7776-08daa2b4ddff" );
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          headerWidget("Phân tích hiển thị số", context),
          SizedBox(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 0.9,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(listChildren.length, (index) {
                return InkWell(
                  onTap: () {
                    toAnalysisReportScreen(listChildren[index].id!);
                  },
                  child: Column(
                    children: [
                      getIconScreenWidget(
                          listMenuAnalysisReport, listChildren[index], index),
                      Flexible(
                        child: Text(    ( listChildren[index].title?.isNotEmpty == true) ?
                        listChildren[index].title! : "",
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 3,overflow: TextOverflow.ellipsis,
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
  MenuListItem('Phổ cập giáo dục', 'assets/icons/ic_analy_report_1.png', "", 1,
      "02ef7980-5e7f-45bf-5401-08da9b7bdabe"),
  MenuListItem('Giáo dục mầm non', 'assets/icons/ic_analy_report_3.png', "", 2,
      "61e72fce-fc2f-485a-5403-08da9b7bdabe"),
  MenuListItem(
      'Giáo dục tiểu học', 'assets/icons/ic_analy_report_4.png', "", 3, "7b31bb6c-3553-4d3c-5404-08da9b7bdabe"),
  MenuListItem('Giáo dục THCS', 'assets/icons/ic_analy_report_5.png', "", 4,
      "bd3b9332-b615-4b98-5405-08da9b7bdabe"),
  MenuListItem(
      'Giáo dục THPT', 'assets/icons/ic_analy_report_6.png', "", 5, "a0e4cff7-e733-4097-5406-08da9b7bdabe"),
  MenuListItem('Giáo dục khuyêt tật', 'assets/icons/ic_analy_report_7.png', "",
      6, "ede47203-5b92-4c3d-5407-08da9b7bdabe"),
  MenuListItem('Giáo dục thường xuyên', 'assets/icons/ic_analy_report_8.png',
      "", 7, "e98f7b47-cf89-4cd5-5408-08da9b7bdabe"),
  MenuListItem('Quản lý chất lượng GD', 'assets/icons/ic_analy_report_9.png',
      "", 8, "aa750304-6bd4-45b4-5409-08da9b7bdabe"),
  MenuListItem(
      'Hỗ trợ đối tượng chính sách',
      'assets/icons/ic_analy_report_2.png',
      "",
      9,
      "fb7d8d16-a24d-4592-540a-08da9b7bdabe"),
  MenuListItem('Báo cáo cơ sở vật chất', 'assets/icons/ic_analy_report_10.png',
      "", 10, "5137f85b-3b4d-416d-540b-08da9b7bdabe"),
];

void toAnalysisReportScreen(String id) {
  var type = listMenuAnalysisReport
      .firstWhereOrNull((element) => element.id! == id)
      ?.type!;
  switch (type) {
    case 1:
      Get.to(() => AnalysisReportEducationScreen());
      break;

    case 2:
      Get.to(() => ReportPreSchoolScreen());
      break;
    case 3:
      Get.to(() => ReportPrimarySchoolScreen());
      break;
    case 4:
      Get.to(() => ReportSecondarySchoolScreen());
      break;
    case 5:
      Get.to(() => ReportHighSchoolScreen());
      break;
    case 6:
      Get.to(() => ReportDisabilityEducationScreen());
      break;
    case 7:
      Get.to(() => ReportContinuingEducationScreen());
      break;
    case 8:
      Get.to(() => ReportEducationQualityScreen());
      break;
    case 9:
      Get.to(() => ReportBeneficiaryScreen());
      break;
    case 10:
      Get.to(() => ReportInfrastructureChatScreen());
      break;
  }
}
