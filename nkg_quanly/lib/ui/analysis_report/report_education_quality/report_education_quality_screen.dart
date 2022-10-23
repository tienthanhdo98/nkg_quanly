import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_filter_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../analysis_pie_chart.dart';
import '../analysis_report_viewmodel.dart';

class ReportEducationQualityScreen extends GetView {
  ReportEducationQualityScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {

    analysisReportViewModel.getDataPreSchoolScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Quản lý chất lượng giáo dục", context),
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
                  builder: (context, setState) => Row(
                    children: [
                     Obx(() => DropdownButton(
                        icon: Image.asset(
                          'assets/icons/ic_arrow_down.png',
                          width: 14,
                          height: 14,
                        ),
                        value:  listReportEduQualityType[analysisReportViewModel.rxTypeScreen.value],

                        underline: const SizedBox.shrink(),
                        items: listReportEduQualityType
                            .map((value) => DropdownMenuItem(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          child: Text(value.trim()))),
                                  value: value.trim(),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            listReportEduQualityType
                                .asMap()
                                .forEach((index, itemValue) {
                              if (itemValue == value) {
                                analysisReportViewModel.rxTypeScreen.value = index;
                                analysisReportViewModel.getChartPreSchool(
                                    "${index + 1}", "", "", "", "");
                              }
                            });
                          });
                        },
                        style: Theme.of(context).textTheme.headline4,
                        isExpanded: false,
                      )),
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

                                if(analysisReportViewModel.rxTypeScreen.value == 0 )
                                  {
                                    Get.to(() =>  AnalysisReportEducationQualityFilterScreen(analysisReportViewModel));
                                  }
                                else{
                                  Get.to(() =>  XepLoaiNangLucPhamChatFilterScreen(analysisReportViewModel));
                                }


                              },
                              child: const Text(
                                'Bộ lọc',
                                style: TextStyle(color: kVioletButton),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Obx(() =>
                  (analysisReportViewModel.rxTypeScreen.value  == 0) ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: SizedBox(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        childAspectRatio: 3 / 2,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Cấp học',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedSchoolLevel.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Khối lớp',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedClass.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Môn học',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedSubject.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Vùng',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedRegion.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
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
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedProvince.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
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
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedSchoolYear.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: SizedBox(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        childAspectRatio: 3 / 2,
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
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedRegion.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
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
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedProvince.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
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
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedSchoolYear.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Cấp học',
                                  style: CustomTextStyle.grayColorTextStyle),
                              Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Obx(() => Text(analysisReportViewModel.rxSelectedSchoolLevel.value,maxLines: 2,overflow:  TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) ),
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
                  child: Obx(() => (analysisReportViewModel
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
}

var listReportEduQualityType = [
  "Chất lượng giáo dục các môn học",
  "Chất lượng giáo dục",
  "Xếp loại năng lực, phẩm chất",
];
var listClassification = ["Giỏi", "Khá", "Trung bình", "Yếu"];
var listPoint = [
  "Điểm 0",
  "Điểm 1",
  "Điểm 2",
  "Điểm 3",
  "Điểm 4",
  "Điểm 5",
  "Điểm 6",
  "Điểm 7",
  "Điểm 8",
  "Điểm 9",
  "Điểm 10"
];
var listSubject = ["Toán","Lý","Hóa","Anh","Sử","Địa","Văn","Sinh","Giáo dục công dân"];
var listPriSchool = ["Lớp 1","Lớp 2","Lớp 3","Lớp 4","Lớp 5",];
var listMidSchool = ["Lớp 6","Lớp 7","Lớp 8","Lớp 9",];
var listHighSchool = ["Lớp 10","Lớp 11","Lớp 12"];
var listAllClass = ["Lớp 1","Lớp 2","Lớp 3","Lớp 4","Lớp 5","Lớp 6","Lớp 7","Lớp 8","Lớp 9","Lớp 10","Lớp 11","Lớp 12"];