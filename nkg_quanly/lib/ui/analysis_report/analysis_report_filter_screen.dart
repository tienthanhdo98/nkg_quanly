import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../const/api.dart';
import '../theme/theme_data.dart';
import 'analysis_report_viewmodel.dart';

const TYPE_SCREEN_EDUCATION = "education";

class AnalysisReportFilterScreen extends GetView {
  const AnalysisReportFilterScreen(
      {required this.analysisReportViewModel, required this.onClick, Key? key})
      : super(key: key);
  final AnalysisReportViewModel analysisReportViewModel;
  final VoidCallback onClick;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        Text(
                          "Bộ lọc",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            analysisReportViewModel.clearSelectedFilter();
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
                              (analysisReportViewModel
                                          .rxSelectedSemester.value !=
                                      "")
                                  ? analysisReportViewModel
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
                              (analysisReportViewModel.rxSelectedRegion.value !=
                                      "")
                                  ? analysisReportViewModel
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
                              (analysisReportViewModel
                                          .rxSelectedProvince.value !=
                                      "")
                                  ? analysisReportViewModel
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
                                      analysisReportViewModel,
                                    ));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel
                                          .rxSelectedSchoolYear.value !=
                                      "")
                                  ? analysisReportViewModel
                                      .rxSelectedSchoolYear.value
                                  : "Chọn năm học",
                              context))),

                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                onClick();
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

class ReportUniversalEducationFilterScreen extends GetView {
  const ReportUniversalEducationFilterScreen(
      {required this.analysisReportViewModel, required this.onClick, Key? key})
      : super(key: key);
  final AnalysisReportViewModel analysisReportViewModel;
  final VoidCallback onClick;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        Text(
                          "Bộ lọc",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            analysisReportViewModel.clearSelectedFilter();
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
              ),
              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              (analysisReportViewModel.rxSelectedRegion.value !=
                                      "")
                                  ? analysisReportViewModel
                                      .rxSelectedRegion.value
                                  : "Chọn khu vực",
                              context))),
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
                                      analysisReportViewModel,
                                    ));
                              },
                            );
                          },
                          child: Obx(() => borderTextFilterEOffice(
                              (analysisReportViewModel
                                          .rxSelectedSchoolYear.value !=
                                      "")
                                  ? analysisReportViewModel
                                      .rxSelectedSchoolYear.value
                                  : "Chọn năm học",
                              context))),
                      // const Spacer(),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                onClick();
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

class AnalysisReportInfrastructureFilterScreen extends GetView {
  const AnalysisReportInfrastructureFilterScreen(this.analysisReportViewModel,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
                                        analysisReportViewModel));
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

                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                analysisReportViewModel!
                                    .getListChartInfrastructure(
                                        analysisReportViewModel!
                                            .rxSelectedSchoolLevelID.value,
                                        analysisReportViewModel!
                                            .rxSelectedRegionID.value,
                                        analysisReportViewModel!
                                            .rxSelectedProvinceId.value,
                                        analysisReportViewModel!
                                            .rxSelectedSchoolYearID.value);
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
  const AnalysisReportEducationQualityFilterScreen(this.analysisReportViewModel,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: FilterSchoolYearBottomSheet(
                                          analysisReportViewModel));
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.55,
                                      child: FilterClassificationBottomSheet(
                                          analysisReportViewModel));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(
                                (analysisReportViewModel!
                                            .rxSelectedClassification.value !=
                                        "")
                                    ? analysisReportViewModel!
                                        .rxSelectedClassification.value
                                    : "Chọn học lực",
                                context))),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  analysisReportViewModel!
                                      .getListQualityEducationByType("0");
                                  analysisReportViewModel!
                                      .changeStateLoadingData(true);
                                  analysisReportViewModel!.scrollToTop();
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

