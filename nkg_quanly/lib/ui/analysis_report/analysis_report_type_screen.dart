import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'analysis_pie_chart.dart';
import 'analysis_report_filter_screen.dart';
import 'analysis_report_menu.dart';
import 'analysis_report_viewmodel.dart';

class AnalysisReportTypeMenu extends GetView {
  AnalysisReportTypeMenu(this.title, this.screenType, {Key? key})
      : super(key: key);
  final String title;
  String? filterType = "";
  final String screenType;

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    List<String> listScreen = checkListSceen(screenType);
    filterType = listScreen[0];
    analysisReportViewModel.getDataPreSchoolScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(title, context),
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
                                items: listScreen
                                    .map((value) =>
                                    DropdownMenuItem(
                                      child: SizedBox(
                                          width: MediaQuery
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
                                    listScreen.asMap().forEach((index,
                                        itemValue) {
                                      if (itemValue == value) {
                                        // analysisReportViewModel.getChartPreSchool(
                                        //     "${index + 1}", "", "", "", "");
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
                                    Get.to(() =>
                                        AnalysisReportFilterScreen(
                                            analysisReportViewModel));
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
                                      style: CustomTextStyle
                                          .grayColorTextStyle),
                                  Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Obx(() =>
                                          Text(analysisReportViewModel
                                              .rxSelectedRegion.value,
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
                                      style: CustomTextStyle
                                          .grayColorTextStyle),
                                  Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Obx(() =>
                                          Text(analysisReportViewModel
                                              .rxSelectedProvince.value,
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
                                      style: CustomTextStyle
                                          .grayColorTextStyle),
                                  Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Obx(() =>
                                          Text(analysisReportViewModel
                                              .rxSelectedSchoolYear.value,
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
                      ),
                    ]),
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                  color: kDarkGray,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Obx(() =>
                      (analysisReportViewModel
                          .rxIsLoadingData.value ==
                          false)
                          ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: analysisReportViewModel
                              .rxListPreSchoolChartModel.length,
                          itemBuilder: (context, index) {
                            var listChart = analysisReportViewModel
                                .rxListPreSchoolChartModel
                                .elementAt(index)
                                .items;
                            var title = analysisReportViewModel
                                .rxListPreSchoolChartModel
                                .elementAt(index)
                                .chartName;
                            if (title != null &&
                                listChart!.isNotEmpty == true) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: borderItem(
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 15),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                checkingStringNull(
                                                    convertNameToPreSchoolChartAnalysicReportViName(
                                                        title)),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0)),
                                            InkWell(
                                              onTap: () {
                                                analysisReportViewModel
                                                    .getChartPreSchool(
                                                    "2", "", "1", "", "");
                                              },
                                              child: Image.asset(
                                                  "assets/icons/ic_refresh.png",
                                                  width: 16,
                                                  height: 16),
                                            )
                                          ],
                                        ),
                                        AnalysisChartWidget(
                                          key: UniqueKey(),
                                          listPreSchoolChartItems: listChart,
                                        )
                                      ]),
                                    ),
                                    context),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          })
                          : loadingIcon()),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  List<String> checkListSceen(String? filterType) {
    print(filterType);
    List<String> listScreen = [];
    if (filterType == typePreSchool) {
      listScreen = listReportPreSchoolType;
    } else if (filterType == typePrimarySchool) {
      listScreen = listReportPriSchoolType;
    } else if (filterType == typeMiddleSchool) {
      listScreen = listReportMidSchoolType;
    } else if (filterType == typeHighSchool) {
      listScreen = listReportHighSchoolType;
    }
    return listScreen;
  }
}

var listReportPreSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp mầm non",
  "Quy mô trẻ em cấp mầm non",
  "Tình trạng dinh dưỡng trẻ em",
  "Cán bộ quản lý, giáo viên và nhân viên cấp mầm non"
];
var listReportPriSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp tiểu học",
  "Quy mô học sinh cấp tiểu học",
  "Cán bộ quản lý, giáo viên và nhân viên cấp tiểu học"
];
var listReportMidSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp THCS",
  "Quy mô học sinh cấp THCS",
  "Cán bộ quản lý, giáo viên và nhân viên cấp THCS"
];
var listReportHighSchoolType = [
  "Thống kê trường học, phòng học, lớp học cấp THPT",
  "Quy mô học sinh cấp THPT",
  "Cán bộ quản lý, giáo viên và nhân viên cấp THPT"
];

class chart {
  String? name;
  String? type;

  chart(this.name, this.type);
}

var listManNon = [chart(name, type),];
