import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_filter_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';
import '../../theme/theme_data.dart';
import '../analysis_report_viewmodel.dart';
import '../chart/analysis_collum_chart.dart';
import '../chart/analysis_double_value_collum_chart.dart';
import '../chart/analysis_penta_value_collum_chart.dart';
import '../chart/analysis_pie_chart.dart';
import '../chart/analysis_quadra_value_collum_chart.dart';
import '../report_highschool/report_high_school_screen.dart';

class ReportEducationQualityScreen extends GetView {
  ReportEducationQualityScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());
  String? filterType = "";

  @override
  Widget build(BuildContext context) {
    filterType = listReportEduQualityType[0];
    analysisReportViewModel.getDataQualityEducation();
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
                        color: kDarkGray, style: BorderStyle.solid, width: 1),
                  ),
                  child: StatefulBuilder(
                    builder: (context, setState) => Row(
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
                              .map((value) => DropdownMenuItem(
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                                      .changeValuefilterType(filterType!);
                                  analysisReportViewModel.rxTypeScreen.value =
                                      index;
                                  analysisReportViewModel.clearSelectedFilter();
                                  if (index == 0) {
                                    analysisReportViewModel
                                        .getListQualityEducationByType("0");
                                  } else if (index == 1) {
                                    analysisReportViewModel
                                        .getListQualityEducationByType("1");
                                  } else if (index == 2) {
                                    analysisReportViewModel
                                        .getListQualityEducationByType("2");
                                  } else if (index == 3) {
                                    analysisReportViewModel
                                        .getListQualityEducationByType("3");
                                  }
                                  analysisReportViewModel
                                      .changeStateLoadingData(true);
                                  analysisReportViewModel.scrollToTop();
                                }
                              });
                            });
                          },
                          style: Theme.of(context).textTheme.headline4,
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
                        Obx(() => Expanded(
                                child: Text(
                              "Thống kê ${analysisReportViewModel.rxSelectedSemester}",
                              style: Theme.of(context).textTheme.headline2,
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
                                  Get.to(() => KhenThuongFilterScreen(
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
                        (analysisReportViewModel.isLoadingData.value == false)
                            ? Column(
                                children: [
                                  Obx(() => listChartQualityEduScreen(
                                      analysisReportViewModel, context))
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                ],
                              ))),
              ),
            ),
          )
        ],
      )),
    );
  }
}

Widget resultBox(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
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
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolLevel.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khối lớp',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedClass.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Môn học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSubject.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vùng', style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedRegion.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedProvince.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolYear.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
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
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolLevel.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Khu vực',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedRegion.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedProvince.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolYear.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
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
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedRegion.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedProvince.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolLevel.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
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
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedRegion.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh, TP',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedProvince.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Năm học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolYear.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cấp học',
                    style: CustomTextStyle.grayColorTextStyle),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Obx(() => Text(
                        analysisReportViewModel.rxSelectedSchoolLevel.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5)))
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

Widget chartQualityEduWidget(String chartName, List<ChartChildItems>? items,
    BuildContext context, String type) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
    child: borderItem(
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    chartName,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                InkWell(
                  onTap: () {},
                  child: Image.asset("assets/icons/ic_refresh.png",
                      width: 16, height: 16),
                )
              ],
            ),
            getChartByType(items, type)
          ]),
        ),
        context),
  );
}

Widget getChartByType(List<ChartChildItems>? items, String type) {
  if (type == "1") {
    return AnalysisPieChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  } else if (type == "2") {
    return AnalysisCollumChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  } else if (type == "3") {
    return AnalysisDoubleValueCollumChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  } else if (type == "4") {
    return AnalysisQuadraValueCollumChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  } else {
    return AnalysisPentaValueCollumChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  }
}