//vao cao chi tiet chat luong giao duc
class ReportDetailEduQualityFilterScreen extends GetView {
  const ReportDetailEduQualityFilterScreen(this.analysisReportViewModel,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: FilterSchoolYearBottomSheet(
                                          analysisReportViewModel));
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

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  analysisReportViewModel!
                                      .getListQualityEducationByType("1");
                                  analysisReportViewModel!
                                      .changeStateLoadingData(true);
                                  analysisReportViewModel!.scrollToTop();
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
  const XepLoaiNangLucPhamChatFilterScreen(this.analysisReportViewModel,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                analysisReportViewModel!
                                    .getListQualityEducationByType("2");
                                analysisReportViewModel!
                                    .changeStateLoadingData(true);
                                analysisReportViewModel!.scrollToTop();
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

class KhenThuongFilterScreen extends GetView {
  const KhenThuongFilterScreen(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_arrow_back.png',
                          width: 18,
                          height: 18,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
                                        analysisReportViewModel));
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
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                            child: ElevatedButton(
                              onPressed: () {
                                analysisReportViewModel!
                                    .getListQualityEducationByType("3");
                                analysisReportViewModel!
                                    .changeStateLoadingData(true);
                                analysisReportViewModel!.scrollToTop();
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

//hoc ki
class FilterSemesterBottomSheet extends StatelessWidget {
  const FilterSemesterBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: ListView(shrinkWrap: true, children: [
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
          const Spacer(),
          Row(
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
                          changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedSemester,
                              "Tất cả học kỳ");
                          changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedSemesterId,
                              "");
                        } else {
                          var semester = "";
                          var semesterName = "";
                          var semesterID = "";
                          analysisReportViewModel!.mapSemesterFilter
                              .forEach((key, value) {
                            semester += value;
                          });
                          var listId = semester.split(";");
                          for (var id in listId) {
                            for (var item in analysisReportViewModel!.rxListSemester) {
                              if (item.id == id) {
                                semesterName += "${item.name!};";
                                semesterID += "${item.id!};";
                              }
                            }
                          }
                          if (semesterName != "") {
                            changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSemester,
                                semesterName.substring(
                                    0, semesterName.length - 1));
                            changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSemesterId,
                                semesterID.substring(0, semesterID.length - 1));
                          } else {
                            changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSemester,
                                "");
                            changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSemesterId,
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
          )
        ]),
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
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
                          hintStyle: TextStyle(color: kDarkGray, fontSize: 14),
                          hintText: 'Tìm kiếm tỉnh. thành phố...',
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
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
              height: MediaQuery.of(context).size.height * 0.52,
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      analysisReportViewModel!.rxListProvinceByRegion.length,
                  itemBuilder: (context, index) {
                    var item =
                        analysisReportViewModel!.rxListProvinceByRegion[index];
                    return FilterItem(item.name!, item.id!, index,
                        analysisReportViewModel!.mapProvinceFilter);
                  })),
            ),
            //bottom button
            const Spacer(),
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
                             changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedProvinceId,
                                      "");
                            } else {
                              var province = "";
                              var provinceName = "";
                              var provinceId = "";
                              analysisReportViewModel!.mapProvinceFilter
                                  .forEach((key, value) {
                                province += value;
                              });
                              var listId = province.split(";");
                              for (var id in listId) {
                                for (var item in analysisReportViewModel!
                                    .rxListProvinceByRegion) {
                                  if (item.id == id) {
                                    provinceName += "${item.name!};";
                                    provinceId += "${item.id!};";
                                  }
                                }
                              }
                              if (provinceName != "") {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!.rxSelectedProvince,
                                    provinceName.substring(
                                        0, provinceName.length - 1));
                               changeValueSelectedFilter(
                                        analysisReportViewModel!
                                            .rxSelectedProvinceId,
                                        provinceId.substring(
                                            0, provinceId.length - 1));
                              } else {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!.rxSelectedProvince,
                                    "");
                               changeValueSelectedFilter(
                                        analysisReportViewModel!
                                            .rxSelectedProvinceId,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                        hintText: 'Tìm kiếm khu vực...',
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      onSubmitted: (value) {
                        analysisReportViewModel!
                            .searchRegionInFilterList(value);
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
                             changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedRegionID,
                                      regionID);
                              analysisReportViewModel!
                                  .getListProvinceByRegion();
                            }
                          });
                          changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedRegion,
                              region);
                          if (typeScreen == TYPE_SCREEN_EDUCATION) {
                            analysisReportViewModel!.getUniversalEducationChart(
                                analysisReportViewModel!
                                    .rxSelectedRegionID.value,
                                analysisReportViewModel!
                                    .rxSelectedSchoolYearID.value);
                            analysisReportViewModel!.scrollToTop();
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
    );
  }
}

