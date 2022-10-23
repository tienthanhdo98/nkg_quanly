import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/analysis_report/report_education_quality/report_education_quality_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../const/api.dart';
import '../theme/theme_data.dart';
import 'analysis_report_viewmodel.dart';

const TYPE_SCREEN_EDUCATION = "education";

class AnalysisReportFilterScreen extends GetView {
  AnalysisReportFilterScreen(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  String? semester;
  String? province;
  String? region;
  String? schoolYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
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
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          analysisReportViewModel!.clearSelectedFilter();
                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //nhom đơn vị ban hành
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Học kì:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 300,
                                    child: FilterSemesterBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedSemester.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedSemester.value
                                  : "Chọn học kì",
                              context))),
                      //loai khu vuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Khu vực:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: FilterRegionBottomSheet(
                                        analysisReportViewModel, ""));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedRegion.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedRegion.value
                                  : "Chọn khu vực",
                              context))),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Tỉnh, thành phố:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: FilterProvinceBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedProvince.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedProvince.value
                                  : "Chọn tỉnh, thành phố",
                              context))),

                      //thu tuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Năm học:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    child: FilterSchoolYearBottomSheet(
                                        analysisReportViewModel, ""));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedSchoolYear.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedSchoolYear.value
                                  : "Chọn năm học",
                              context))),

                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();

                              },
                              child: buttonShowListScreen("Tìm kiếm"),
                              style: bottomButtonStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class AnalysisReportCSVCFilterScreen extends GetView {
  AnalysisReportCSVCFilterScreen(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  String? semester;
  String? province;
  String? region;
  String? schoolYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
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
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          analysisReportViewModel!.clearSelectedFilter();
                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //cap hoc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Cấp học:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    child: FilterSchoolLevelBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedSchoolLevel.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedSchoolLevel.value
                                  : "Chọn cấp học",
                              context))),
                      //loai khu vuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Khu vực:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: FilterRegionBottomSheet(
                                        analysisReportViewModel, ""));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedRegion.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedRegion.value
                                  : "Chọn khu vực",
                              context))),
                      //muc do
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Tỉnh, thành phố:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: FilterProvinceBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedProvince.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedProvince.value
                                  : "Chọn tỉnh, thành phố",
                              context))),

                      //thu tuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Năm học:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    child: FilterSchoolYearBottomSheet(
                                        analysisReportViewModel, ""));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                          .rxSelectedSchoolYear.value !=
                                      "")
                                  ? analysisReportViewModel!
                                      .rxSelectedSchoolYear.value
                                  : "Chọn năm học",
                              context))),

                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: buttonShowListScreen("Tìm kiếm"),
                              style: bottomButtonStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class AnalysisReportEducationQualityFilterScreen extends GetView {
  AnalysisReportEducationQualityFilterScreen(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  String? semester;
  String? province;
  String? region;
  String? schoolYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
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
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          analysisReportViewModel!.clearSelectedFilter();
                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //cap hoc
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Cấp trường:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.6,
                                      child: FilterSchoolLevelBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedSchoolLevel.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedSchoolLevel.value
                                    : "Chọn cấp trường",
                                context))),
                        //loai khu vuc
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Khu vực:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.65,
                                      child: FilterRegionBottomSheet(
                                          analysisReportViewModel, ""));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedRegion.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedRegion.value
                                    : "Chọn khu vực",
                                context))),
                        //thanh pho
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Tỉnh, thành phố:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.85,
                                      child: FilterProvinceBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedProvince.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedProvince.value
                                    : "Chọn tỉnh, thành phố",
                                context))),
                        //nam hoc
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Năm học:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.75,
                                      child: FilterSchoolYearBottomSheet(
                                          analysisReportViewModel, ""));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedSchoolYear.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedSchoolYear.value
                                    : "Chọn năm học",
                                context))),
                        //hoc ki
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Học kỳ:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.4,
                                      child: FilterSemesterBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedSemester.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedSemester.value
                                    : "Chọn học kỳ",
                                context))),

                        //chon lop
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Lớp:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.55,
                                      child: FilterClassBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedClass.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedClass.value
                                    : "Chọn lớp",
                                context))),
                        //mon hoc
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Môn học:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.55,
                                      child: FilterSubjectBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedSubject.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedSubject.value
                                    : "Chọn môn học",
                                context))),
                        //chon diem
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Điểm:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.55,
                                      child: FilterPointBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedPoint.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedPoint.value
                                    : "Chọn điểm",
                                context))),
                        //hoc luc
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Học lực:",
                            style: CustomTextStyle.grayColorTextStyle,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.55,
                                      child: FilterClassificationBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                    .rxSelectedClasstifi.value !=
                                    "")
                                    ? analysisReportViewModel!
                                    .rxSelectedClasstifi.value
                                    : "Chọn học lực",
                                context))),


                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: buttonShowListScreen("Tìm kiếm"),
                                style: bottomButtonStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class XepLoaiNangLucPhamChatFilterScreen extends GetView {
  XepLoaiNangLucPhamChatFilterScreen(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  String? semester;
  String? province;
  String? region;
  String? schoolYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //header
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
                      Text(
                        "Bộ lọc",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          analysisReportViewModel!.clearSelectedFilter();
                        },
                        child: const Text(
                          "Xóa bộ lọc",
                          style: TextStyle(color: kBlueButton),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //hoc ki
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Học kỳ:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: FilterSemesterBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                  .rxSelectedSemester.value !=
                                  "")
                                  ? analysisReportViewModel!
                                  .rxSelectedSemester.value
                                  : "Chọn học kỳ",
                              context))),
                      //cap hoc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Cấp trường:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    child: FilterSchoolLevelBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                  .rxSelectedSchoolLevel.value !=
                                  "")
                                  ? analysisReportViewModel!
                                  .rxSelectedSchoolLevel.value
                                  : "Chọn cấp trường",
                              context))),
                      //loai khu vuc
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Khu vực:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: FilterRegionBottomSheet(
                                        analysisReportViewModel, ""));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                  .rxSelectedRegion.value !=
                                  "")
                                  ? analysisReportViewModel!
                                  .rxSelectedRegion.value
                                  : "Chọn khu vực",
                              context))),
                      //thanh pho
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Tỉnh, thành phố:",
                          style: CustomTextStyle.grayColorTextStyle,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: FilterProvinceBottomSheet(
                                        analysisReportViewModel));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel!
                                  .rxSelectedProvince.value !=
                                  "")
                                  ? analysisReportViewModel!
                                  .rxSelectedProvince.value
                                  : "Chọn tỉnh, thành phố",
                              context))),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: buttonShowListScreen("Tìm kiếm"),
                              style: bottomButtonStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}



