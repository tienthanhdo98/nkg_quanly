import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_filter_screen.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_type_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../analysis_collum_chart2.dart';
import '../analysis_pie_chart2.dart';
import '../analysis_report_viewmodel.dart';

class ReportEducationQualityScreen extends GetView {
  ReportEducationQualityScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());
  String? filterType = "";

  @override
  Widget build(BuildContext context) {
    filterType = listReportEduQualityType[0];
    analysisReportViewModel.getDataPreSchoolScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget("Quản lý chất lượng giáo dục", context),
              Padding(
                padding: const EdgeInsets.all(15),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Chọn loại báo cáo:",
                    style: CustomTextStyle.grayColorTextStyle,
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: kDarkGray,
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                      child: StatefulBuilder(
                        builder: (context, setState) =>
                            Row(
                              children: [
                                DropdownButton(
                                  icon: Image.asset(
                                    'assets/icons/ic_arrow_down.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                  value: (filterType?.isNotEmpty == true)
                                      ? filterType
                                      : null,
                                  underline: const SizedBox.shrink(),
                                  items: listReportEduQualityType
                                      .map((value) =>
                                      DropdownMenuItem(
                                        child: SizedBox(
                                            width:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.85,
                                            child: Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(
                                                    10, 5, 10, 5),
                                                child: Text(value.trim()))),
                                        value: value.trim(),
                                      ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterType = value.toString();
                                      listReportEduQualityType
                                          .asMap()
                                          .forEach((index, itemValue) {
                                        if (itemValue == value) {
                                          analysisReportViewModel
                                              .changeValuefilterType(
                                              filterType!);
                                          analysisReportViewModel.rxTypeScreen
                                              .value =
                                              index;
                                          analysisReportViewModel.scrollToTop();
                                        }
                                      });
                                    });
                                  },
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline4,
                                  isExpanded: false,
                                ),
                              ],
                            ),
                      )),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: kDarkGray, style: BorderStyle.solid, width: 1),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          children: [
                            Obx(() =>
                                Expanded(
                                    child: Text(
                                      "Thống kê ${analysisReportViewModel
                                          .rxSelectedSemester}",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline2,
                                    ))),
                            Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: elevetedButtonWhite,
                                  onPressed: () {
                                    if (analysisReportViewModel
                                        .rxTypeScreen.value ==
                                        0) {
                                      Get.to(() =>
                                          AnalysisReportEducationQualityFilterScreen(
                                              analysisReportViewModel));
                                    } else if (analysisReportViewModel
                                        .rxTypeScreen.value ==
                                        1) {
                                      Get.to(() =>
                                          ReportDetailEduQualityFilterScreen(
                                              analysisReportViewModel));
                                    } else if (analysisReportViewModel
                                        .rxTypeScreen.value ==
                                        2) {
                                      Get.to(() =>
                                          XepLoaiNangLucPhamChatFilterScreen(
                                              analysisReportViewModel));
                                    } else {
                                      Get.to(() =>
                                          KhenThuongFilterScreen(
                                              analysisReportViewModel));
                                    }
                                  },
                                  child: const Text(
                                    'Bộ lọc',
                                    style: TextStyle(color: kVioletButton),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Obx(() => resultBox(analysisReportViewModel, context)),
                    ]),
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                  color: kDarkGray,
                  child: SingleChildScrollView(
                    controller: analysisReportViewModel.controller,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Obx(() =>
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: checkListChart(
                                  analysisReportViewModel.rxfilterType.value)
                                  .length,
                              itemBuilder: (context, index) {
                                var item = checkListChart(
                                    analysisReportViewModel.rxfilterType
                                        .value)[index];
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 0, 15),
                                  child: borderItem(
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            15, 15, 15, 15),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.name!,
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline1,
                                                ),
                                              ),
                                              const Padding(
                                                  padding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0)),
                                              InkWell(
                                                onTap: () {},
                                                child: Image.asset(
                                                    "assets/icons/ic_refresh.png",
                                                    width: 16,
                                                    height: 16),
                                              )
                                            ],
                                          ),
                                          (item.type == "1")
                                              ? AnalysisChart2Widget(
                                            key: UniqueKey(),
                                          )
                                              : AnalysisChartCollum2Widget(
                                            key: UniqueKey(),
                                          )
                                        ]),
                                      ),
                                      context),
                                );
                              })),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  List<chart> checkListChart(String? filterName) {
    List<chart> listScreen = [];
    // man non
    if (filterType == listReportEduQualityType[0]) {
      listScreen = monhoc;
    } else if (filterType == listReportEduQualityType[1]) {
      listScreen = chatluonggd;

    } else if (filterType == listReportEduQualityType[2]) {
      listScreen = phamchat;

    } else if (filterType == listReportEduQualityType[3]) {
      listScreen = khenthuong;

    }
    return listScreen;
  }
}