Widget listChartQualityEduScreen(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  Widget? resWidget;
  var listChart = analysisReportViewModel.rxListChartAnalysis;
  if (analysisReportViewModel.rxTypeScreen.value == 0) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartQualityEduWidget("Xếp hạng năng lực theo tỉnh/TP",
            listChart[1].items!, context, "2"),
        chartQualityEduWidget(
            "Xếp hạng năng lực theo vùng", listChart[0].items!, context, "2"),
        chartQualityEduWidget(
            "Xếp loại học sinh", listChart[2].items!, context, "2"),
        chartQualityEduWidget(
            "Phổ điểm của học sinh", listChart[3].items!, context, "2"),
        chartQualityEduWidget("Xếp loại học sinh theo năm học",
            listChart[4].items!, context, "3"),
        chartQualityEduWidget("Phổ điểm của học sinh theo năm học",
            listChart[5].items!, context, "4"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 1) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartQualityEduWidget("Cơ cấu học sinh hoàn thành chương trình học",
            listChart[2].items!, context, "1"),
        chartQualityEduWidget(
            "Xếp hạng tỷ lệ học sinh hoàn thành chương trình theo vùng",
            listChart[1].items!,
            context,
            "1"),
        chartQualityEduWidget(
            "Xếp hạng tỷ lệ học sinh hoàn thành chương trình theo tỉnh/TP",
            listChart[0].items!,
            context,
            "2"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartQualityEduWidget("Xếp loại năng lực học sinh theo vùng",
            listChart[0].items!, context, "2"),
        chartQualityEduWidget("So sánh năng lực học sinh theo kỳ",
            listChart[1].items!, context, "2"),
        chartQualityEduWidget("Xếp loại năng lực học sinh theo tỉnh, thành phố",
            listChart[4].items!, context, "4"),
        chartQualityEduWidget("So sánh năng lực học sinh theo năm",
            listChart[5].items!, context, "4"),
        chartQualityEduWidget('Xếp loại phẩm chất học sinh theo vùng',
            listChart[2].items!, context, "2"),
        chartQualityEduWidget('So sánh phẩm chất học sinh theo kỳ',
            listChart[1].items!, context, "2"),
        chartQualityEduWidget(
            'Xếp loại phẩm chất học sinh theo tỉnh, thành phố',
            listChart[6].items,
            context,
            "5"),
        chartQualityEduWidget("So sánh phẩm chất học sinh theo năm",
            listChart[7].items!, context, "5"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 3) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartQualityEduWidget("Thống kê tỷ lệ HS được khen thưởng theo năm",
            listChart[6].items!, context, "2"),
        chartQualityEduWidget('Xếp hạng tỉnh/TP theo tỷ lệ HS được khen thưởng',
            listChart[2].items!, context, "2"),
        chartQualityEduWidget("Xếp hạng vùng theo tỷ lệ HS khen thưởng",
            listChart[1].items!, context, "2"),
        chartQualityEduWidget('Thống kê tỷ lệ HS được khen thưởng theo học kỳ',
            listChart[7].items!, context, "2"),
        chartQualityEduWidget("Thống kê tỷ lệ học sinh theo khen thưởng",
            listChart[2].items!, context, "1"),
      ],
    );
  }

  return resWidget!;
}

// String chartNameToNameQualityEdu (String chartName) {
//   var name = "";
//   switch (chartName) {
//     case "XepHangThanhPho":
//       {
//         name = "Xếp hạng năng lực theo tỉnh/TP";
//       }
//       break;
//     case "XepHangVung":
//       {
//         name = "Xếp hạng năng lực theo vùng";
//       }
//       break;
//     case "BieuDoXepLoaiHocSinh":
//       {
//         name = "Xếp loại học sinh";
//       }
//       break;
//     case "BieuDoPhoDiemCuaHocSinh":
//       {
//         name = "Phổ điểm của học sinh";
//       }
//       break;
//     case "BieuDoXepLoaiHocSinh":
//       {
//         name = "Xếp loại học sinh theo năm học";
//       }
//       break;
//     case "BieuDoPhoDiemCuaHocSinh":
//       {
//         name = "Phổ điểm của học sinh theo năm học";
//       }
//       break;
//
//   }
//   return name;
// }
