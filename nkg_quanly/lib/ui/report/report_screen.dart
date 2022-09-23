import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/const/api.dart';
import 'package:nkg_quanly/ui/report/pie_chart_report.dart';
import 'package:nkg_quanly/ui/report/report_list.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';

import '../../const.dart';
import '../../model/report_model/report_statistic_model.dart';
import '../theme/theme_data.dart';
import 'collum_chart_report.dart';

class ReportScreen extends GetView {
  String? header;
  String? icon;

  final homeController = Get.put(ReportViewModel());

  ReportScreen({Key? key, this.header, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.getReportStatistic(),
          builder: (context, AsyncSnapshot<ReportStatisticModel> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Stack(
                  children: [
                    Image.asset("assets/bgtophome.png",
                        height: 220, width: double.infinity, fit: BoxFit.cover),
                    headerWidget(header!, context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                      child: border(
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tổng báo cáo',style: CustomTextStyle.robotow400s12TextStyle),
                                      Text(
                                        snapshot.data!.tong.toString(),
                                        style: const TextStyle(
                                            color: kBlueButton, fontSize: 40),
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
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Đã tiếp nhận',style: CustomTextStyle.robotow400s12TextStyle),
                                      Text(
                                          snapshot.data!.daTiepNhan.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Đã giao',style: CustomTextStyle.robotow400s12TextStyle),
                                      Text(
                                        snapshot.data!.daGiao.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ]),
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
                              style: homeController.selectedChartButton.value == 0
                                  ? activeButtonStyle
                                  : unActiveButtonStyle,
                              onPressed: () async {
                                await homeController
                                    .getFilterForChart(apiGetReportChart0);
                                homeController.selectedChartButton(0);

                              },
                              child: const Text("Mức độ"),
                            )),
                      )),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Obx(
                                () => ElevatedButton(
                                  style:
                                      homeController.selectedChartButton.value == 1
                                          ? activeButtonStyle
                                          : unActiveButtonStyle,
                                  onPressed: ()  async {
                                   await homeController
                                        .getFilterForChart(apiGetReportChart1);
                                    homeController.swtichChartButton(1);

                                  },
                                  child: const Text("Trạng thái"),
                                ),
                              )))
                    ],
                  ),
                ),
                //chart
                Obx(() => (homeController.selectedChartButton.value == 0)
                    ? Obx(() => CollumChartReport(
                        documentFilterModel:
                            homeController.rxDocumentFilterModel.value))
                    : Obx(() =>PieChartReport(
                        documentFilterModel:
                            homeController.rxDocumentFilterModel.value,
                      ))),
                //bottom button
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ReportList(
                                  header: header,
                                ));
                          },
                          child: Text('Xem danh sách $header'),
                          style: bottomButtonStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
