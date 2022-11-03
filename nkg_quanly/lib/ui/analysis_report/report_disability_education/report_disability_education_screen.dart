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

class ReportDisabilityEducationScreen extends GetView {
  ReportDisabilityEducationScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());
  String? filterType = "";

  @override
  Widget build(BuildContext context) {
    filterType = listReportGDKT[0];
    analysisReportViewModel.getDataDisabilityEducation();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Giáo dục khuyết tật", context),
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
                        items: listReportGDKT
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
                            listReportGDKT.asMap().forEach((index, itemValue) {
                              if (itemValue == value) {
                                analysisReportViewModel
                                    .changeValuefilterType(filterType!);
                                analysisReportViewModel.rxTypeScreen.value =
                                    index;
                                analysisReportViewModel.clearSelectedFilter();
                                analysisReportViewModel.getDisabilityEducation(
                                    "${index + 1}",
                                    analysisReportViewModel.rxSelectedSemesterId.value,
                                    analysisReportViewModel.rxSelectedRegionID.value,
                                    analysisReportViewModel.rxSelectedProvinceId.value,
                                    analysisReportViewModel.rxSelectedSchoolYearID.value,
                                    listReportGDKT[index]);
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
                                   analysisReportViewModel: analysisReportViewModel,
                                onClick: (){
                                  var index =   analysisReportViewModel.rxTypeScreen.value;
                                  analysisReportViewModel.getDisabilityEducation(
                                      "${index + 1}",
                                      analysisReportViewModel.rxSelectedSemesterId.value,
                                      analysisReportViewModel.rxSelectedRegionID.value,
                                      analysisReportViewModel.rxSelectedProvinceId.value,
                                      analysisReportViewModel.rxSelectedSchoolYearID.value,
                                      listReportGDKT[index]);
                                  analysisReportViewModel.changeStateLoadingData(true);

                                },));
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
                            false)
                        ? Column(
                            children: [
                              countReport(analysisReportViewModel, context),
                              Obx(() => ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: analysisReportViewModel
                                      .rxListChartAnalysis.length,
                                  itemBuilder: (context, index) {
                                    var item = analysisReportViewModel
                                        .rxListChartAnalysis[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: borderItem(
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      chartNameToFullNameChart(
                                                          item.chartName!),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                  ),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0)),
                                                  InkWell(
                                                    onTap: () {
                                                      var  curIndex = analysisReportViewModel!.rxTypeScreen.value;
                                                       analysisReportViewModel.getDisabilityEducation(
                                                           "${curIndex + 1}",
                                                           analysisReportViewModel.rxSelectedSemesterId.value,
                                                           analysisReportViewModel.rxSelectedRegionID.value,
                                                           analysisReportViewModel.rxSelectedProvinceId.value,
                                                           analysisReportViewModel.rxSelectedSchoolYearID.value,
                                                           listReportGDKT[curIndex]);
                                                    },
                                                    child: Image.asset(
                                                        "assets/icons/ic_refresh.png",
                                                        width: 16,
                                                        height: 16),
                                                  ),
                                                ],
                                              ),
                                              checkNameToShowDisabilityEducationChart(
                                                  item.chartName!, item.items)
                                            ]),
                                          ),
                                          context),
                                    );
                                  }))
                            ],
                          )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(child: CircularProgressIndicator()),
                      )],))),
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
  if (analysisReportViewModel.rxTypeScreen.value == 1) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Obx(
          () => Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Text(
                          checkingStringNull(analysisReportViewModel
                              .rxInfoReport.value.items![0].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            checkingStringNull(analysisReportViewModel
                                .rxInfoReport.value.items![0].value),
                            style: textBlueCountTotalStyle))
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
                      child: Text(
                          checkingStringNull(analysisReportViewModel
                              .rxInfoReport.value.items![1].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            checkingStringNull(analysisReportViewModel
                                .rxInfoReport.value.items![1].value),
                            style: textBlueCountTotalStyle))
                  ],
                ),
              ),
            ],
          ),
        ));
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Obx(
          () => Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                          checkingStringNull(analysisReportViewModel
                              .rxInfoReport.value.items![0].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            checkingStringNull(analysisReportViewModel
                                .rxInfoReport.value.items![0].value),
                            style: textBlueCountTotalStyle))
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
                      child: Text(
                          checkingStringNull(analysisReportViewModel
                              .rxInfoReport.value.items![1].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                            checkingStringNull(analysisReportViewModel
                                .rxInfoReport.value.items![1].value),
                            style: textBlueCountTotalStyle))
                  ],
                ),
              ),
            ],
          ),
        ));
  } else {
    return const SizedBox.shrink();
  }
}

