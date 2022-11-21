import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';
import 'package:nkg_quanly/ui/search_screen.dart';
import '../../../const/const.dart';
import '../../../const/style.dart';
import '../../../const/utils.dart';
import '../../../const/widget.dart';
import '../../../model/report_model/report_model.dart';
import '../../theme/theme_data.dart';

import 'filter_report_screen.dart';

class ReportInMenuHomeList extends GetView {

  final reportViewModel = Get.put(ReportViewModel());

  ReportInMenuHomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        menuController.rxFromDateWithoutWeekDay.value = "";
        menuController.rxToDateWithoutWeekDay.value = "";
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            //header
            headerWidgetSearch(
                "Báo cáo bộ",
                SearchScreen(
                  hintText: 'Nhập mã báo cáo, tên báo cáo',
                  typeScreen: type_report,
                ),
                context),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tất cả báo cáo',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          InkWell(
                            onTap: () {
                              if (menuController.rxShowStatistic.value ==
                                  true) {
                                menuController.changeStateShowStatistic(false);
                              } else {
                                menuController.changeStateShowStatistic(true);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(children: [
                                Obx(() => Text(
                                    checkingNullNumberAndConvertToString(
                                        reportViewModel
                                            .rxReportStatisticTotal.value.tong),
                                    style: textBlueCountTotalStyle)),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: kBlueButton,
                                    ))
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: elevetedButtonWhite,
                            onPressed: () {
                              Get.to(() => FilterReportScreen(reportViewModel));
                            },
                            child: const Text(
                              'Bộ lọc',
                              style: TextStyle(color: kVioletButton),
                            ),
                          ))
                    ],
                  ),
                  Obx(() => (menuController.rxShowStatistic.value == true)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: SizedBox(
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                              mainAxisSpacing: 0,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo đã tiếp nhận",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.daTiepNhan),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo đúng hạn",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.dungHan),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo chưa đến hạn",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.chuaDenHan),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo đã giao",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.daGiao),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo sớm hạn",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.somHan),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28,
                                      child: Text("Báo cáo quá hạn",
                                          style: CustomTextStyle
                                              .robotow400s12TextStyle),
                                    ),
                                    Text(
                                        checkingNullNumberAndConvertToString(
                                            reportViewModel.rxReportStatisticTotal
                                                .value.quaHan),
                                        style: textBlackCountEofficeStyle)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink())
                ],
              ),
            ),
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                                        reportViewModel, FROM_DATE));
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: kDarkGray,
                                ),
                                borderRadius: BorderRadius.circular(
                                    5) // use instead of BorderRadius.all(Radius.circular(20))
                                ),
                            child: Row(children: [
                              Obx(() => Expanded(
                                    child: Text(
                                      menuController
                                          .rxFromDateWithoutWeekDay.value,
                                    ),
                                  )),
                              Obx(() => (menuController
                                          .rxFromDateWithoutWeekDay.value !=
                                      "")
                                  ? IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Image.asset(
                                        "assets/icons/ic_close_2.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onPressed: () {
                                        menuController.clearDataDateFrom();
                                      },
                                    )
                                  : IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Image.asset(
                                        "assets/icons/ic_date.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                                height: 300,
                                                child: DayPickerBottomSheet(
                                                    reportViewModel,
                                                    FROM_DATE));
                                          },
                                        );
                                      },
                                    ))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //den ngay
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                                        reportViewModel, TO_DATE));
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: kDarkGray,
                                ),
                                borderRadius: BorderRadius.circular(
                                    5) // use instead of BorderRadius.all(Radius.circular(20))
                                ),
                            child: Row(children: [
                              Obx(
                                () => Expanded(
                                  child: Text(
                                    menuController.rxToDateWithoutWeekDay.value,
                                  ),
                                ),
                              ),
                              Obx(() => (menuController
                                          .rxToDateWithoutWeekDay.value !=
                                      "")
                                  ? IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Image.asset(
                                        "assets/icons/ic_close_2.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onPressed: () {
                                        menuController.clearDataDateTo();
                                      },
                                    )
                                  : IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Image.asset(
                                        "assets/icons/ic_date.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                                height: 300,
                                                child: DayPickerBottomSheet(
                                                    reportViewModel, TO_DATE));
                                          },
                                        );
                                      },
                                    ))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String strdateFrom =
                        menuController.rxFromDateWithoutWeekDayToApi.value;
                    String strdateTo =
                        menuController.rxToDateWithoutWeekDayToApi.value;
                    print(strdateFrom);
                    print(strdateTo);
                    reportViewModel.postReportByWeek(strdateFrom, strdateTo);
                  },
                  child: buttonShowListScreen("Tìm"),
                  style: bottomButtonStyle,
                ),
              ),
            ),
            //list
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Divider(
                  thickness: 1,
                )),
            Expanded(
                child: Obx(() => (reportViewModel.rxReportListItems.isNotEmpty)
                    ? ListView.builder(
                        controller: reportViewModel.controller,
                        itemCount: reportViewModel.rxReportListItems.length,
                        itemBuilder: (context, index) {
                          var item = reportViewModel.rxReportListItems[index];
                          return InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    "http://123.31.31.237:6002/api/reportapiclient/download-report?id=1"));
                              },
                              child: ReportItemInMenu(index, item));
                        })
                    : noData())),
            //bottom
            Obx(() => Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                          top: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            menuController.rxSelectedDay.value = DateTime.now();
                            reportViewModel.onSelectDay(DateTime.now());
                            reportViewModel.selectedBottomButton(0);
                          },
                          child: bottomDateButton("Ngày",
                              reportViewModel.selectedBottomButton.value, 0),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            DateTime dateTo =
                                dateNow.add(const Duration(days: 7));
                            String strdateFrom = formatDateToString(dateNow);
                            String strdateTo = formatDateToString(dateTo);
                            reportViewModel.postReportByWeek(
                                strdateFrom, strdateTo);
                            reportViewModel.selectedBottomButton(1);
                          },
                          child: bottomDateButton("Tuần",
                              reportViewModel.selectedBottomButton.value, 1),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            reportViewModel.postReportByMonth();
                            reportViewModel.selectedBottomButton(2);
                          },
                          child: bottomDateButton("Tháng",
                              reportViewModel.selectedBottomButton.value, 2),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        )),
      ),
    );
  }
}