//hoc luc


class FilterSemesterBottomSheet extends StatelessWidget {
  const FilterSemesterBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //search

            //tat ca don vi
            FilterAllItem(
                "Tất cả học kì", 1, analysisReportViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: analysisReportViewModel!.rxListSemester.length,
                  itemBuilder: (context, index) {
                    var item = analysisReportViewModel!.rxListSemester[index];
                    return FilterItem(item.name!, item.id!, index,
                        analysisReportViewModel!.mapSemesterFilter);
                  }),
            ),
            //bottom button
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            if (analysisReportViewModel!.mapAllFilter
                                .containsKey(1)) {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedSemester,
                                      "Tất cả học kỳ");
                            } else {
                              var agencies = "";
                              var agenciesName = "";
                              analysisReportViewModel!.mapSemesterFilter
                                  .forEach((key, value) {
                                agencies += value;
                              });
                              var listId = agencies.split(";");
                              for (var id in listId) {
                                for (var item in analysisReportViewModel!
                                    .rxListSemester) {
                                  if (item.id == id) {
                                    agenciesName += "${item.name!};";
                                  }
                                }
                              }
                              if (agenciesName != "") {
                                analysisReportViewModel!
                                    .changeValueSelectedFilter(
                                        analysisReportViewModel!
                                            .rxSelectedSemester,
                                        agenciesName.substring(
                                            0, agenciesName.length - 1));
                              } else {
                                analysisReportViewModel!
                                    .changeValueSelectedFilter(
                                        analysisReportViewModel!
                                            .rxSelectedSemester,
                                        "");
                              }
                            }
                            Get.back();
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class FilterProvinceBottomSheet extends StatelessWidget {
  const FilterProvinceBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back");
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(children: [
              //search
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: kgray, borderRadius: BorderRadius.circular(10)),
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
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: kDarkGray, fontSize: 14),
                            hintText: 'Tìm kiếm tỉnh. thành phố...',
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          onSubmitted: (value) {
                            analysisReportViewModel!
                                .searchProvinceInFilterList(value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //tat ca linh cuc
              FilterAllItem("Tất cả tỉnh, thành phố", 2,
                  analysisReportViewModel!.mapAllFilter),
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Divider(
                    thickness: 1,
                    color: kgray,
                  )),
              SizedBox(
                child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: analysisReportViewModel!.rxListProvinceByRegion.length,
                    itemBuilder: (context, index) {
                      var item = analysisReportViewModel!.rxListProvinceByRegion[index];
                      return FilterItem(item.name!, item.id!, index,
                          analysisReportViewModel!.mapProvinceFilter);
                    })),
              ),
              //bottom button
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              // Get.back();
                              Navigator.of(context).maybePop();
                            },
                            style: buttonFilterWhite,
                            child: const Text('Đóng')),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              if (analysisReportViewModel!.mapAllFilter
                                  .containsKey(2)) {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!.rxSelectedProvince,
                                    "Tất cả lĩnh vực");
                              } else {
                                var branch = "";
                                var branchName = "";
                                analysisReportViewModel!.mapProvinceFilter
                                    .forEach((key, value) {
                                  branch += value;
                                });
                                var listId = branch.split(";");
                                for (var id in listId) {
                                  for (var item in analysisReportViewModel!
                                      .rxListProvinceByRegion) {
                                    if (item.id == id) {
                                      branchName += "${item.name!};";
                                    }
                                  }
                                }
                                if (branchName != "") {
                                  changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedProvince,
                                      branchName.substring(
                                          0, branchName.length - 1));
                                } else {
                                  changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedProvince,
                                      "");
                                }
                              }
                              Get.back();
                            },
                            style: buttonFilterBlue,
                            child: const Text('Áp dụng')),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class FilterRegionBottomSheet extends StatelessWidget {
  const FilterRegionBottomSheet(this.analysisReportViewModel, this.typeScreen,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;
  final String typeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        //search
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
          child: Container(
            decoration: BoxDecoration(
                color: kgray, borderRadius: BorderRadius.circular(10)),
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
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: kDarkGray, fontSize: 14),
                      hintText: 'Tìm kiếm khu vực...',
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    onSubmitted: (value) {
                      analysisReportViewModel!.searchRegionInFilterList(value);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        //tat ca trang thai
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: analysisReportViewModel!.rxListRegion.length,
              itemBuilder: (context, index) {
                var item = analysisReportViewModel!.rxListRegion[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (index ==
                            analysisReportViewModel!.rxIndexItemRegion.value)
                        ? InkWell(
                            onTap: () {
                              analysisReportViewModel!
                                  .changeValueIndexRegion(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              color: kLightBlue,
                              child: Text(
                                item.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              analysisReportViewModel!
                                  .changeValueIndexRegion(index);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                item.name!,
                                style: CustomTextStyle.roboto400s16TextStyle,
                              ),
                            ),
                          )),
                  ],
                );
              }),
        ),
        //bottom button
        const Spacer(),
        Align(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: buttonFilterWhite,
                      child: const Text('Đóng')),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        var region = "";
                        var regionID = "";
                        analysisReportViewModel!.rxListRegion
                            .asMap()
                            .forEach((index, value) {
                          if (index ==
                              analysisReportViewModel!
                                  .rxIndexItemRegion.value) {
                            region = value.name!;
                            regionID = value.id!;
                            analysisReportViewModel!.changeValueDataId(regionID,
                                analysisReportViewModel!.rxSelectedRegionID);
                            analysisReportViewModel!.getListProvinceByRegion();
                          }
                        });
                        changeValueSelectedFilter(
                            analysisReportViewModel!.rxSelectedRegion, region);
                        if (typeScreen == TYPE_SCREEN_EDUCATION) {
                          analysisReportViewModel!.getEducationChart(
                              analysisReportViewModel!.rxSelectedRegionID.value,
                              analysisReportViewModel!
                                  .rxSelectedSchoolYearID.value);
                          Get.back();
                        } else {
                          Get.back();
                        }
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class FilterSchoolYearBottomSheet extends StatelessWidget {
  const FilterSchoolYearBottomSheet(
      this.analysisReportViewModel, this.typeScreen,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;
  final String typeScreen;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        analysisReportViewModel!.getListFilter(getAnalysisReportSchoolYear,
            analysisReportViewModel!.rxListSchoolYear);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(children: [
            //search
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
              child: Container(
                decoration: BoxDecoration(
                    color: kgray, borderRadius: BorderRadius.circular(10)),
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
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: kDarkGray, fontSize: 14),
                          hintText: 'Tìm kiếm năm học...',
                        ),
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        onSubmitted: (value) {
                          analysisReportViewModel!
                              .searchSchoolYearInFilterList(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            //tat ca thu tuc
            FilterAllItem(
                "Tất cả năm học", 4, analysisReportViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //list van de trinh
            Obx(() => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          analysisReportViewModel!.rxListSchoolYear.length,
                      itemBuilder: (context, index) {
                        var item =
                            analysisReportViewModel!.rxListSchoolYear[index];
                        return FilterItem(item.name!, item.id!, index,
                            analysisReportViewModel!.mapSchoolYearFilter);
                      }),
                )),
            //bottom button
            const Spacer(),
            Align(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            var schoolYearItem = "";
                            var schoolYearName = "";
                            var schoolYearId = "";
                            if (analysisReportViewModel!.mapAllFilter
                                    .containsKey(4) ||
                                analysisReportViewModel!
                                    .mapSchoolYearFilter.isEmpty) {
                              changeValueSelectedFilter(
                                  analysisReportViewModel!.rxSelectedSchoolYear,
                                  "Tất cả năm học");
                              analysisReportViewModel!.changeValueDataId(
                                  "",
                                  analysisReportViewModel!
                                      .rxSelectedSchoolYearID);
                            } else {
                              analysisReportViewModel!.mapSchoolYearFilter
                                  .forEach((key, value) {
                                schoolYearItem += value;
                              });
                              var listId = schoolYearItem.split(";");
                              for (var id in listId) {
                                for (var item in analysisReportViewModel!
                                    .rxListSchoolYear) {
                                  if (item.id == id) {
                                    schoolYearName += "${item.name!};";
                                    schoolYearId += "${item.id!};";
                                    analysisReportViewModel!.changeValueDataId(
                                        schoolYearId,
                                        analysisReportViewModel!
                                            .rxSelectedSchoolYearID);
                                  }
                                }
                              }
                              if (schoolYearName != "") {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolYear,
                                    schoolYearName.substring(
                                        0, schoolYearName.length - 1));
                              } else {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolYear,
                                    "");
                              }
                            }
                            if (typeScreen == TYPE_SCREEN_EDUCATION) {
                              analysisReportViewModel!.getEducationChart(
                                  analysisReportViewModel!
                                      .rxSelectedRegionID.value,
                                  analysisReportViewModel!
                                      .rxSelectedSchoolYearID.value);
                              Get.back();
                            } else {
                              Get.back();
                            }
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class FilterSchoolLevelBottomSheet extends StatelessWidget {
  const FilterSchoolLevelBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        analysisReportViewModel!.getListFilter(getAnalysisReportSchoolLevel,
            analysisReportViewModel!.rxListSchoolLevel);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(children: [
            //search
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
              child: Container(
                decoration: BoxDecoration(
                    color: kgray, borderRadius: BorderRadius.circular(10)),
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
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: kDarkGray, fontSize: 14),
                          hintText: 'Tìm kiếm cấp học...',
                        ),
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        onSubmitted: (value) {
                          analysisReportViewModel!
                              .searchSchoolLevelInFilterList(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            //tat ca thu tuc
            FilterAllItem(
                "Tất cả cấp học", 5, analysisReportViewModel!.mapAllFilter),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //list van de trinh
            Obx(() => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          analysisReportViewModel!.rxListSchoolLevel.length,
                      itemBuilder: (context, index) {
                        var item =
                            analysisReportViewModel!.rxListSchoolLevel[index];
                        return FilterItem(item.name!, item.id!, index,
                            analysisReportViewModel!.mapSchoolLevelFilter);
                      }),
                )),
            //bottom button
            const Spacer(),
            Align(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            var schoolLevelItem = "";
                            var schoolLevelName = "";
                            var schoolLevelId = "";
                            if (analysisReportViewModel!.mapAllFilter
                                    .containsKey(5) ||
                                analysisReportViewModel!
                                    .mapSchoolLevelFilter.isEmpty) {
                              changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedSchoolLevel,
                                  "Tất cả cấp học");
                              analysisReportViewModel!.changeValueDataId(
                                  "",
                                  analysisReportViewModel!
                                      .rxSelectedSchoolLevelID);
                            } else {
                              analysisReportViewModel!.mapSchoolLevelFilter
                                  .forEach((key, value) {
                                schoolLevelItem += value;
                              });
                              var listId = schoolLevelItem.split(";");
                              for (var id in listId) {
                                for (var item in analysisReportViewModel!
                                    .rxListSchoolLevel) {
                                  if (item.id == id) {
                                    schoolLevelName += "${item.name!};";
                                    schoolLevelId += "${item.id!};";
                                    analysisReportViewModel!.changeValueDataId(
                                        schoolLevelId,
                                        analysisReportViewModel!
                                            .rxSelectedSchoolLevelID);
                                  }
                                }
                              }
                              if (schoolLevelName != "") {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolLevel,
                                    schoolLevelName.substring(
                                        0, schoolLevelName.length - 1));
                              } else {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolLevel,
                                    "");
                              }
                            }

                            Get.back();
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class FilterPointBottomSheet extends StatelessWidget {
  const FilterPointBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          //search
          //tat ca don vi
          FilterAllItem(
              "Tất cả điểm", 6, analysisReportViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.32,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listPoint.length,
                itemBuilder: (context, index) {
                  var item = listPoint[index];
                  return FilterItem(item, item, index,
                      analysisReportViewModel!.mapPointFilter);
                }),
          ),
          //bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (analysisReportViewModel!.mapAllFilter
                              .containsKey(6)) {
                            analysisReportViewModel!
                                .changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedPoint,
                                "Tất cả điểm");
                          } else {
                            var agencies = "";
                            var agenciesName = "";
                            analysisReportViewModel!.mapPointFilter
                                .forEach((key, value) {
                              agencies += value;
                            });
                            var listId = agencies.split(";");
                            for (var id in listId) {
                              for (var item in listPoint ){
                                if (item == id) {
                                  agenciesName += "${item};";
                                }
                              }
                            }
                            if (agenciesName != "") {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedPoint,
                                  agenciesName.substring(
                                      0, agenciesName.length - 1));
                            } else {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedPoint,
                                  "");
                            }
                          }
                          Get.back();
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class FilterSubjectBottomSheet extends StatelessWidget {
  const FilterSubjectBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          //search
          //tat ca don vi
          FilterAllItem(
              "Tất cả môn học", 7, analysisReportViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.32,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listSubject.length,
                itemBuilder: (context, index) {
                  var item = listSubject[index];
                  return FilterItem(item, item, index,
                      analysisReportViewModel!.mapSubjectFilter);
                }),
          ),
          //bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (analysisReportViewModel!.mapAllFilter
                              .containsKey(7)) {
                            analysisReportViewModel!
                                .changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedSubject,
                                "Tất cả môn học");
                          } else {
                            var agencies = "";
                            var agenciesName = "";
                            analysisReportViewModel!.mapSubjectFilter
                                .forEach((key, value) {
                              agencies += value;
                            });
                            var listId = agencies.split(";");
                            for (var id in listId) {
                              for (var item in listSubject) {
                                if (item== id) {
                                  agenciesName += "${item!};";
                                }
                              }
                            }
                            if (agenciesName != "") {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedSubject,
                                  agenciesName.substring(
                                      0, agenciesName.length - 1));
                            } else {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedSubject,
                                  "");
                            }
                          }
                          Get.back();
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class FilterClassBottomSheet extends StatelessWidget {
  const FilterClassBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          //search
          //tat ca don vi
          FilterAllItem(
              "Tất cả lớp", 8, analysisReportViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.32,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listAllClass.length,
                itemBuilder: (context, index) {
                  var item = listAllClass[index];
                  return FilterItem(item, item, index,
                      analysisReportViewModel!.mapClassFilter);
                }),
          ),
          //bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (analysisReportViewModel!.mapAllFilter
                              .containsKey(8)) {
                            analysisReportViewModel!
                                .changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClass,
                                "Tất cả lớp");
                          } else {
                            var agencies = "";
                            var agenciesName = "";
                            analysisReportViewModel!.mapClassFilter
                                .forEach((key, value) {
                              agencies += value;
                            });
                            var listId = agencies.split(";");
                            for (var id in listId) {
                              for (var item in listAllClass) {
                                if (item == id) {
                                  agenciesName += "${item};";
                                }
                              }
                            }
                            if (agenciesName != "") {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedClass,
                                  agenciesName.substring(
                                      0, agenciesName.length - 1));
                            } else {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedClass,
                                  "");
                            }
                          }
                          Get.back();
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class FilterClassificationBottomSheet extends StatelessWidget {
  const FilterClassificationBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          //search
          //tat ca don vi
          FilterAllItem(
              "Tất cả học lực", 9, analysisReportViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.32,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listClassification.length,
                itemBuilder: (context, index) {
                  var item = listClassification[index];
                  return FilterItem(item, item, index,
                      analysisReportViewModel!.mapClasstifiFilter);
                }),
          ),
          //bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: buttonFilterWhite,
                        child: const Text('Đóng')),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (analysisReportViewModel!.mapAllFilter
                              .containsKey(9)) {
                            analysisReportViewModel!
                                .changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClasstifi,
                                "Tất cả học lực");
                          } else {
                            var agencies = "";
                            var agenciesName = "";
                            analysisReportViewModel!.mapClasstifiFilter
                                .forEach((key, value) {
                              agencies += value;
                            });
                            var listId = agencies.split(";");
                            for (var id in listId) {
                              for (var item in listClassification) {
                                if (item == id) {
                                  agenciesName += "${item!};";
                                }
                              }
                            }
                            if (agenciesName != "") {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedClasstifi,
                                  agenciesName.substring(
                                      0, agenciesName.length - 1));
                            } else {
                              analysisReportViewModel!
                                  .changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedClasstifi,
                                  "");
                            }
                          }
                          Get.back();
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}