var listReportGDKT = [
  "Báo cáo thống kê số trung tâm GDKT",
  "Báo cáo thống kê học sinh khuyết tật",
  "Báo cáo thống kê cán bộ quản lý, giáo viên và nhân viên hỗ trợ giáo dục trẻ em khuyết tật",
];

String chartNameToFullNameChart(String chartName) {
  var fullName = "";
  switch (chartName) {
    case "CoCauCoSoGDKTTheoLoaiTruong":
      {
        fullName = "Cơ cấu cơ sở giáo dục khuyết tật theo trung tâm";
      }
      break;
    case "CoCauCoSoGDKTTheoDonViThanhLap":
      {
        fullName = "Cơ cấu cơ sở giáo dục khuyết theo đơn vị thành lập";
      }
      break;
    case "BieuDoSoSanhCoSoGiaoDucThuongXuyen":
      {
        fullName = "Thống kê cơ sở giáo dục khuyết tật";
      }
      break;
    //
    case "BieuDoCoCauGiaoVienTheoDoTuoi":
      {
        fullName = "Cơ cấu giáo viên theo độ tuổi";
      }
      break;
    case "BieuDoCoCauHocSinhTheoDangKhuyetTat":
      {
        fullName = "Cơ cấu HS theo dạng khuyết tật";
      }
      break;
    case "BieuDoCoCauHocSinhTheoMucDoKhuyetTat":
      {
        fullName = "Cơ cấu HS theo mức độ khuyết tật";
      }
      break;
    case "BieuDoCoCauTreEmDuocCanThiepSomTheoDangKhuyetTat":
      {
        fullName = "Cơ cấu HS được can thiệp sớm theo dạng khuyết tật";
      }
      break;
    case "BieuDoSoSanhHocSinhKhuyetTatTheoTinhTP":
      {
        fullName = "Thống kê HS khuyết tật theo tỉnh/ thành phố";
      }
      break;
    case "BieuDoSoSanhHocSinhKhuyetTatTheoNamHoc":
      {
        fullName = "Thống kê HS khuyết tật theo năm học";
      }
      break;
    case "BieuDoSoSanhHocSinhKhuyetTatTheoVung":
      {
        fullName = "Thống kê HS khuyết tật theo vùng";
      }
      break;
    //
    case "BieuDoCoCauGiaoVienTheoDanhGiaChuanNgheNghiep":
      {
        fullName = "Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp";
      }
      break;
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      {
        fullName =
            "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienVaNhanVien":
      {
        fullName = "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienTheoTinhTP":
      {
        fullName =
            "Thống kê cán bộ quản lý, giáo viên, nhân viên theo tỉnh/ TP";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienTheoNamHoc":
      {
        fullName = "Thống kê cán bộ quản lý, giáo viên, nhân viên theo năm";
      }
      break;
    case "BieuDoCoCauGiaoVienTheoTrinhDoDaoTao":
      {
        fullName = "Cơ cấu giáo viên theo trình độ đào tạo";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienKhuyetTatTheoVung":
      {
        fullName = "Thống kê cán bộ quản lý, giáo viên, nhân viên theo vùng";
      }
      break;
  }
  return fullName;
}

Widget checkNameToShowDisabilityEducationChart(
    String chartName, List<ChartChildItems>? items) {
  Widget? chart = SizedBox();
  switch (chartName) {
    case "CoCauCoSoGDKTTheoLoaiTruong":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "CoCauCoSoGDKTTheoDonViThanhLap":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhCoSoGiaoDucThuongXuyen":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    //
    case "BieuDoSoSanhHocSinhKhuyetTatTheoVung":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauHocSinhTheoDangKhuyetTat":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauHocSinhTheoMucDoKhuyetTat":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauTreEmDuocCanThiepSomTheoDangKhuyetTat":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhHocSinhKhuyetTatTheoTinhTP":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhHocSinhKhuyetTatTheoNamHoc":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    //
    case "BieuDoCoCauGiaoVienTheoDanhGiaChuanNgheNghiep":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienVaNhanVien":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienTheoTinhTP":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienTheoNamHoc":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauGiaoVienTheoTrinhDoDaoTao":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVienKhuyetTatTheoVung":
      {
        chart = AnalysisCollumChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    case "BieuDoCoCauGiaoVienTheoDoTuoi":
      {
        chart = AnalysisPieChartWidget(
          key: UniqueKey(),
          listChart: items,
        );
      }
      break;
    default:
      {
        chart = const SizedBox.shrink();
      }
  }
  return chart;
}
