import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_collum_chart.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profile_proc_pie_chart.dart';
import 'package:nkg_quanly/ui/profile_procedure_/profile_procedure_home/profile_proc_report/profiles_pro_report_viewmodel.dart';

import '../../../../const/api.dart';
import '../../../../const/const.dart';
import '../../../../const/style.dart';
import '../../../../const/widget.dart';
import '../../../theme/theme_data.dart';

const BY_BRANCH = "byBranch";
const BY_AGENCIES = "byAgencies";
const BY_RECEPTIONFORM = "byReceptionform";
const BY_DATE = "byDate";

class ProfileProcReportScreen extends GetView {
  final profilesProcReportViewModel = Get.put(ProfilesProcReportViewModel());

  ProfileProcReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget("Dịch vụ công hành chính", context),
              Expanded(
                child: Container(
                  color: kDarkGray,
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(children: [
                          //pie char tinh trang giai quyet
                          Padding(
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
                                            'Thống kê tình trạng giải quyết',
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
                                            refreshPieChart(
                                                profilesProcReportViewModel);
                                          },
                                          child: Image.asset(
                                              "assets/icons/ic_refresh.png",
                                              width: 16,
                                              height: 16),
                                        )
                                      ],
                                    ),
                                    Obx(() => (profilesProcReportViewModel
                                                .rxDataChart
                                                .value
                                                .items
                                                ?.isNotEmpty ==
                                            true)
                                        ? ProfileProcPieChartWidget(
                                            profilesProcReportViewModel
                                                .rxDataChart.value,
                                            key: UniqueKey(),
                                          )
                                        : const SizedBox.shrink())
                                  ]),
                                ),
                                context),
                          ),
                          //branch
                          CollumChartByDataType(
                              profilesProcReportViewModel:
                                  profilesProcReportViewModel,
                              title:
                                  "Thống kê tình trạng xử lý hồ sơ theo lĩnh vực",
                              type: BY_BRANCH,
                              key: UniqueKey()),
                          //agencies
                          CollumChartByDataType(
                            profilesProcReportViewModel:
                                profilesProcReportViewModel,
                            title:
                                "Thống kê tình trạng xử lý hồ sơ theo đơn vị",
                            type: BY_AGENCIES,
                            key: UniqueKey(),
                          ),
                          //Reception
                          CollumChartByDataType(
                            profilesProcReportViewModel:
                                profilesProcReportViewModel,
                            title:
                                "Thống kê tình trạng xử lý hồ sơ theo tình trạng tiếp nhận",
                            type: BY_RECEPTIONFORM,
                            key: UniqueKey(),
                          ),
                          //Date
                          CollumChartByDataType(
                            profilesProcReportViewModel:
                                profilesProcReportViewModel,
                            title:
                                "Thống kê tình trạng xử lý hồ sơ theo thời gian",
                            type: BY_DATE,
                            key: UniqueKey(),
                          ),
                        ])),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CollumChartByDataType extends StatelessWidget {
  const CollumChartByDataType({
    Key? key,
    required this.profilesProcReportViewModel,
    required this.type,
    required this.title,
  }) : super(key: key);

  final ProfilesProcReportViewModel profilesProcReportViewModel;
  final String type;
  final String title;

  @override
  Widget build(BuildContext context) {
    var currentType = "";
    var currentUrl = "";
    if (type == BY_AGENCIES) {
      currentType = BY_AGENCIES;
      currentUrl = apiPostChartByAgencies;
    } else if (type == BY_BRANCH) {
      currentType = BY_BRANCH;
      currentUrl = apiPostChartByBranch;
    } else if (type == BY_DATE) {
      currentType = BY_DATE;
      currentUrl = apiPostChartByDate;
    } else if (type == BY_RECEPTIONFORM) {
      currentType = BY_RECEPTIONFORM;
      currentUrl = apiPostChartByReceptionform;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: borderItem(
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  InkWell(
                    onTap: () {
                      refreshChart(profilesProcReportViewModel, currentType);
                    },
                    child: Image.asset("assets/icons/ic_refresh.png",
                        width: 16, height: 16),
                  )
                ],
              ),
              // button chon ngay
              Obx(() => Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: profilesProcReportViewModel
                                    .selectedChartButton.value ==
                                4
                            ? activeButtonStyle
                            : unActiveButtonStyle,
                        onPressed: () async {
                          //call data
                          DateTime dateTo =
                              dateNow.subtract(const Duration(days: 7));
                          String strdateTo = formatDateToString(dateNow);
                          String strdateFrom = formatDateToString(dateTo);
                          await profilesProcReportViewModel
                              .postProfileProcCollumChart(currentUrl,
                                  currentType, strdateFrom, strdateTo);

                          //
                          profilesProcReportViewModel.selectedChartButton(4);
                        },
                        child: const Text("Tuần"),
                      )),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: ElevatedButton(
                          style: profilesProcReportViewModel
                                      .selectedChartButton.value ==
                                  5
                              ? activeButtonStyle
                              : unActiveButtonStyle,
                          onPressed: () async {
                            //call data
                            int lastday =
                                DateTime(dateNow.year, dateNow.month + 1, 0)
                                    .day;
                            int firstday =
                                DateTime(dateNow.year, dateNow.month + 1).day;
                            String strdateTo =
                                "${dateNow.year}-${dateNow.month}-$lastday";
                            String strdateFrom =
                                "${dateNow.year}-${dateNow.month}-0$firstday";
                            print(strdateFrom);
                            print(strdateTo);
                            await profilesProcReportViewModel
                                .postProfileProcCollumChart(currentUrl,
                                    currentType, strdateFrom, strdateTo);

                            profilesProcReportViewModel.selectedChartButton(5);
                          },
                          child: const Text("Tháng"),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: ElevatedButton(
                          style: profilesProcReportViewModel
                                      .selectedChartButton.value ==
                                  6
                              ? activeButtonStyle
                              : unActiveButtonStyle,
                          onPressed: () async {
                            //call data
                            var listStrDate = getQuy(dateNow.month);
                            String strdateTo = listStrDate[1];
                            String strdateFrom = listStrDate[0];
                            print(strdateFrom);
                            print(strdateTo);

                            await profilesProcReportViewModel
                                .postProfileProcCollumChart(currentUrl,
                                    currentType, strdateFrom, strdateTo);

                            profilesProcReportViewModel.selectedChartButton(6);
                          },
                          child: const Text("Quý"),
                        ),
                      )
                    ],
                  )),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Obx(() => Text(
                          "${menuController.rxYear} Tháng ${menuController.rxMonth}",
                          style: Theme.of(context).textTheme.headline2,
                        )),
                  ),
                  const Spacer(),
                  InkWell(
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
                              height: 220,
                              child: DatePickerProfileProcOptionBottomSheet(
                                  profilesProcReportViewModel, currentType));
                        },
                      );
                    },
                    child: Image.asset(
                      "assets/icons/ic_calendar.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              Obx(() => CollumChart(currentType, profilesProcReportViewModel))
            ]),
          ),
          context),
    );
  }
}

