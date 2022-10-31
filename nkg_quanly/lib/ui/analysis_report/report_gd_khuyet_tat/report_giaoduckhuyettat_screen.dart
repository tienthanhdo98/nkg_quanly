import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/analysis_report/analysis_report_filter_screen.dart';

import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../../theme/theme_data.dart';
import '../analysis_collum_chart2.dart';
import '../analysis_pie_chart.dart';
import '../analysis_pie_chart2.dart';
import '../analysis_report_type_screen.dart';
import '../analysis_report_viewmodel.dart';

class ReportGiaoDucKhuyetTatScreen extends GetView {
  ReportGiaoDucKhuyetTatScreen({Key? key}) : super(key: key);

  final analysisReportViewModel = Get.put(AnalysisReportViewModel());
  String? filterType = "";
  @override
  Widget build(BuildContext context) {
    filterType = listReportGDKT[0];
    analysisReportViewModel.getDataPreSchoolScreen();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget("Giáo dục khuyết tật", context),
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
                            items: listReportGDKT
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
                                filterType = value.toString();
                                listReportGDKT.asMap().forEach((index, itemValue) {
                                  if (itemValue == value) {
                                    analysisReportViewModel
                                        .changeValuefilterType(filterType!);
                                    analysisReportViewModel.rxTypeScreen.value =
                                        index;
                                    analysisReportViewModel.scrollToTop();
                                  }
                                });
                              });
                            },
                            style: Theme.of(context).textTheme.headline4,
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
                controller: analysisReportViewModel.controller,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    children: [
                      Obx(() => countReport(
                          analysisReportViewModel,context)),
                      Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: checkListChart(
                              analysisReportViewModel.rxfilterType.value)
                              .length,
                          itemBuilder: (context, index) {
                            var item = checkListChart(
                                analysisReportViewModel.rxfilterType.value)[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: borderItem(
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                          InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                                "assets/icons/ic_refresh.png",
                                                width: 16,
                                                height: 16),
                                          )
                                        ],
                                      ),
                                      (item.type == "1")
                                          ? AnalysisChart2Widget(
                                        key: UniqueKey(),
                                      )
                                          : AnalysisChartCollum2Widget(
                                        key: UniqueKey(),
                                      )
                                    ]),
                                  ),
                                  context),
                            );
                          }))
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
  List<chart> checkListChart(String? filterName) {
    List<chart> listScreen = [];
    // man non
    if (filterType == listReportGDKT[0]) {
      listScreen = trungtamgdkt;
    } else if (filterType == listReportGDKT[1]) {
      listScreen = hskt;
    } else {
      listScreen = nvgddkt;
    }
    return listScreen;
  }

}

Widget countReport(
    AnalysisReportViewModel analysisReportViewModel, BuildContext context) {
  if (analysisReportViewModel.rxTypeScreen.value == 1) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Text('HS khuyết tật chuyên biệt',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("1290", style: textBlueCountTotalStyle))
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
                  height: 30,
                  child: Text('HS được can thiệp sớm',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("780", style: textBlueCountTotalStyle))
              ],
            ),
          ),
        ],
      ),
    );
  }
  else if(analysisReportViewModel.rxTypeScreen.value == 2){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Text('Tổng GV nghỉ hưu',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("1290", style: textBlueCountTotalStyle))
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
                  height:20,
                  child: Text('Tổng GV tuyển mới',
                      style: Theme.of(context).textTheme.headline5),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("780", style: textBlueCountTotalStyle))
              ],
            ),
          ),
        ],
      ),
    );
  }
  else {
    return const SizedBox.shrink();
  }

}


var listReportGDKT= [
  "Báo cáo thống kê số trung tâm GDKT",
  "Báo cáo thống kê học sinh khuyết tật",
  "Báo cáo thống kê cán bộ quản lý, giáo viên và nhân viên hỗ trợ giáo dục trẻ em khuyết tật",
];
var trungtamgdkt = [
  chart("Cơ cấu cơ sở giáo dục khuyết tật theo trung tâm","1"),
  chart("Cơ cấu cơ sở giáo dục khuyết theo đơn vị thành lâp","1"),
  chart("Thống kê cơ sở giáo dục khuyết tật","2"),
  ];
var hskt = [
  chart("Cơ cấu HS theo dạng khuyết tật", "1"),
  chart("Cơ cấu HS theo mức độ khuyết tật", "1"),
  chart("Cơ cấu HS được can thiệp sớm theo dạng khuyết tật", "1"),
  chart("Thống kê HS khuyết tật theo tỉnh/ thành phố", "2"),
  chart("Thống kê HS khuyết tật theo vùng", "2"),
  chart("Thống kê HS khuyết tật theo năm học", "2"),
];
var  nvgddkt = [
  chart("Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số", "1"),
  chart("Cơ cấu giáo viên theo trình độ đào tạo", "1"),
  chart("Cơ cấu giáo viên theo độ tuổi", "1"),
  chart("Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp", "1"),
  chart("Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên", "2"),
  chart("Thống kê cán bộ quản lý, giáo viên, nhân viên theo tỉnh/ TP", "2"),
  chart("Thống kê cán bộ quản lý, giáo viên, nhân viên theo vùng", "2"),
  chart("Thống kê cán bộ quản lý, giáo viên, nhân viên theo năm", "2"),
];
