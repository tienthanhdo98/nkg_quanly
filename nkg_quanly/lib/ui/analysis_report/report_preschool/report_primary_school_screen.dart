import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../../model/analysis_report/preschool_chart_model.dart';
import '../../theme/theme_data.dart';
import '../analysis_report_filter_screen.dart';
import '../analysis_report_viewmodel.dart';
import '../chart/analysis_collum_chart.dart';
import '../chart/analysis_pie_chart.dart';

class ReportPrimarySchoolScreen extends GetView {
  ReportPrimarySchoolScreen({Key? key}) : super(key: key);
  String? filterType = "";
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    filterType = listReportPriSchoolType[0];
    analysisReportViewModel.getDataPrimarySchool();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Giáo dục tiểu học", context),
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
                        items: listReportPriSchoolType
                            .map((value) => DropdownMenuItem(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                            listReportPriSchoolType
                                .asMap()
                                .forEach((index, itemValue) {
                              if (itemValue == value) {
                                analysisReportViewModel
                                    .changeValuefilterType(filterType!);
                                analysisReportViewModel.rxTypeScreen.value =
                                    index;
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
                ),
              ),
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
                                Get.to(() => AnalysisReportFilterScreen(
                                      analysisReportViewModel:
                                          analysisReportViewModel,
                                      onClick: () {},
                                    ));
                              },
                              child: const Text(
                                'Bộ lọc',
                                style: TextStyle(color: kVioletButton),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: SizedBox(
                      height: 60,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Khu vực',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(
                                      analysisReportViewModel
                                          .rxSelectedRegion.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(
                                      analysisReportViewModel
                                          .rxSelectedProvince.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(
                                      analysisReportViewModel
                                          .rxSelectedSchoolYear.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  child: Obx(() => (analysisReportViewModel
                      .isLoadingData.value ==
                      false) ?Column(
                    children: [
                      Obx(() => countReportTypeScreen(
                          analysisReportViewModel, context)),
                      Obx(() =>
                          listChartScreen(analysisReportViewModel, context))
                    ],
                  ) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(child: CircularProgressIndicator()),
                    )],) )
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

Widget listChartScreen(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  Widget? resWidget;
  var listChart = analysisReportViewModel.rxListChartAnalysis;
  if (analysisReportViewModel.rxTypeScreen.value == 0) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartWidget(listChart[0].chartName!, listChart[0].items!, context, "1"),
        chartWidget(listChart[1].chartName!, listChart[1].items!, context, "1"),
        chartWidget(listChart[2].chartName!, listChart[2].items!, context, "1"),
        chartWidget(
            listChart[16].chartName!, listChart[16].items!, context, "2"),
        chartWidget(
            listChart[18].chartName!, listChart[18].items!, context, "2"),
        chartWidget(
            listChart[17].chartName!, listChart[17].items!, context, "2"),
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "1"),
        chartWidget(listChart[5].chartName!, listChart[5].items!, context, "2"),
        chartWidget(listChart[6].chartName!, listChart[6].items!, context, "2"),
        chartWidget(listChart[7].chartName!, listChart[7].items!, context, "2"),
        chartWidget(listChart[8].chartName!, listChart[8].items!, context, "2"),
        chartWidget(listChart[9].chartName!, listChart[9].items!, context, "2"),
        chartWidget(
            listChart[10].chartName!, listChart[10].items!, context, "2"),
        chartWidget(
            listChart[11].chartName!, listChart[11].items!, context, "2"),
        chartWidget(
            listChart[12].chartName!, listChart[12].items!, context, "2"),
        chartWidget(
            listChart[13].chartName!, listChart[13].items!, context, "2"),
        chartWidget(
            listChart[14].chartName!, listChart[14].items!, context, "2"),
        chartWidget(
            listChart[15].chartName!, listChart[15].items!, context, "2"),
      ],
    );
  }

  return resWidget!;
}

Widget chartWidget(String chartName, List<ChartChildItems> items,
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
                    checkingStringNull(chartNameToNamePrimaSchool(chartName)),
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
            (type == "1")
                ? AnalysisPieChartWidget(
                    key: UniqueKey(),
                    listChart: items,
                  )
                : AnalysisCollumChartWidget(
                    key: UniqueKey(),
                    listChart: items,
                  )
          ]),
        ),
        context),
  );
}

