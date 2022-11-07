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
import '../chart/analysis_multi_value_collum_chart.dart';
import '../chart/analysis_pie_chart.dart';

class ReportPreSchoolScreen extends GetView {
  ReportPreSchoolScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    var filterType = listReportPreSchoolType[0];
    analysisReportViewModel.getDataPreSchool();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Giáo dục mầm non", context),
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
                        value: (filterType.isNotEmpty == true)
                            ? filterType
                            : null,
                        underline: const SizedBox.shrink(),
                        items: listReportPreSchoolType
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
                            listReportPreSchoolType
                                .asMap()
                                .forEach((index, itemValue) {
                              if (itemValue == value) {
                                analysisReportViewModel
                                    .changeValuefilterType(filterType);
                                analysisReportViewModel.rxTypeScreen.value =
                                    index;
                                analysisReportViewModel.clearSelectedFilter();
                                analysisReportViewModel.getListChartPreSchool(
                                    "${index + 1}",
                                    analysisReportViewModel
                                        .rxSelectedSemesterId.value,
                                    analysisReportViewModel
                                        .rxSelectedRegionID.value,
                                    analysisReportViewModel
                                        .rxSelectedProvinceId.value,
                                    analysisReportViewModel
                                        .rxSelectedSchoolYearID.value,
                                    listReportPreSchoolType[index]);
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
                                        var curIndex = analysisReportViewModel
                                            .rxTypeScreen.value;
                                        //   analysisReportViewModel.clearSelectedFilter();
                                        analysisReportViewModel.getListChartPreSchool(
                                            "${curIndex + 1}",
                                            analysisReportViewModel
                                                .rxSelectedSemesterId.value,
                                            analysisReportViewModel
                                                .rxSelectedRegionID.value,
                                            analysisReportViewModel
                                                .rxSelectedProvinceId.value,
                                            analysisReportViewModel
                                                .rxSelectedSchoolYearID.value,
                                            listReportPreSchoolType[curIndex]);
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
                    child: Obx(() =>
                        (analysisReportViewModel.isLoadingData.value == false)
                            ? Column(
                                children: [
                                  Obx(() => countReportTypeScreen(
                                      analysisReportViewModel, context)),
                                  Obx(() => listChartScreen(
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
        chartWidget(listChart[8].chartName!, listChart[8].items!, context, "2"),
        chartWidget(
            listChart[14].chartName!, listChart[14].items!, context, "2"),
        chartWidget(listChart[9].chartName!, listChart[9].items!, context, "2"),
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "1"),
        chartWidget(listChart[4].chartName!, listChart[4].items!, context, "2"),
        chartWidget(listChart[5].chartName!, listChart[5].items!, context, "2"),
        chartWidget(listChart[6].chartName!, listChart[6].items!, context, "2"),
        chartWidget(listChart[7].chartName!, listChart[7].items!, context, "2"),
        chartWidget(
            listChart[11].chartName!, listChart[11].items!, context, "2"),
        chartWidget(
            listChart[12].chartName!, listChart[12].items!, context, "2"),
        chartWidget(
            listChart[13].chartName!, listChart[13].items!, context, "2"),
        chartWidget(
            listChart[17].chartName!, listChart[17].items!, context, "3"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 1) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartWidget(listChart[0].chartName!, listChart[0].items!, context, "1"),
        chartWidget(listChart[1].chartName!, listChart[1].items!, context, "1"),
        chartWidget(listChart[2].chartName!, listChart[2].items!, context, "1"),
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "1"),
        chartWidget(listChart[4].chartName!, listChart[5].items!, context, "1"),
        chartWidget(listChart[5].chartName!, listChart[5].items!, context, "1"),
        chartWidget(listChart[6].chartName!, listChart[6].items!, context, "2"),
        chartWidget(listChart[7].chartName!, listChart[7].items!, context, "2"),
        chartWidget(listChart[8].chartName!, listChart[8].items!, context, "2"),
        chartWidget(listChart[9].chartName!, listChart[9].items!, context, "2"),
        chartWidget(
            listChart[10].chartName!, listChart[10].items!, context, "2"),
        chartWidget(
            listChart[11].chartName!, listChart[11].items!, context, "2"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartWidget(listChart[0].chartName!, listChart[0].items!, context, "1"),
        chartWidget(listChart[1].chartName!, listChart[1].items!, context, "1"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 3) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartWidget(listChart[0].chartName!, listChart[0].items!, context, "1"),
        chartWidget(listChart[6].chartName!, listChart[6].items!, context, "1"),
        chartWidget(
            listChart[10].chartName!, listChart[10].items!, context, "1"),
        chartWidget(listChart[7].chartName!, listChart[7].items!, context, "1"),
        chartWidget(listChart[1].chartName!, listChart[1].items!, context, "2"),
        chartWidget(
            listChart[14].chartName!, listChart[14].items!, context, "2"),
        chartWidget(listChart[2].chartName!, listChart[2].items!, context, "2"),
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "2"),
        chartWidget(listChart[4].chartName!, listChart[4].items!, context, "2"),
        chartWidget(listChart[5].chartName!, listChart[5].items!, context, "2"),
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
                    checkingStringNull(chartNameToNameSecondSchool(chartName)),
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

Widget getChartByType(List<ChartChildItems> items, String type) {
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
  } else {
    return AnalysisMultiValueCollumChartWidget(
      key: UniqueKey(),
      listChart: items,
    );
  }
}

String chartNameToNameSecondSchool(String chartName) {
  var name = "";
  switch (chartName) {
    case "CoCauMamNonTheoLoaiTruong":
      {
        name = "Cơ cấu trường mầm non theo loại trường";
      }
      break;
    case "CoCauMamNonTheoDonViThanhLap":
      {
        name = "Cơ cấu trường mầm non theo đơn vị thành lập";
      }
      break;
    case "CoCauMamNonTheoMucDoTruongChuanQuocGia":
      {
        name = "Cơ cấu trường mầm non theo mức độ trường đạt chuẩn quốc gia";
      }
      break;
    case "BieuDoSoSanhSoLuongTruong":
      {
        name = "Thống kê số lượng trường mầm non";
      }
      break;
    case "BieuDoSoSanhTyLeTruongDatChuanQuocGia":
      {
        name = "Thống kê tỷ lệ trường mầm non đạt chuẩn quốc gia";
      }
      break;
    case "BieuDoSoSanhSoLuongTruongDatChuan":
      {
        name = "Thống kê số lượng trường mầm non đạt chuẩn quốc gia";
      }
      break;
    case "CoCauPhongHocTheoLoaiPhong":
      {
        name = "Cơ cấu theo loại phòng học";
      }
      break;
    case "BieuDoSoSanhSoLuongPhongHoc":
      {
        name = "Thống kê số lượng phòng học";
      }
      break;
    case "BieuDoSoSanhSoLuongPhongHocNhoMuon":
      {
        name = "Thống kê số lượng phòng học nhờ, mượn";
      }
      break;
    case "BieuDoSoSanhSoLuongPhongHocPhucVuHocTap":
      {
        name = "Thống kê số lượng phòng phục vụ học tập";
      }
      break;
    case "BieuDoSoSanhSoLuongPhongHocKhac":
      {
        name = "Thống kê số lượng phòng khác";
      }
      break;
    case "BieuDoSoSanhSoLuongLop":
      {
        name = "Thống kê số lớp học";
      }
      break;
    case "BieuDoSoSanhSoLuongTheoLop":
      {
        name = "Thống kê số lượng lớp học theo loại lớp";
      }
      break;
    case "BieuDoSoSanhSoLuongTheoNhomTre":
      {
        name = "Thống kê số lượng trẻ theo nhóm";
      }
      break;
    case "BieuDoSoSanhSoLuongNhom":
      {
        name = "Thống kê số lượng trẻ theo nhóm của từng vùng";
      }
      break;
    //1
    case "BieuDoCoCauTreEmTheoCapHoc":
      {
        name = "Cơ cấu trẻ em mầm non theo cấp học";
      }
      break;
    case "BieuDoCoCauTreEmTheoNhom":
      {
        name = "Cơ cấu trẻ em mầm non theo nhóm";
      }
      break;
    case "BieuDoCoCauTreEmTheoDonVi":
      {
        name = "Cơ cấu trẻ em mầm non theo đơn vị";
      }
      break;
    case "BieuDoCoCauTreEmTheoGioiTinh":
      {
        name = "Cơ cấu trẻ em mầm non theo giới tính";
      }
      break;
    case "BieuDoCoCauTreEmTheoDanToc":
      {
        name = "Cơ cấu trẻ em mầm non theo dân tộc";
      }
      break;
    case "BieuDoCoCauTreEmTheoHinhThucHoc":
      {
        name = "Cơ cấu trẻ em mầm non theo hình thức học";
      }
      break;
    case "BieuDoSoSanhSoLuongTreEm":
      {
        name = "Thống kê số lượng trẻ";
      }
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom12":
      {
        name = "Thống kê số lượng bình quân trẻ từ 1-2 tuổi";
      }
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom23":
      {
        name = "Thống kê số lượng bình quân trẻ từ 2-3 tuổi";
      }
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom34":
      {
        name = "Thống kê số lượng bình quân trẻ từ 3-4 tuổi";
      }
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom45":
      {
        name = "Thống kê số lượng bình quân trẻ từ 4-5 tuổi";
      }
      break;
    case "BieuDoSoSanhSoLuongBinhQuanTreEmNhom56":
      {
        name = "Thống kê số lượng bình quân trẻ từ 5-6 tuổi";
      }
      break;
    //2
    case "BieuDoTyLeTreTheoDinhDuong":
      {
        name = "Thống kê tỷ lệ trẻ theo dinh dưỡng";
      }
      break;
    case "BieuDoSoSanhTyLeTreEmNuSuyDinhDuongTheoDanToc":
      {
        name = "Thống kê tỷ lệ trẻ em nữ suy dinh dưỡng theo dân tộc";
      }
      break;
    // 3
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      {
        name = "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số";
      }
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoTrinhDoDaoTao":
      {
        name = "Cơ cấu giáo viên theo trình độ đào tạo";
      }
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoDoTuoi":
      {
        name = "Cơ cấu giáo viên theo độ tuổi";
      }
      break;
    case "BieuDoCoCauGiaoVienCapMamNonChiaTheoDanhGiaChuanChuyenNghiep":
      {
        name = "Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienNhanVien":
      {
        name = "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên";
      }
      break;
    case "BieuDoSoSanhTyLeGiaoVienDatChuan":
      {
        name = "Thống kê tỷ lệ giáo viên đạt chuẩn";
      }
      break;
    case "BieuDoSoSanhBinhQuanSoGiaoVienNhom":
      {
        name = "Thống kê bình quân giáo viên/ nhóm";
      }
      break;
    case "BieuDoSoSanhBinhQuanSoGiaoVienLop":
      {
        name = "Thống kê bình quân giáo viên/ lớp";
      }
      break;
    case "BieuDoSoSanhBinhQuanSoTreNhaTreGiaoVien":
      {
        name = "Thống kê bình quân số lượng trẻ của nhà trẻ/ giáo viên";
      }
      break;
    case "BieuDoSoSanhBinhQuanSoTreMauGiaoGiaoVien":
      {
        name = "Thống kê bình quân số lượng trẻ của mẫu giáo/ giáo viên";
      }
      break;
  }
  return name;
}

Widget countReportTypeScreen(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  var item = analysisReportViewModel.rxInfoReport.value.items;
  if (analysisReportViewModel.rxTypeScreen.value == 2) {
    return Column(
      children: [
        Padding(
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
                      child: Text(checkingStringNull(item?[0].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item?[0].value),
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
                      child: Text(checkingStringNull(item?[1].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item?[1].value),
                            style: textBlueCountTotalStyle))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 3) {
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
                  child: Text(checkingStringNull(item?[0].name),
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(item?[0].value),
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
                  child: Text(checkingStringNull(item?[1].name),
                      style: Theme.of(context).textTheme.headline5),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(item?[1].value),
                        style: textBlueCountTotalStyle))
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

var listReportPreSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp mầm non",
  "Quy mô trẻ em học cấp mầm non",
  "Tình trạng dinh dưỡng trẻ em cấp mầm non",
  "Cán bộ quản lý, giáo viên và nhân viên cấp mầm non"
];
