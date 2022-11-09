import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/report/pie_chart_report.dart';
import 'package:nkg_quanly/ui/report/report_in_menuhome/report_in_menuhome_list.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'collum_chart_report.dart';

class ReportScreen extends GetView {
  String? header;
  String? icon;

  final reportViewModel = Get.put(ReportViewModel());

  ReportScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            headerWidget(header!, context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Stack(
                    children: [
                      Image.asset("assets/bgtophome.png",
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: border(
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Obx(() => Column(children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Tổng báo cáo',
                                                style: CustomTextStyle
                                                    .robotow400s12TextStyle),
                                            Text(
                                              checkingNullNumberAndConvertToString(
                                                  reportViewModel
                                                      .rxReportStatisticTotal
                                                      .value
                                                      .tong),
                                              style: const TextStyle(
                                                  color: kBlueButton,
                                                  fontSize: 40),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Image.asset(
                                              icon!,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 3 / 2,
                                        mainAxisSpacing: 0,
                                        crossAxisCount: 3,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Đã tiếp nhận',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                  checkingNullNumberAndConvertToString(
                                                      reportViewModel
                                                          .rxReportStatisticTotal
                                                          .value
                                                          .daTiepNhan),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Đã giao',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                checkingNullNumberAndConvertToString(
                                                    reportViewModel
                                                        .rxReportStatisticTotal
                                                        .value
                                                        .daGiao),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Đúng hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                checkingNullNumberAndConvertToString(
                                                    reportViewModel
                                                        .rxReportStatisticTotal
                                                        .value
                                                        .dungHan),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Chưa đến hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                checkingNullNumberAndConvertToString(
                                                    reportViewModel
                                                        .rxReportStatisticTotal
                                                        .value
                                                        .chuaDenHan),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Sớm hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                checkingNullNumberAndConvertToString(
                                                    reportViewModel
                                                        .rxReportStatisticTotal
                                                        .value
                                                        .somHan),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Quá hạn',
                                                  style: CustomTextStyle
                                                      .robotow400s12TextStyle),
                                              Text(
                                                checkingNullNumberAndConvertToString(
                                                    reportViewModel
                                                        .rxReportStatisticTotal
                                                        .value
                                                        .quaHan),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ])),
                            ),
                            context),
                      )
                    ],
                  ),
                  //button switch chart
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Obx(() => ElevatedButton(
                                style:
                                    reportViewModel.selectedChartButton.value ==
                                            0
                                        ? activeButtonStyle
                                        : unActiveButtonStyle,
                                onPressed: () async {
                                  await reportViewModel
                                      .getFilterForChart(apiGetReportChart0);
                                  reportViewModel.selectedChartButton(0);
                                },
                                child: const Text("Mức độ"),
                              )),
                        )),
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Obx(
                                  () => ElevatedButton(
                                    style: reportViewModel
                                                .selectedChartButton.value ==
                                            1
                                        ? activeButtonStyle
                                        : unActiveButtonStyle,
                                    onPressed: () async {
                                      await reportViewModel.getFilterForChart(
                                          apiGetReportChart1);
                                      reportViewModel.swtichChartButton(1);
                                    },
                                    child: const Text("Trạng thái"),
                                  ),
                                )))
                      ],
                    ),
                  ),
                  //chart
                  Obx(() => reportChartData(reportViewModel)),
                  //bottom button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ReportInMenuHomeList(
                                  header: header,
                                ));
                          },
                          child: Text('Xem danh sách $header'),
                          style: bottomButtonStyle,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget reportChartData(ReportViewModel reportViewModel) {
  if (reportViewModel.rxDocumentFilterModel.value.items != null) {
    if (reportViewModel.selectedChartButton.value == 0) {
      return CollumChartReport(
          documentFilterModel: reportViewModel.rxDocumentFilterModel.value);
    } else {
      return PieChartReport(
        reportStatistic: reportViewModel.rxReportStatisticTotal.value,
      );
    }
  } else {
    return SizedBox(
      height: 200,
    );
  }
}