class ReportItemInMenu extends StatelessWidget {
  const ReportItemInMenu(this.index, this.docModel, {Key? key})
      : super(key: key);

  final int? index;
  final ReportListItems? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${index! + 1}. ${docModel!.name}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: priorityWidget(docModel!)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: textCodeStyle(docModel!.code!),
          ),
          signReportWidget(docModel!),
          SizedBox(
            height: 100,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đơn vị thực hiện',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.departmentHandle!,
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời hạn',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(formatDate(docModel!.endDate!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('File đính kèm',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          docModel!.detail!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: blueTextStyle,
                        ))
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

class FilterReportBottomSheet extends StatelessWidget {
  const FilterReportBottomSheet(this.reportViewModel, {Key? key})
      : super(key: key);
  final ReportViewModel? reportViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: [
            //tatca
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả danh sách Báo cáo',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (menuController.listPriorityStatus.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(false, 0, "");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(true, 0, "");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            // tat ca muc do
            const Divider(
              thickness: 1,
              color: kBlueButton,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả mức độ',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listPriorityStatus.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                false, 1, "Cao;Trung bình;Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                true, 1, "Cao;Trung bình;Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //cao
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Cao',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listPriorityStatus.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                false, 2, "Cao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                true, 2, "Cao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //trung binf
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Trung bình',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listPriorityStatus.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                false, 3, "Trung bình;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                true, 3, "Trung bình;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //thap
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Thấp',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listPriorityStatus.containsKey(4))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                false, 4, "Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxPriorityState(
                                true, 4, "Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //
            // Tất cả trạng thái
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả trạng thái',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listStateStatus.containsKey(5))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                false, 5, "Đã tiếp nhận;Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                true, 5, "Đã tiếp nhận;Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //Hoàn thành
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đã tiếp nhận',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listStateStatus.containsKey(6))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                false, 6, "Đã tiếp nhận;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                true, 6, "Đã tiếp nhận;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //Chưa hoàn thành
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đã giao',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController.listStateStatus.containsKey(7))
                      ? InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                false, 7, "Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController.checkboxStatusState(
                                true, 7, "Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_unactive.png',
                            width: 30,
                            height: 30,
                          )))
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  thickness: 1,
                  color: kgray,
                )),
            //
            Align(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: buttonFilterWhite,
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            var status = "";
                            var level = "";
                            if (menuController.listPriorityStatus
                                .containsKey(0)) {
                              reportViewModel!
                                  .postReportByFilter(status, level);
                            } else {
                              menuController.listPriorityStatus
                                  .forEach((key, value) {
                                level += value;
                              });
                              menuController.listStateStatus
                                  .forEach((key, value) {
                                status += value;
                              });
                              reportViewModel!
                                  .postReportByFilter(status, level);
                            }
                          },
                          style: buttonFilterBlue,
                          child: const Text('Áp dụng')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Widget signReportWidget(ReportListItems docModel) {
  if (docModel.state == "Đúng hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kGreenSign))
      ],
    );
  } else if (docModel.state == "Sớm hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          color: kLightBlueSign,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kLightBlueSign))
      ],
    );
  } else if (docModel.state == "Chưa đến hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          color: kRedChart,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kRedChart))
      ],
    );
  } else if (docModel.state == "Quá hạn") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_outdate.png',
          height: 14,
          color: kRedChart,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kRedChart))
      ],
    );
  } else if (docModel.state == "Đã tiếp nhận") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          color: kGreenSign,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.state!, style: const TextStyle(color: kGreenSign))
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: const TextStyle(color: kOrangeSign))
      ],
    );
  }
}