Widget CollumChart(
    String type, ProfilesProcReportViewModel profilesProcReportViewModel) {
  if (type == BY_AGENCIES) {
    return ProfileProcChartWidget(
        profilesProcReportViewModel.rxListProfileProcChartAgencies.value,
        key: UniqueKey());
  } else if (type == BY_BRANCH) {
    return ProfileProcChartWidget(
        profilesProcReportViewModel.rxListProfileProcChartBranch.value,
        key: UniqueKey());
  } else if (type == BY_DATE) {
    return ProfileProcChartWidget(
        profilesProcReportViewModel.rxListProfileProcChartDate.value,
        key: UniqueKey());
  } else {
    return ProfileProcChartWidget(
        profilesProcReportViewModel.rxListProfileProcChartReception.value,
        key: UniqueKey());
  }
}

List<String> getQuy(int currentMonth) {
  List<String> listStrDate = [];
  var dateFrom = "";
  var dateTo = "";
  switch (currentMonth) {
    case 1:
    case 2:
    case 3:
      {
        dateFrom = "${dateNow.year}-01-01";
        dateTo = "${dateNow.year}-03-31";
        listStrDate.add(dateFrom);
        listStrDate.add(dateTo);
      }
      break;
    case 4:
    case 5:
    case 6:
      {
        dateFrom = "${dateNow.year}-04-01";
        dateTo = "${dateNow.year}-06-30";
        listStrDate.add(dateFrom);
        listStrDate.add(dateTo);
      }
      break;
    case 7:
    case 8:
    case 9:
      {
        dateFrom = "${dateNow.year}-07-01";
        dateTo = "${dateNow.year}-09-30";
        listStrDate.add(dateFrom);
        listStrDate.add(dateTo);
      }
      break;
    case 10:
    case 11:
    case 12:
      {
        dateFrom = "${dateNow.year}-10-01";
        dateTo = "${dateNow.year}-12-31";
        listStrDate.add(dateFrom);
        listStrDate.add(dateTo);
      }
      break;
  }
  return listStrDate;
}

