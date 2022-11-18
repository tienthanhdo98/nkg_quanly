
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'analysis_report_filter_screen.dart';
import 'analysis_report_viewmodel.dart';
import 'chart/analysis_report_stacked_chart.dart';

class AnalysisReportEducationScreen extends GetView {
  AnalysisReportEducationScreen({Key? key}) : super(key: key);
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    analysisReportViewModel.getDataUniversalEducationScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget('Thống kê Báo cáo phổ cập giáo dục', context),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
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
                              Get.to(() => ReportUniversalEducationFilterScreen(
                                    analysisReportViewModel:
                                        analysisReportViewModel,
                                    onClick: () {
                                      analysisReportViewModel.getUniversalEducationChart(analysisReportViewModel.rxSelectedRegionID.value,analysisReportViewModel.rxSelectedSchoolYearID.value);
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Khu vực',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(
                                      analysisReportViewModel
                                          .rxSelectedRegion.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline5)))
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Năm học',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(
                                      analysisReportViewModel
                                          .rxSelectedSchoolYear.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline5)))
                            ],
                          ),
                        )
                      ],
                    )),
              ]),
            ),
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
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: analysisReportViewModel
                              .rxListChartAnalysis.length,
                          itemBuilder: (context, index) {
                            var listChart = analysisReportViewModel
                                .rxListChartAnalysis
                                .elementAt(index)
                                .items;
                            var title = analysisReportViewModel
                                .rxListChartAnalysis
                                .elementAt(index)
                                .chartName;
                            if (title != null &&
                                listChart!.isNotEmpty == true) {
                              var item = analysisReportViewModel
                                  .rxListChartAnalysis[index].items;
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
                                                    convertNameToEducationChartAnalysicReportViName(
                                                        title)),
                                                style: Theme.of(context)
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
                                                    .getUniversalEducationChart(
                                                        analysisReportViewModel
                                                            .rxSelectedRegionID
                                                            .value,
                                                        analysisReportViewModel
                                                            .rxSelectedProvinceId
                                                            .value);
                                              },
                                              child: Image.asset(
                                                  "assets/icons/ic_refresh.png",
                                                  width: 16,
                                                  height: 16),
                                            )
                                          ],
                                        ),
                                        AnalysisReportStackedChartWidget(
                                          item,
                                          key: UniqueKey(),
                                        )
                                      ]),
                                    ),
                                    context),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          })
                      : loadingWidget(context)),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
