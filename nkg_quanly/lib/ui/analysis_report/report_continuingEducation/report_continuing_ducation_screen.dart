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
import '../chart/analysis_pie_chart.dart';

class ReportContinuingEducationScreen extends GetView {
  ReportContinuingEducationScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());
  String? filterType = "";

  @override
  Widget build(BuildContext context) {
    filterType = listReportGDTX[0];
    analysisReportViewModel.getDataContinuingEducation();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Giáo dục thường xuyên", context),
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
                        items: listReportGDTX
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
                            listReportGDTX.asMap().forEach((index, itemValue) {
                              if (itemValue == value) {
                                if(index ==  0) {
                                  analysisReportViewModel.clearSelectedFilter();
                                  analysisReportViewModel
                                      .changeValuefilterType(filterType!);
                                  analysisReportViewModel.rxTypeScreen.value =
                                      index;
                                  analysisReportViewModel
                                      .getListContinuingEducation(
                                      "${index + 1}",
                                      "",
                                      analysisReportViewModel
                                          .rxSelectedRegionID.value,
                                      "",
                                      "",
                                      listReportGDTX[index]);
                                }
                                else if(index == 1)
                                  {
                                    analysisReportViewModel.clearSelectedFilter();
                                    analysisReportViewModel
                                        .changeValuefilterType(filterType!);
                                    analysisReportViewModel.rxTypeScreen.value =
                                        index;
                                    analysisReportViewModel
                                        .getListContinuingEducation(
                                        "1",
                                        "",
                                        analysisReportViewModel
                                            .rxSelectedRegionID.value,
                                        "",
                                        "",
                                        listReportGDTX[index]);
                                  }
                                else {
                                  analysisReportViewModel.clearSelectedFilter();
                                  analysisReportViewModel
                                      .changeValuefilterType(filterType!);
                                  analysisReportViewModel.rxTypeScreen.value =
                                      index;
                                  analysisReportViewModel
                                      .getListContinuingEducation(
                                      "2",
                                      "",
                                      analysisReportViewModel
                                          .rxSelectedRegionID.value,
                                      "",
                                      "",
                                      listReportGDTX[index]);
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
                                      onClick: () {
                                        var curIndex = analysisReportViewModel.rxTypeScreen.value;
                                        if(curIndex ==  0) {
                                          analysisReportViewModel
                                              .getListContinuingEducation(
                                              "1",
                                              analysisReportViewModel
                                                  .rxSelectedSemesterId.value,
                                              analysisReportViewModel
                                                  .rxSelectedRegionID.value,
                                              analysisReportViewModel
                                                  .rxSelectedProvinceId.value,
                                              analysisReportViewModel
                                                  .rxSelectedSchoolYearID.value,
                                              listReportGDTX[0]);
                                        }
                                        else if(curIndex == 1)
                                        {
                                          analysisReportViewModel
                                              .getListContinuingEducation(
                                              "1",
                                              analysisReportViewModel
                                                  .rxSelectedSemesterId.value,
                                              analysisReportViewModel
                                                  .rxSelectedRegionID.value,
                                              analysisReportViewModel
                                                  .rxSelectedProvinceId.value,
                                              analysisReportViewModel
                                                  .rxSelectedSchoolYearID.value,
                                              listReportGDTX[1]);
                                        }
                                        else {
                                          analysisReportViewModel
                                              .getListContinuingEducation(
                                              "2",
                                              analysisReportViewModel
                                                  .rxSelectedSemesterId.value,
                                              analysisReportViewModel
                                                  .rxSelectedRegionID.value,
                                              analysisReportViewModel
                                                  .rxSelectedProvinceId.value,
                                              analysisReportViewModel
                                                  .rxSelectedSchoolYearID.value,
                                              listReportGDTX[2]);
                                        }
                                        analysisReportViewModel
                                            .changeStateLoadingData(true);
                                        analysisReportViewModel.scrollToTop();
                                      },
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
                  child:Obx(() => (analysisReportViewModel
                      .isLoadingData.value ==
                      false) ? Column(
                    children: [
                      Obx(() => countReport(analysisReportViewModel, context)),
                      Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: analysisReportViewModel
                              .rxListChartAnalysis.length,
                          itemBuilder: (context, index) {
                            var item = analysisReportViewModel
                                .rxListChartAnalysis[index];
                            return checkNameToShowContinuingeducationChart(
                                item, context);
                          }))
                    ],
                  ) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(child: CircularProgressIndicator()),
                    )],)),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