class FilterSchoolYearBottomSheet extends StatelessWidget {
  const FilterSchoolYearBottomSheet(this.analysisReportViewModel, {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                             changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedSchoolYearID,
                                      "");
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
                                  }
                                }
                              }
                              if (schoolYearName != "") {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolYear,
                                    schoolYearName.substring(
                                        0, schoolYearName.length - 1));
                                changeValueSelectedFilter(
                                        analysisReportViewModel!
                                            .rxSelectedSchoolYearID,
                                        schoolYearId.substring(
                                            0, schoolYearId.length - 1));
                              } else {
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolYear,
                                    "");
                                changeValueSelectedFilter(
                                    analysisReportViewModel!
                                        .rxSelectedSchoolYearID,
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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                  height: MediaQuery.of(context).size.height * 0.25,
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
            Row(
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
                                analysisReportViewModel!.rxSelectedSchoolLevel,
                                "Tất cả cấp học");
                          changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedSchoolLevelID,
                                "");
                            schoolLevelId = "1;2;3;4;";
                            analysisReportViewModel!.getListFilterWithParam(
                                schoolLevelId,
                                getClass,
                                analysisReportViewModel!.rxListClass);
                            analysisReportViewModel!.getListFilterWithParam(
                                schoolLevelId,
                                getSubject,
                                analysisReportViewModel!.rxListSubject);
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
                                  changeValueSelectedFilter(
                                          analysisReportViewModel!
                                              .rxSelectedSchoolLevelID,
                                          schoolLevelId.substring(
                                              0, schoolLevelId.length - 1));
                                }
                              }
                            }
                            if (schoolLevelName != "") {
                              changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedSchoolLevel,
                                  schoolLevelName.substring(
                                      0, schoolLevelName.length - 1));
                              analysisReportViewModel!.getListFilterWithParam(
                                  schoolLevelId,
                                  getClass,
                                  analysisReportViewModel!.rxListClass);
                              analysisReportViewModel!.getListFilterWithParam(
                                  schoolLevelId,
                                  getSubject,
                                  analysisReportViewModel!.rxListSubject);
                            } else {
                              changeValueSelectedFilter(
                                  analysisReportViewModel!
                                      .rxSelectedSchoolLevel,
                                  "");
                             changeValueSelectedFilter(
                                      analysisReportViewModel!
                                          .rxSelectedSchoolLevelID,
                                      "");
                              schoolLevelId = "1;2;3;4;";
                              analysisReportViewModel!.getListFilterWithParam(
                                  schoolLevelId,
                                  getClass,
                                  analysisReportViewModel!.rxListClass);
                              analysisReportViewModel!.getListFilterWithParam(
                                  schoolLevelId,
                                  getSubject,
                                  analysisReportViewModel!.rxListSubject);
                            }
                          }

                          Get.back();
                        },
                        style: buttonFilterBlue,
                        child: const Text('Áp dụng')),
                  ),
                )
              ],
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: analysisReportViewModel!.rxListPoint.length,
                itemBuilder: (context, index) {
                  var item = analysisReportViewModel!.rxListPoint[index];
                  return FilterItem(item.name!, item.id!, index,
                      analysisReportViewModel!.mapPointFilter);
                }),
          ),
          //bottom button
          const Spacer(),
          Row(
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
                         changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedPoint,
                              "Tất cả điểm");
                         changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedPointId, "");
                        } else {
                          var point = "";
                          var pointName = "";
                          var pointId = "";
                          analysisReportViewModel!.mapPointFilter
                              .forEach((key, value) {
                            point += value;
                          });
                          var listId = point.split(";");
                          for (var id in listId) {
                            for (var item
                                in analysisReportViewModel!.rxListPoint) {
                              if (item.id == id) {
                                pointName += "${item.name};";
                                pointId += "${item.id};";
                              }
                            }
                          }
                          if (pointName != "") {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedPoint,
                                pointName.substring(0, pointName.length - 1));
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedPointId,
                                pointId.substring(0, pointId.length - 1));
                          } else {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedPoint, "");
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedPointId, "");
                          }
                        }
                        Get.back();
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: analysisReportViewModel!.rxListSubject.length,
                itemBuilder: (context, index) {
                  var item = analysisReportViewModel!.rxListSubject[index];
                  return FilterItem(item.name!, item.id!, index,
                      analysisReportViewModel!.mapSubjectFilter);
                }),
          ),
          //bottom button
          const Spacer(),
          Row(
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
                        changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedSubject,
                              "Tất cả môn học");
                        changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedSubjectID, "");
                        } else {
                          var agencies = "";
                          var agenciesName = "";
                          var agenciesID = "";
                          analysisReportViewModel!.mapSubjectFilter
                              .forEach((key, value) {
                            agencies += value;
                          });
                          var listId = agencies.split(";");
                          for (var id in listId) {
                            for (var item
                                in analysisReportViewModel!.rxListSubject) {
                              if (item.id == id) {
                                agenciesName += "${item.name};";
                                agenciesID += "${item.id};";
                              }
                            }
                          }
                          if (agenciesName != "") {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSubject,
                                agenciesName.substring(
                                    0, agenciesName.length - 1));
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSubjectID,
                                agenciesID.substring(0, agenciesID.length - 1));
                          } else {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSubject, "");
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedSubjectID,
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
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: Column(children: [
          //search
          //tat ca don vi
          FilterAllItem("Tất cả lớp", 8, analysisReportViewModel!.mapAllFilter),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                thickness: 1,
                color: kgray,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: analysisReportViewModel!.rxListClass.length,
                itemBuilder: (context, index) {
                  var item = analysisReportViewModel!.rxListClass[index];
                  return FilterItem(item.name!, item.id!, index,
                      analysisReportViewModel!.mapClassFilter);
                }),
          ),
          //bottom button
          const Spacer(),
          Row(
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
                        changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedClass,
                              "Tất cả lớp");
                        changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedClassId, "");
                        } else {
                          var agencies = "";
                          var className = "";
                          var classId = "";
                          analysisReportViewModel!.mapClassFilter
                              .forEach((key, value) {
                            agencies += value;
                          });
                          var listId = agencies.split(";");
                          for (var id in listId) {
                            for (var item
                                in analysisReportViewModel!.rxListClass) {
                              if (item.id == id) {
                                className += "${item.name};";
                                classId += "${item.id};";
                              }
                            }
                          }
                          if (className != "") {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedClass,
                                className.substring(0, className.length - 1));
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedClassId,
                                classId.substring(0, classId.length - 1));
                          } else {
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedClass, "");
                          changeValueSelectedFilter(
                                analysisReportViewModel!.rxSelectedClassId, "");
                          }
                        }
                        Get.back();
                      },
                      style: buttonFilterBlue,
                      child: const Text('Áp dụng')),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class FilterClassificationBottomSheet extends StatelessWidget {
  const FilterClassificationBottomSheet(this.analysisReportViewModel,
      {Key? key})
      : super(key: key);
  final AnalysisReportViewModel? analysisReportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: analysisReportViewModel!.rxListClassification.length,
                itemBuilder: (context, index) {
                  var item =
                      analysisReportViewModel!.rxListClassification[index];
                  return FilterItem(item.name!, item.id!, index,
                      analysisReportViewModel!.mapClassificationFilter);
                }),
          ),
          //bottom button
          const Spacer(),
          Row(
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
                        changeValueSelectedFilter(
                              analysisReportViewModel!.rxSelectedClassification,
                              "Tất cả học lực");
                        changeValueSelectedFilter(
                              analysisReportViewModel!
                                  .rxSelectedClassificationID,
                              "");
                        } else {
                          var classification = "";
                          var classificationName = "";
                          var classificationId = "";
                          analysisReportViewModel!.mapClassificationFilter
                              .forEach((key, value) {
                            classification += value;
                          });
                          var listId = classification.split(";");
                          for (var id in listId) {
                            for (var item in analysisReportViewModel!
                                .rxListClassification) {
                              if (item.id == id) {
                                classificationName += "${item.name};";
                                classificationId += "${item.id};";
                              }
                            }
                          }
                          if (classificationName != "") {
                          changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClassification,
                                classificationName.substring(
                                    0, classificationName.length - 1));

                          changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClassificationID,
                                classificationId.substring(
                                    0, classificationId.length - 1));
                          } else {
                          changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClassification,
                                "");
                          changeValueSelectedFilter(
                                analysisReportViewModel!
                                    .rxSelectedClassificationID,
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
          )
        ]),
      ),
    );
  }
}
