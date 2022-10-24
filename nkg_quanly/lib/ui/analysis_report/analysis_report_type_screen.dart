import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';

import '../../const/const.dart';
import '../../const/style.dart';
import '../../const/widget.dart';
import '../theme/theme_data.dart';
import 'analysis_collum_chart2.dart';
import 'analysis_pie_chart2.dart';
import 'analysis_report_filter_screen.dart';
import 'analysis_report_menu.dart';
import 'analysis_report_viewmodel.dart';

class AnalysisReportTypeMenu extends GetView {
  AnalysisReportTypeMenu(this.title, this.screenType, {Key? key})
      : super(key: key);
  final String title;
  String? filterType = "";
  final String screenType;
  final ScrollController _controller = ScrollController();
  final analysisReportViewModel = Get.put(AnalysisReportViewModel());

  @override
  Widget build(BuildContext context) {
    List<String> listScreen = checkListSceen(screenType);

    filterType = listScreen[0];
    // List<chart> listChart = checkListChart(filterType);
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
                        items: listScreen
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
                            listScreen.asMap().forEach((index, itemValue) {
                              if (itemValue == value) {
                                analysisReportViewModel
                                    .changeValuefilterType(filterType!);
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
                  child: Obx(() => ListView.builder(
                      controller: _controller,
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
                      })),
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

  List<chart> checkListChart(String? filterName) {
    print(filterType);
    List<chart> listScreen = [];
    // man non
    if (filterType == "Thống kê trường học, phòng học, lớp học cấp mầm non") {
      listScreen = listManNon;
    } else if (filterType == "Quy mô trẻ em cấp mầm non") {
      listScreen = listQuymoMannon;
    } else if (filterType == "Tình trạng dinh dưỡng trẻ em") {
      listScreen = listdinhduong;
    } else if (filterType ==
        "Cán bộ quản lý, giáo viên và nhân viên cấp mầm non") {
      listScreen = listnhanvienmamnon;
    }
    // tieu hoc
    else if (filterType == listReportPriSchoolType[0]) {
      listScreen = listtieuhoc;
    } else if (filterType == listReportPriSchoolType[1]) {
      listScreen = listQuyMoTieuhoc;
    } else if (filterType == listReportPriSchoolType[2]) {
      listScreen = nvtieuhoc;
    }
    //thscs
    else if (filterType == listReportMidSchoolType[0]) {
      listScreen = listTHCS;
    } else if (filterType == listReportMidSchoolType[1]) {
      listScreen = quymothcs;
    } else if (filterType == listReportMidSchoolType[2]) {
      listScreen = nvthcs;
    }
    //thpt
    else if (filterType == listReportHighSchoolType[0]) {
      listScreen = listthpt;
    } else if (filterType == listReportHighSchoolType[1]) {
      listScreen = quymothpt;
    } else if (filterType == listReportHighSchoolType[2]) {
      listScreen = nvthpt;
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

var listManNon = [
  chart("Cơ cấu trường mầm non theo loại trường", "1"),
  chart("Cơ cấu trường mầm non theo đơn vị thành lập", "1"),
  chart("Cơ cấu trường mầm non theo mức độ trường đạt chuẩn quốc gia", "1"),
  chart("Thống kê số lượng trường mầm non", "2"),
  chart("Thống kê tỷ lệ trường mầm non đạt chuẩn quốc gia", "2"),
  chart("Thống kê số lượng trường mầm non đạt chuẩn quốc gia", "2"),
  chart("Cơ cấu theo loại phòng học", "1"),
  chart("Thống kê số lượng phòng học", "2"),
  chart("Thống kê số lượng phòng học nhờ, mượn", "2"),
  chart("Thống kê số lượng phòng phục vụ học tập", "2"),
  chart("Thống kê số lượng phòng khác", "2"),
  chart("Thống kê số lớp học", "2"),
  chart("Thống kê số lượng lớp học theo loại lớp", "2"),
  chart("Thống kê số lượng trẻ theo nhóm", "2"),
  chart("Thống kê số lượng trẻ theo nhóm của từng vùng", "2"),
];
var listdinhduong = [
  chart("Thống kê tỷ lệ trẻ theo dinh dưỡng", "1"),
  chart("Thống kê tỷ lệ trẻ em nữ suy dinh dưỡng theo dân tộc", "1")
];

var listQuymoMannon = [
  chart("Cơ cấu trẻ em mầm non theo cấp học", "1"),
  chart("Cơ cấu trẻ em mầm non theo nhóm", "1"),
  chart("Cơ cấu trẻ em mầm non theo đơn vị", "1"),
  chart("Cơ cấu trẻ em mầm non theo giới tính", "1"),
  chart("Cơ cấu trẻ em mầm non theo dân tộc", "1"),
  chart("Cơ cấu trẻ em mầm non theo hình thức học", "1"),
  chart("Thống kê số lượng trẻ", "2"),
  chart("Thống kê số lượng bình quân trẻ từ 1-2 tuổi", "2"),
  chart("Thống kê số lượng bình quân trẻ từ 2-3 tuổi", "2"),
  chart("Thống kê số lượng bình quân trẻ từ 3-4 tuổi", "2"),
  chart("Thống kê số lượng bình quân trẻ từ 4-5 tuổi", "2"),
  chart("Thống kê số lượng bình quân trẻ từ 5-6 tuổi", "2"),
];
var listnhanvienmamnon = [
  chart(
      "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số",
      "1"),
  chart("Cơ cấu giáo viên theo trình độ đào tạo", "1"),
  chart("Cơ cấu giáo viên theo độ tuổi", "1"),
  chart("Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp",
      "1"),
  chart("Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên", "2"),
  chart("Thống kê tỷ lệ giáo viên đạt chuẩn", "2"),
  chart("Thống kê bình quân giáo viên/ nhóm", "2"),
  chart("Thống kê bình quân giáo viên/ lớp", "2"),
  chart("Thống kê bình quân số lượng trẻ của nhà trẻ/ giáo viên", "2"),
  chart("Thống kê bình quân số lượng trẻ của mẫu giáo/ giáo viên", "2"),
];

var listtieuhoc = [
  chart("Cơ cấu trường tiểu học theo loại trường", "1"),
  chart("Cơ cấu trường tiểu học theo đơn vị thành lập", "1"),
  chart("Cơ cấu trường tiểu học theo mức độ trường đạt chuẩn quốc gia", "1"),
  chart("Thống kê số lượng trường tiểu học ", "2"),
  chart("Thống kê tỷ lệ trường tiểu học đạt chuẩn quốc gia", "2"),
  chart("Thống kê số lượng trường tiểu học đạt chuẩn quốc gia", "2"),
  chart("Cơ cấu theo loại phòng học", "1"),
  chart("Thống kê số lượng phòng học", "2"),
  chart("Thống kê số lượng phòng học nhờ, mượn", "2"),
  chart("Thống kê số lượng phòng phục vụ học tập", "2"),
  chart("Thống kê số lượng phòng khác", "2"),
  chart("Thống kê số lượng lớp học theo loại lớp", "2"),
  chart("Thống kê số lượng lớp học theo khối học", "2"),
  chart("Thống kê số lượng lớp 1", "2"),
  chart("Thống kê số lượng lớp 2", "2"),
  chart("Thống kê số lượng lớp 3", "2"),
  chart("Thống kê số lượng lớp 4", "2"),
  chart("Thống kê số lượng lớp 5", "2"),
];
var listQuyMoTieuhoc = [
  chart("Cơ cấu học sinh theo khối học", "1"),
  chart("Cơ cấu học sinh theo hình thức học", "1"),
  chart("Cơ cấu học sinh theo độ tuổi", "1"),
  chart("Thống kê bình quân học sinh/ lớp học", "2"),
  chart("Thống kê biến động học sinh", "2"),
  chart("Thống kê quy mô học sinh", "2"),
  chart("Thống kê số học sinh lưu ban theo khối lớp", "2"),
  chart("Thống kê số học sinh hoàn thành chương trình theo tuổi", "2"),
  chart("Thống kê tỷ lệ học sinh đi học đúng tuổi", "2"),
  chart("Thống kê tỷ lệ học sinh lên lớp", "2"),
  chart("Thống kê tỷ lệ học sinh lưu ban", "2"),
  chart("Thống kê tỷ lệ học sinh bỏ học", "2"),
  chart("Thống kê tỷ lệ học sinh hoàn thành chương trình học", "2"),
];
var nvtieuhoc = [
  chart("Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số",
      "2"),
  chart(
      "Cơ cấu giáo viên theo trình độ đào tạo",
      "1"),
  chart("Cơ cấu giáo viên theo độ tuổi", "1"),
  chart("Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp", "1"),
  chart("Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên",
      "1"),
  chart("Thống kê tỷ lệ giáo viên đạt chuẩn", "2"),
  chart("Thống kê bình quân số học sinh/ giáo viên", "2"),
  chart("Thống kê bình quân số giáo viên/ lớp", "2"),
  chart("Thống kê bình quân giáo viên theo tỉnh/ thành", "2"),
];
var listTHCS = [
  chart("Cơ cấu trường THCS theo loại trường", "1"),
  chart("Cơ cấu trường THCS theo đơn vị thành lập", "1"),
  chart("Cơ cấu trường THCS theo mức độ trường đạt chuẩn quốc gia", "1"),
  chart("Thống kê số lượng trường THCS", "2"),
  chart("Thống kê số lượng trường THCS đạt chuẩn quốc gia", "2"),
  chart("Tỷ lệ trường THCS đạt chuẩn quốc gia", "2"),
  chart("Cơ cấu theo loại phòng học", "1"),
  chart("Thống kê số lượng phòng học", "2"),
  chart("Thống kê số lượng phòng học nhờ, mượn", "2"),
  chart("Thống kê số lượng phòng phục vụ học tập", "2"),
  chart("Thống kê số lượng phòng học theo bộ môn", "2"),
  chart("Thống kê số lượng phòng khác", "2"),
  chart("Thống kê số lượng lớp học theo loại lớp", "2"),
  chart("Thống kê số lượng lớp học theo khối học", "2"),
  chart("Thống kê số lượng lớp 6", "2"),
  chart("Thống kê số lượng lớp 7", "2"),
  chart("Thống kê số lượng lớp 8", "2"),
  chart("Thống kê số lượng lớp 9", "2"),
];
var quymothcs = [
  chart("Cơ cấu học sinh theo khối học", "1"),
  chart("Cơ cấu học sinh theo hình thức học", "1"),
  chart("Cơ cấu học sinh theo độ tuổi", "1"),
  chart("Thống kê bình quân học sinh/ lớp học", "2"),
  chart("Thống kê biến động học sinh", "2"),
  chart(
      "Thống kê quy mô học sinh", "2"),
  chart("Thống kê số học sinh lưu ban theo khối lớp", "2"),
  chart("Thống kê tỷ lệ học sinh đi học đúng tuổi", "2"),
  chart("Thống kê tỷ lệ học sinh lên lớp", "2"),
  chart("Thống kê tỷ lệ học sinh lưu ban", "2"),
  chart("Thống kê tỷ lệ học sinh bỏ học", "2"),
  chart("Thống kê tỷ lệ học sinh hoàn thành chương trình học", "2"),
  chart("Thống kê tỷ lệ học sinh tốt nghiệp", "2"),
];
var nvthcs = [
  chart(
      "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số", "2"),
  chart(
      "Cơ cấu giáo viên theo trình độ đào tạo",
      "1"),
  chart("Cơ cấu giáo viên theo độ tuổi", "12"),
  chart("Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp", "1"),
  chart(
      "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên", "12"),
  chart("Thống kê tỷ lệ giáo viên đạt chuẩn", "2"),
  chart("Thống kê bình quân số học sinh/ giáo viên", "2"),
  chart("Thống kê bình quân số giáo viên/ lớp", "2"),
];
var listthpt = [
  chart("Cơ cấu trường THPT theo loại trường", "1"),
  chart("Cơ cấu trường THPT theo đơn vị thành lập", "1"),
  chart("Cơ cấu trường THPT theo mức độ trường đạt chuẩn quốc gia", "1"),
  chart("Thống kê số lượng trường THPT", "2"),
  chart("Thống kê tỷ lệ trường THPT đạt chuẩn quốc gia", "2"),
  chart("Thống kê số lượng trường THPT đạt chuẩn quốc gia", "2"),
  chart("Cơ cấu theo loại phòng học", "1"),
  chart("Thống kê số lượng phòng học", "2"),
  chart("Thống kê số lượng phòng học nhờ, mượn", "2"),
  chart("Thống kê số lượng phòng phục vụ học tập", "2"),
  chart("Thống kê số lượng phòng học theo bộ môn", "2"),
  chart("Thống kê số lượng phòng khác", "2"),
  chart("Thống kê số lượng lớp học theo loại lớp", "2"),
  chart("Thống kê số lượng lớp học theo khối học", "2"),
  chart("Thống kê số lượng lớp 10", "2"),
  chart("Thống kê số lượng lớp 11", "2"),
  chart("Thống kê số lượng lớp 12", "2"),
];
var quymothpt = [
  chart("Cơ cấu học sinh theo khối học", "1"),
  chart("Cơ cấu học sinh theo hình thức học", "1"),
  chart("Cơ cấu học sinh theo độ tuổi", "1"),
  chart("Thống kê bình quân học sinh/ lớp học", "2"),
  chart("Thống kê biến động học sinh", "2"),
  chart("Thống kê quy mô học sinh", "2"),
  chart("Thống kê số học sinh lưu ban theo khối lớp", "2"),
  chart("Thống kê tỷ lệ học sinh đi học đúng tuổi", "2"),
  chart("Thống kê tỷ lệ học sinh lên lớp", "2"),
  chart("Thống kê tỷ lệ học sinh lưu ban", "2"),
  chart("Thống kê tỷ lệ học sinh bỏ học", "2"),
  chart("Thống kê tỷ lệ học sinh hoàn thành chương trình học", "2"),
  chart("Thống kê tỷ lệ học sinh tốt nghiệp", "2"),
];
var nvthpt = [
  chart(
      "Cơ cấu cán bộ quản lý, giáo viên, nhân viên là nữ theo dân tộc thiểu số", "2"),
  chart(
      "Cơ cấu giáo viên theo trình độ đào tạo",
      "1"),
  chart("Cơ cấu giáo viên theo độ tuổi", "1"),
  chart("Cơ cấu giáo viên theo đánh giá chuẩn nghề nghiệp", "1"),
  chart(
      "Thống kê số lượng cán bộ quản lý, giáo viên, nhân viên", "1"),
  chart("Thống kê tỷ lệ giáo viên đạt chuẩn", "2"),
  chart("Thống kê bình quân số học sinh/ giáo viên", "2"),
  chart("Thống kê bình quân số giáo viên/ lớp", "2"),
];