Widget countReport(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  var item = analysisReportViewModel.rxInfoReport.value.items;
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
                    child: Text(checkingStringNull(item![0].name),
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(checkingStringNull(item![0].value), style: textBlueCountTotalStyle))
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
                    child: Text(checkingStringNull(item[1].name),
                        style: Theme.of(context).textTheme.headline5),
                  ),
                   Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(checkingStringNull(item[1].value), style: textBlueCountTotalStyle))
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
                      child: Text(checkingStringNull(item[2].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                     Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item[2].value), style: textBlueCountTotalStyle))
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
                      child: Text(checkingStringNull(item[3].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item[3].value), style: textBlueCountTotalStyle))
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
                  height: 30,
                  child: Text(checkingStringNull(item![0].name),
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(item[0].value), style: textBlueCountTotalStyle))
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
                  child: Text(checkingStringNull(item[1].name),
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(item[1].value), style: textBlueCountTotalStyle))
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

var listReportGDTX = [
  "Báo cáo thống kê số cơ sở GDTX",
  "Báo cáo thống kê người học GDTX",
  "Báo cáo thống kê cán bộ quản lý, giáo viên và nhân viên GDTX",
];

Widget checkNameToShowContinuingeducationChart(
    AnalysisChartModel items, BuildContext context) {
  Widget? chartWidget = const SizedBox();
  String? chartName = "";

  switch (items.chartName) {
    case "CoCauCoSoGDTXTheoLoaiTruong":
      {
        chartName = "Cơ cấu cơ sở giáo dục thường xuyên theo loại cơ cở";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "CoCauCoSoGDTXTheoDonViThanhLap":
      {
        chartName = "Cơ cấu cơ sở giáo dục thường xuyên theo đơn vị thành lập";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhCoSoGiaoDucThuongXuyen":
      {
        chartName = "Thống kê cơ sở giáo dục thường xuyên";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    //
    case "BieuDoCoCauHocVienTheoChuongTrinhDaoTao":
      {
        chartName = "Cơ cấu giáo viên theo trình độ đào tạo";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoHocVienGDTX":
      {
        chartName = "Thống kê số học viên giáo dục thường xuyên";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoHocVienBoHoc":
      {
        chartName = "Thống kê số học viên bỏ học";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoHocVienLuuBan":
      {
        chartName = "Thống kê số học viên lưu ban";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    //
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienTheoVung":
      {
        chartName = "Thống kê cán bộ quản lý, giáo viên, nhân viên theo vùng";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoCoCauGiaoVienTheoTrinhDoDaoTao":
      {
        chartName = "Cơ cấu giáo viên theo trình độ đào tạo";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoCoCauGiaoVienTheoDoTuoi":
      {
        chartName = "Cơ cấu giáo viên theo độ tuổi";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoCoCauGiaoVienTheoDanhGiaChuanNgheNgiep":
      {
        chartName = "Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      {
        chartName = "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số";
        chartWidget = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVien":
      {
        chartName = "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienTheoTinhTP":
      {
        chartName = "Thống kê cán bộ quản lý, giáo viên, nhân viên theo tỉnh/ TP";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienTheoNamHoc":
      {
        chartName = "Thống kê cán bộ quản lý, giáo viên, nhân viên theo năm";
        chartWidget = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items.items,
        );
      }
      break;
    //
    default:
      {
        chartWidget = const SizedBox.shrink();
      }
  }
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
            chartWidget
          ]),
        ),
        context),
  );
}
