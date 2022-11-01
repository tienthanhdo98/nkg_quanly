
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../analysis_collum_chart.dart';
import '../../theme/theme_data.dart';

import '../analysis_report_filter_screen.dart';
import '../analysis_report_viewmodel.dart';

class AnalysisReportDTCSMenu extends GetView {
  AnalysisReportDTCSMenu({Key? key}) : super(key: key);
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    analysisReportViewModel.getDataPreSchoolScreen();
    //analysisReportViewModel.getDataCoSoVatChat();
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
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedRegion.value,maxLines: 2,overflow: TextOverflow.ellipsis,
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
                                  child:Obx(() =>  Text(analysisReportViewModel.rxSelectedProvince.value,maxLines: 2,overflow: TextOverflow.ellipsis,
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
                                  child: Obx(() =>Text(analysisReportViewModel.rxSelectedSchoolYear.value,maxLines: 2,overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Con em DT thiểu số',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text("1290",
                                            style: textBlueCountTotalStyle))
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Con em quân nhân',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text("780",
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 32,
                                        child: Text('Con em thương bệnh binh, người có công',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5),
                                      ),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text("90",
                                              style: textBlueCountTotalStyle))
                                    ],
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 32,
                                        child: Text(
                                            'Con em hộ nghèo hoặc có điều kiện khó khăn',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5),
                                      ),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text("180",
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
                                Text('Trẻ em, học sinh khuyết tật',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5),
                                const Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text("780",
                                        style: textBlueCountTotalStyle))
                              ],
                            ),
                          ),
                        ],
                      ),
                      borderItem(
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                15, 15, 15, 15),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      checkingStringNull(
                                              "Thống kê số lượng học sinh theo dạng đối tượng"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1,
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          20, 0, 0, 0)),
                                  InkWell(
                                    onTap: () {
                                      analysisReportViewModel
                                          .getChartPreSchool("2",
                                          "", "1", "", "");
                                    },
                                    child: Image.asset(
                                        "assets/icons/ic_refresh.png",
                                        width: 16,
                                        height: 16),
                                  )
                                ],
                              ),
                              // AnalysisCollumChartWidget(
                              //   key: UniqueKey(),
                              // )
                            ]),
                          ),
                          context)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
