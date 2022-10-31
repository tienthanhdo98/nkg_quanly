import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../analysis_collum_chart2.dart';
import '../analysis_report_filter_screen.dart';
import '../analysis_report_viewmodel.dart';

class AnalysisReportCoSoVatChatMenu extends GetView {
  AnalysisReportCoSoVatChatMenu({Key? key}) : super(key: key);
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    analysisReportViewModel.getDataPreSchoolScreen();
    analysisReportViewModel.getDataCoSoVatChat();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Báo cáo cơ sở vật chất", context),
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
                                Get.to(() => AnalysisReportCSVCFilterScreen(
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(children: [
                    borderItem(
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Thống kê số lượng trường học đạt tiêu chí về cơ sở vật chất",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                      "assets/icons/ic_refresh.png",
                                      width: 16,
                                      height: 16),
                                )
                              ],
                            ),
                            AnalysisChartCollum2Widget(
                              key: UniqueKey(),
                            )
                          ]),
                        ),
                        context),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0)),
                    borderItem(
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Thống kê tỷ lệ trường học đạt tiêu chí về CSVC",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                      "assets/icons/ic_refresh.png",
                                      width: 16,
                                      height: 16),
                                )
                              ],
                            ),
                            AnalysisChartCollum2Widget(
                              key: UniqueKey(),
                            )
                          ]),
                        ),
                        context)
                  ]),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
