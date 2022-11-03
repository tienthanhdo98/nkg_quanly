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
                        value: (filterType?.isNotEmpty == true)
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
                                    .changeValuefilterType(filterType!);
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
            listChart[17].chartName!, listChart[17].items!, context, "2"),
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
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "2"),
        chartWidget(listChart[4].chartName!, listChart[5].items!, context, "2"),
        chartWidget(listChart[5].chartName!, listChart[5].items!, context, "2"),
        chartWidget(listChart[6].chartName!, listChart[6].items!, context, "2"),
        chartWidget(
            listChart[17].chartName!, listChart[17].items!, context, "2"),
        chartWidget(
            listChart[18].chartName!, listChart[18].items!, context, "2"),
        chartWidget(
            listChart[19].chartName!, listChart[19].items!, context, "2"),
        chartWidget(
            listChart[20].chartName!, listChart[20].items!, context, "2"),
        chartWidget(
            listChart[21].chartName!, listChart[21].items!, context, "2"),
        chartWidget(
            listChart[22].chartName!, listChart[22].items!, context, "2"),
      ],
    );
  } else if (analysisReportViewModel.rxTypeScreen.value == 2) {
    resWidget = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        chartWidget(listChart[0].chartName!, listChart[0].items!, context, "1"),
        chartWidget(listChart[2].chartName!, listChart[2].items!, context, "1"),
        chartWidget(listChart[3].chartName!, listChart[3].items!, context, "1"),
        chartWidget(listChart[4].chartName!, listChart[4].items!, context, "1"),
        chartWidget(listChart[1].chartName!, listChart[1].items!, context, "2"),
        chartWidget(
            listChart[18].chartName!, listChart[18].items!, context, "2"),
        chartWidget(listChart[6].chartName!, listChart[5].items!, context, "2"),
        chartWidget(listChart[7].chartName!, listChart[6].items!, context, "2"),
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
    //2
    case "BieuDoCoCauTreEmTheoKhoiHoc":
      {
        name = "Cơ cấu học sinh theo khối học";
      }
      break;
    case "BieuDoCoCauTreEmTheoHinhThucHoc":
      {
        name = "Cơ cấu học sinh theo hình thức học";
      }
      break;
    case "BieuDoCoCauTreEmTheoDoTuoi":
      {
        name = "Cơ cấu học sinh theo độ tuổi";
      }
      break;
    case "BieuDoSoSanhBinhQuanHSLopHoc":
      {
        name = "Thống kê bình quân học sinh/ lớp học";
      }
      break;
    case "BieuDoBienDongHocSinh":
      {
        name = "Thống kê biến động học sinh";
      }
      break;
    case "BieuDoSoSanhQuyMoHocSinh":
      {
        name = "Thống kê quy mô học sinh";
      }
      break;
    case "BieuDoSoHocSinhLuuBanTheoKhoi":
      {
        name = "Thống kê số học sinh lưu ban theo khối lớp";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhDiHocDungTuoi":
      {
        name = "Thống kê tỷ lệ học sinh đi học đúng tuổi";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhLenLop":
      {
        name = "Thống kê tỷ lệ học sinh lên lớp";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhLuuBan":
      {
        name = "Thống kê tỷ lệ học sinh lưu ban";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhBoHoc":
      {
        name = "Thống kê tỷ lệ học sinh bỏ học";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhHoanThanhChuongTrinh":
      {
        name = "Thống kê tỷ lệ học sinh hoàn thành chương trình học";
      }
      break;
    case "BieuDoSoSanhTyLeHocSinhTotNghiep":
      {
        name = "Thống kê tỷ lệ học sinh tốt nghiệp";
      }
      break;
    //3
    case "BieuDoCoCauCanBoGiaoVienNhanVienLaNuTheoDanTocThieuSo":
      {
        name =
            "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số";
      }
      break;
    case "BieuDoCoCauGiaoVienTheoTrinhDoDaoTao":
      {
        name = "Cơ cấu giáo viên theo trình độ đào tạo";
      }
      break;
    case "BieuDoCoCauGiaoVienTheoTuoi":
      {
        name = "Cơ cấu giáo viên theo độ tuổi";
      }
      break;
    case "BieuDoCoCauGiaoVienTheoDanhGiaChuanNgheNghiep":
      {
        name = "Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp";
      }
      break;
    case "BieuDoSoSanhSoLuongCanBoGiaoVienVaNhanVien":
      {
        name = "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên";
      }
      break;
    case "BieuDoSoSanhSoTyLeGiaoVienDatChuan":
      {
        name = "Thống kê tỷ lệ giáo viên đạt chuẩn";
      }
      break;
    case "BieuDoSoSanhSoBinhQuanSoHocSinhGiaoVien":
      {
        name = "Thống kê bình quân số học sinh/ giáo viên";
      }
      break;
    case "BieuDoSoSanhBinhQuanSoGiaoVienLop":
      {
        name = "Thống kê bình quân số giáo viên/ lớp";
      }
      break;
  }
  return name;
}

Widget countReportTypeScreen(
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
                      child: Text(checkingStringNull(item?[2].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item?[2].value),
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
                      child: Text(checkingStringNull(item?[3].name),
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(checkingStringNull(item?[3].value),
                            style: textBlueCountTotalStyle))
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
