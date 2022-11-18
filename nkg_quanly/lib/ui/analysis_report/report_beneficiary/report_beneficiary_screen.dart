import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/analysis_report/preschool_chart_model.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../analysis_report_filter_screen.dart';
import '../analysis_report_viewmodel.dart';
import '../chart/analysis_collum_chart.dart';


class ReportBeneficiaryScreen extends GetView {
  ReportBeneficiaryScreen({Key? key}) : super(key: key);
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    analysisReportViewModel.getDataBeneficiary();

    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Báo cáo đối tượng chính sách", context),
          Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
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
                                        analysisReportViewModel
                                            .getListChartBeneficiary(
                                          analysisReportViewModel
                                              .rxSelectedSemesterId.value,
                                          analysisReportViewModel
                                              .rxSelectedRegionID.value,
                                          analysisReportViewModel
                                              .rxSelectedProvinceId.value,
                                          analysisReportViewModel
                                              .rxSelectedSchoolYearID.value,
                                        );
                                        analysisReportViewModel.changeStateLoadingData(true);
                                        analysisReportViewModel
                                            .clearSelectedFilter();

                                       // print("report benefit");

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
                                  ChartDataWidget(
                                      analysisReportViewModel
                                          .rxListChartAnalysis[0].items!,
                                      context),
                                  borderItem(
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 15),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Thống kê số lượng học sinh theo dạng đối tượng",
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
                                                      .getListChartBeneficiary(
                                                    analysisReportViewModel
                                                        .rxSelectedSemesterId
                                                        .value,
                                                    analysisReportViewModel
                                                        .rxSelectedRegionID
                                                        .value,
                                                    analysisReportViewModel
                                                        .rxSelectedProvinceId
                                                        .value,
                                                    analysisReportViewModel
                                                        .rxSelectedSchoolYearID
                                                        .value,
                                                  );
                                                  analysisReportViewModel
                                                      .changeStateLoadingData(true);
                                                },
                                                child: Image.asset(
                                                    "assets/icons/ic_refresh.png",
                                                    width: 16,
                                                    height: 16),
                                              ),
                                            ],
                                          ),
                                          AnalysisCollumChartWidget(
                                            key: UniqueKey(),
                                            listChart: analysisReportViewModel
                                                .rxListChartAnalysis[0].items,
                                          )
                                        ]),
                                      ),
                                      context),
                                ],
                              )
                            : loadingWidget(context))),
              ),
            ),
          )
        ],
      )),
    );
  }
}

Widget ChartDataWidget(List<ChartChildItems> items, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(checkingStringNull(items[0].name),
                    style: Theme.of(context).textTheme.headline5),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(items[0].value),
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
                Text(checkingStringNull(items[1].name),
                    style: Theme.of(context).textTheme.headline5),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(checkingStringNull(items[1].value),
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
                    height: 32,
                    child: Text(checkingStringNull(items[2].name),
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(checkingStringNull(items[2].value),
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
                    height: 32,
                    child: Text(checkingStringNull(items[3].name),
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(checkingStringNull(items[3].value),
                          style: textBlueCountTotalStyle))
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(checkingStringNull(items[4].name),
                style: Theme.of(context).textTheme.headline5),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(checkingStringNull(items[4].value),
                    style: textBlueCountTotalStyle))
          ],
        ),
      ),
    ],
  );
}
