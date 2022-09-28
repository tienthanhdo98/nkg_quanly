import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/report/report_detail.dart';
import 'package:nkg_quanly/ui/report/report_search.dart';
import 'package:nkg_quanly/ui/report/report_viewmodel.dart';

import '../../const.dart';
import '../../const/style.dart';
import '../../const/ultils.dart';
import '../../const/widget.dart';
import '../../model/report_model/report_model.dart';
import '../theme/theme_data.dart';

class ReportList extends GetView {
  final String? header;
  final reportController = Get.put(ReportViewModel());

  ReportList({Key? key, this.header}) : super(key: key);
  final MenuController menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              ReportSearch(
                header: header,
              ),
              context),
          //date table
          Container(
            color: kgray,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "${dateNow.year} Tháng ${dateNow.month}",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                //date header
                Obx(() => TableCalendar(
                    locale: 'vi_VN',
                    headerVisible: false,
                    calendarFormat: reportController.rxCalendarFormat.value,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: reportController.rxSelectedDay.value,
                    selectedDayPredicate: (day) {
                      return isSameDay(
                          reportController.rxSelectedDay.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) async {
                      if (!isSameDay(
                          reportController.rxSelectedDay.value, selectedDay)) {
                        reportController.onSelectDay(selectedDay);
                      }
                    },
                    onFormatChanged: (format) {
                      if (reportController.rxCalendarFormat.value != format) {
                        // Call `setState()` when updating calendar format
                        reportController.rxCalendarFormat.value = format;
                      }
                    })),
                Center(
                    child: InkWell(
                  onTap: () {
                    if (reportController.rxCalendarFormat.value !=
                        CalendarFormat.month) {
                      reportController.switchFormat(CalendarFormat.month);
                    } else {
                      reportController.switchFormat(CalendarFormat.week);
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Image.asset(
                        "assets/icons/ic_showmore.png",
                        height: 15,
                        width: 80,
                      )),
                ))
                //list work
              ],
            ),
          ),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  'Tất cả báo cáo',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return kVioletBg;
                                } else {
                                  return kWhite;
                                } // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                        color: kVioletButton)))),
                        onPressed: () {
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
                                  height: 600,
                                  child:
                                  FilterReportBottomSheet(menuController,reportController));
                            },
                          );
                        },
                        child: const Text(
                          'Bộ lọc',
                          style: TextStyle(color: kVioletButton),
                        ),
                      )),
                ),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (reportController.rxReportListItems.isNotEmpty)
                  ? ListView.builder(
                      itemCount: reportController.rxReportListItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => ReportDetail(
                                  id: reportController
                                      .rxReportListItems[index].id!));
                            },
                            child: ReportItem(index,
                                reportController.rxReportListItems[index]));
                      })
                  : Text("Hôm nay không có báo cáo nào"))),
          //bottom
          Obx(() => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                        top:
                            BorderSide(color: Theme.of(context).dividerColor))),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          reportController.rxSelectedDay.value = DateTime.now();
                          reportController.onSelectDay(DateTime.now());
                          reportController.selectedBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            reportController.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime dateTo =
                              dateNow.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(dateNow);
                          String strdateTo = formatDateToString(dateTo);
                          reportController.postReportByWeek(
                              strdateFrom, strdateTo);
                          reportController.selectedBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            reportController.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          reportController.postReportByMonth();
                          reportController.selectedBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            reportController.selectedBottomButton.value, 2),
                      ),
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

class ReportItem extends StatelessWidget {
  ReportItem(this.index, this.docModel);

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
              Text(
                "${index! + 1}. ${docModel!.name}",
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
            ],
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
  const FilterReportBottomSheet(this.menuController,this.reportViewModel, {Key? key}) : super(key: key);
 final MenuController? menuController;
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
                  Obx(() => (menuController!.listPriorityStatus.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            menuController!.checkboxPriorityState(false, 0, "");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!.checkboxPriorityState(true, 0, "");
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
                  Obx(() => (menuController!.listPriorityStatus.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            menuController!.checkboxPriorityState(
                                false, 1, "Cao;Trung bình;Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!.checkboxPriorityState(
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
                  Obx(() => (menuController!.listPriorityStatus.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(false, 2, "Cao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(true, 2, "Cao;");
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
                  Obx(() => (menuController!.listPriorityStatus.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(false, 3, "Trung bình;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(true, 3, "Trung bình;");
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
                  Obx(() => (menuController!.listPriorityStatus.containsKey(4))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(false, 4, "Thấp;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxPriorityState(true, 4, "Thấp;");
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
                  Obx(() => (menuController!.listStateStatus.containsKey(5))
                      ? InkWell(
                          onTap: () {
                            menuController!.checkboxStatusState(
                                false, 5, "Đã tiếp nhận;Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!.checkboxStatusState(
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
                  Obx(() => (menuController!.listStateStatus.containsKey(6))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(false, 6, "Đã tiếp nhận;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(true, 6, "Đã tiếp nhận;");
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
                  Obx(() => (menuController!.listStateStatus.containsKey(7))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(false, 7, "Đã giao;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(true, 7, "Đã giao;");
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
                            var status ="";
                            var level ="";
                            if (menuController!.listPriorityStatus
                                .containsKey(0)) {
                              reportViewModel!.postReportByFilter(status,level);
                            } else {
                              menuController!.listPriorityStatus.forEach((key, value) {
                                level += value;
                              });
                              menuController!.listStateStatus.forEach((key, value) {
                                status += value;
                              });
                              reportViewModel!.postReportByFilter(status,level);
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
  if (docModel.status == "Đã giao") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        Text(docModel.status!, style: const TextStyle(color: kGreenSign))
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