Widget resultBox(AnalysisReportViewModel analysisReportViewModel,
    BuildContext context) {
  if (analysisReportViewModel.rxTypeScreen.value == 0) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SizedBox(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolLevel.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khối lớp',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedClass.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Môn học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSubject.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vùng', style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedRegion.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedProvince.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolYear.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
          ],
        ),
      ),
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 1) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SizedBox(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolLevel.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khu vực',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedRegion.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedProvince.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolYear.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
          ],
        ),
      ),
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SizedBox(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khu vực',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedRegion.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedProvince.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolLevel.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
          ],
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: SizedBox(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khu vực',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedRegion.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedProvince.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolYear.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() =>
                        Text(
                            analysisReportViewModel.rxSelectedSchoolLevel.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

var listReportEduQualityType = [
  "Báo cáo chi tiết chất lượng giáo dục qua môn học",
  "Báo cáo chi tiết chất lượng giáo dục",
  "Báo cáo chi tiết xếp loại năng lực, phẩm chất",
  "Báo cáo chi tiết khen thưởng học sinh",
];
var listClassification = ["Giỏi", "Khá", "Trung bình", "Yếu"];

// var listSubject = ["Toán","Lý","Hóa","Anh","Sử","Địa","Văn","Sinh","Giáo dục công dân"];
// var listPriSchool = ["Lớp 1","Lớp 2","Lớp 3","Lớp 4","Lớp 5",];
// var listMidSchool = ["Lớp 6","Lớp 7","Lớp 8","Lớp 9",];
// var listHighSchool = ["Lớp 10","Lớp 11","Lớp 12"];
// var listAllClass = ["Lớp 1","Lớp 2","Lớp 3","Lớp 4","Lớp 5","Lớp 6","Lớp 7","Lớp 8","Lớp 9","Lớp 10","Lớp 11","Lớp 12"];

var monhoc = [
  chart("Xếp hạng năng lực theo tỉnh/TP", "2"),
  chart("Xếp hạng năng lực theo vùng", "2"),
  chart("Xếp loại học sinh", "2"),
  chart("Xếp loại học sinh theo năm học", "2"),
  chart("Phổ điểm của học sinh", "2"),
  chart("Phổ điểm của học sinh theo năm học", "2"),
];
var chatluonggd = [
  chart("Cơ cấu học sinh hoàn thành chương trình học", "1"),
  chart("Xếp hạng tỷ lệ học sinh hoàn thành chương trình theo vùng", "1"),
  chart("Xếp hạng tỷ lệ học sinh hoàn thành chương trình theo tỉnh/TP", "2"),
];
var phamchat = [
  chart("Xếp loại năng lực học sinh theo vùng", "2"),
  chart("So sánh năng lực học sinh theo kỳ", "2"),
  chart("Xếp loại năng lực học sinh theo tỉnh, thành phố", "2"),
  chart("So sánh năng lực học sinh theo năm", "2"),
  chart("Xếp loại phẩm chất học sinh theo vùng", "2"),
  chart("So sánh phẩm chất học sinh theo kỳ", "2"),
  chart("Xếp loại phẩm chất học sinh theo tỉnh, thành phố", "2"),
  chart("So sánh phẩm chất học sinh theo năm", "2"),
];
var khenthuong = [
  chart("Thống kê tỷ lệ HS được khen thưởng theo năm", "2"),
  chart("Thống kê tỷ lệ HS được khen thưởng theo học kỳ", "2"),
  chart("Xếp hạng tỉnh/TP theo tỷ lệ HS được khen thưởng, TP", "2"),
  chart("Tỷ lệ học sinh theo khen thưởng", "1"),
];
