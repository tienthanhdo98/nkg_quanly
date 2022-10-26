import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/api.dart';
import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'analysis_pie_chart2.dart';
import 'analysis_report_filter_screen.dart';
import 'analysis_report_stacked_chart.dart';
import 'analysis_report_viewmodel.dart';

class AnalysisReportEducationScreen extends GetView {
  AnalysisReportEducationScreen({Key? key}) : super(key: key);
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    analysisReportViewModel.getDataEducationScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget('Thống kê Báo cáo phổ cập giáo dục', context),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Khu vực: ",
                        style: CustomTextStyle.grayColorTextStyle,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: kDarkGray,
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                        child: InkWell(
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
                                      height: MediaQuery.of(context).size.height*0.62,
                                      child: FilterRegionBottomSheet(
                                          analysisReportViewModel,TYPE_SCREEN_EDUCATION));
                                },
                              );
                            },
                            child: Obx(() => borderTextFilterEOffice(analysisReportViewModel
                                    .rxSelectedRegion.value,
                                context))),

                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Năm học: ",
                        style: CustomTextStyle.grayColorTextStyle,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: kDarkGray,
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                        child: InkWell(
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
                                      height: MediaQuery.of(context).size.height*0.7,
                                      child: FilterSchoolYearBottomSheet(
                                          analysisReportViewModel,TYPE_SCREEN_EDUCATION));
                                },
                              );
                            },
                            child: Obx(() =>
                                borderTextFilterEOffice((analysisReportViewModel
                                .rxSelectedSchoolYear.value != "") ? analysisReportViewModel
                                    .rxSelectedSchoolYear.value : "Chọn năm học",
                                context))),

                      ),
                    ]),
              ),

            ],
          ),
          Expanded(
            child: Container(
              color: kDarkGray,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Obx(() => (analysisReportViewModel.rxIsLoadingData.value == false) ?
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: analysisReportViewModel
                          .rxListEducationChart.length,
                      itemBuilder: (context, index) {
                        var listChart = analysisReportViewModel
                            .rxListEducationChart
                            .elementAt(index)
                            .items;
                        var title = analysisReportViewModel
                            .rxListEducationChart
                            .elementAt(index)
                            .chartName;
                        if(title != null &&
                            listChart!.isNotEmpty == true){
                          var item = analysisReportViewModel
                             .rxListEducationChart[index].items;
                          return Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: borderItem(
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 15, 15, 15),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(checkingStringNull(convertNameToEducationChartAnalysicReportViName(title)),
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
                                            analysisReportViewModel.getEducationChart(analysisReportViewModel.rxSelectedRegionID.value, analysisReportViewModel.rxSelectedSchoolYearID.value);

                                          },
                                          child: Image.asset(
                                              "assets/icons/ic_refresh.png",
                                              width: 16,
                                              height: 16),
                                        )
                                      ],
                                    ),
                                    AnalysisReportStackedChartWidget(
                                        item,key: UniqueKey(),)
                                  ]),
                                ),
                                context),
                          );
                        }
                        else
                        {
                          return const SizedBox.shrink();
                        }}) : loadingIcon()),
                ),
              ),
            ),
          )

        ],
      )),
    );
  }
}



var listReportType = [
  "Thống kê trường học, phòng học, lớp học",
  "Quy mô trẻ em",
  "Tình trạng dinh dưỡng trẻ em",
  "Cán bộ quản lý, giáo viên và nhân viên cấp mầm non"
];