void refreshPieChart(
    ProfilesProcReportViewModel profilesProcReportViewModel) async {
  await profilesProcReportViewModel.postProfileProcCharStatusResolve("", "");
}

void refreshChart(ProfilesProcReportViewModel profilesProcReportViewModel,
    String type) async {
  var currentType = "";
  var currentUrl = "";
  if (type == BY_AGENCIES) {
    currentType = BY_AGENCIES;
    currentUrl = apiPostChartByAgencies;
  } else if (type == BY_BRANCH) {
    currentType = BY_BRANCH;
    currentUrl = apiPostChartByBranch;
  } else if (type == BY_DATE) {
    currentType = BY_DATE;
    currentUrl = apiPostChartByDate;
  } else if (type == BY_RECEPTIONFORM) {
    currentType = BY_RECEPTIONFORM;
    currentUrl = apiPostChartByReceptionform;
  }
  await profilesProcReportViewModel.postProfileProcCollumChart(
      currentUrl, currentType, "", "");
}

class DatePickerProfileProcOptionBottomSheet extends StatelessWidget {
  final ProfilesProcReportViewModel? viewModel;
  final String type;

  const DatePickerProfileProcOptionBottomSheet(this.viewModel, this.type,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buttonLineInBottonSheet(),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
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
                            height: 300,
                            child:
                                DayPickerBottomSheet(viewModel, DATE_PICKER));
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_date.png",
                          width: 25,
                          height: 25,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        const Text(
                          "Chọn ngày",
                          style: CustomTextStyle.roboto700TextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() =>
                        RangeDayProfileProcPickerBottomSheet(viewModel, type));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_range_date.png",
                          width: 25,
                          height: 25,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                        const Text(
                          "Chọn khoảng thời gian",
                          style: CustomTextStyle.roboto700TextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ]),
        )
      ],
    );
  }
}

class RangeDayProfileProcPickerBottomSheet extends StatelessWidget {
  final ProfilesProcReportViewModel? profilesProcReportViewModel;
  final String type;

  const RangeDayProfileProcPickerBottomSheet(
      this.profilesProcReportViewModel, this.type,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            headerWidget("Chọn khoảng thời gian", context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: Text("Từ ngày")),
                    InkWell(
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
                                height: 300,
                                child: DayPickerBottomSheet(
                                    profilesProcReportViewModel, FROM_DATE));
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kDarkGray,
                            ),
                            borderRadius: BorderRadius.circular(
                                5) // use instead of BorderRadius.all(Radius.circular(20))
                            ),
                        child: Row(children: [
                          Expanded(
                            child: Obx(() => Text(
                                  menuController.rxFromDateWithWeekDay.value,
                                )),
                          ),
                          Image.asset(
                            "assets/icons/ic_date.png",
                            width: 25,
                            height: 25,
                          ),
                        ]),
                      ),
                    ),
                    //den ngay
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: Text("Đến ngày")),
                    InkWell(
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
                                height: 300,
                                child: DayPickerBottomSheet(
                                    profilesProcReportViewModel, TO_DATE));
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kDarkGray,
                            ),
                            borderRadius: BorderRadius.circular(
                                5) // use instead of BorderRadius.all(Radius.circular(20))
                            ),
                        child: Row(children: [
                          Expanded(
                              child: Obx(
                            () => Text(
                              menuController.rxToDateWithWeekDay.value,
                            ),
                          )),
                          Image.asset(
                            "assets/icons/ic_date.png",
                            width: 25,
                            height: 25,
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: ElevatedButton(
                  onPressed: () async {
                    //call data
                    var currentType = "";
                    var currentUrl = "";
                    if (type == BY_AGENCIES) {
                      currentType = BY_AGENCIES;
                      currentUrl = apiPostChartByAgencies;
                    } else if (type == BY_BRANCH) {
                      currentType = BY_BRANCH;
                      currentUrl = apiPostChartByBranch;
                    } else if (type == BY_DATE) {
                      currentType = BY_DATE;
                      currentUrl = apiPostChartByDate;
                    } else if (type == BY_RECEPTIONFORM) {
                      currentType = BY_RECEPTIONFORM;
                      currentUrl = apiPostChartByReceptionform;
                    }
                    String strdateFrom = menuController.rxFromDate.value;
                    String strdateTo = menuController.rxToDate.value;

                    print(strdateFrom);
                    print(strdateTo);
                    await profilesProcReportViewModel!
                        .postProfileProcCollumChart(
                            currentUrl, currentType, strdateFrom, strdateTo);
                    Get.back();
                  },
                  child: buttonShowListScreen("Chọn"),
                  style: bottomButtonStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