Widget countReportTypeScreen(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  if (analysisReportViewModel.rxTypeScreen.value == 1) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text('Tổng số học sinh',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text("1290", style: textBlueCountTotalStyle))
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text('Số HS mới tuyển đầu cấp',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text("780", style: textBlueCountTotalStyle))
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text('Tổng số học sinh lưu ban',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text("90", style: textBlueCountTotalStyle))
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text('Tỷ lệ học sinh nữ là dân tộc thiểu số',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text("180", style: textBlueCountTotalStyle))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Text('Số giáo viên nghỉ hưu',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("1290", style: textBlueCountTotalStyle))
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Text('Số giáo viên tuyển mới',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("780", style: textBlueCountTotalStyle))
              ],
            ),
          ),
        ],
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

var listReportPriSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp tiểu học",
  "Quy mô học sinh cấp tiểu học",
  "Cán bộ quản lý, giáo viên và nhân viên cấp tiểu học"
];

String chartNameToNamePrimaSchool(String chartName) {
  var name = "";
  switch (chartName) {
    case "CoCauTruongTieuHocTheoLoaiTruong":
      {
        name = "Cơ cấu trường tiểu học theo loại trường";
      }
      break;
    case "CoCauTruongTieuHocTheoDonViThanhLap":
      {
        name = "Cơ cấu trường tiểu học theo đơn vị thành lập";
      }
      break;
    case "CoCauTruongTieuHocTheoMucDoTruongChuanQuocGia":
      {
        name = "Cơ cấu trường tiểu học theo mức độ trường đạt chuẩn quốc gia";
      }
      break;
    case "CoCauPhongHocTheoLoaiPhong":
      {
        name = "Cơ cấu theo loại phòng học";
      }
      break;
    case "BieuDoSoSanhSoSoLuongPhongHoc":
      {
        name = "Thống kê số lượng phòng học";
      }
      break;
    case "BieuDoSoSanhSoSoLuongPhongHocNhoMuon":
      {
        name = "Thống kê số lượng phòng học nhờ, mượn";
      }
      break;
    case "BieuDoSoSanhSoSoLuongPhongPhucVuHocTap":
      {
        name = "Thống kê số lượng phòng phục vụ học tập";
      }
      break;
    case "BieuDoSoSanhSoLuongPhongKhac":
      {
        name = "Thống kê số lượng phòng khác";
      }
      break;
    case "BieuDoSoSanhSoLuongLopTheoLoai":
      {
        name = "Thống kê số lượng lớp học theo loại lớp";
      }
      break;
    case "BieuDoSoLuongLopTheoKhoiHoc":
      {
        name = "Thống kê số lượng lớp học theo khối học";
      }
      break;
    case "BieuDoSoSanhSoLuongLop1":
      {
        name = "Thống kê số lượng lớp 1";
      }
      break;
    case "BieuDoSoSanhSoLuongLop2":
      {
        name = "Thống kê số lượng lớp 2";
      }
      break;
    case "BieuDoSoSanhSoLuongLop3":
      {
        name = "Thống kê số lượng lớp 3";
      }
      break;
    case "BieuDoSoSanhSoLuongLop4":
      {
        name = "Thống kê số lượng lớp 4";
      }
      break;
    case "BieuDoSoSanhSoLuongLop5":
      {
        name = "Thống kê số lượng lớp 5";
      }
      break;
    case "BieuDoSoSanhSoLuongTruong":
      {
        name = "Thống kê số lượng trường tiểu học";
      }
      break;
    case "BieuDoSoSanhSoTruongDatChuan":
      {
        name = "Thống kê số lượng trường tiểu học đạt chuẩn quốc gia";
      }
      break;
    case "BieuDoSoSanhSoTiLeTruongDatChuanQuocGia":
      {
        name = "Thống kê tỷ lệ trường tiểu học đạt chuẩn quốc gia";
      }
      break;
  }

  return name;
}
