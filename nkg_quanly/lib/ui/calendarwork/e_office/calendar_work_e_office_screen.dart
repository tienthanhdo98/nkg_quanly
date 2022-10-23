import 'package:flutter/material.dart';
import 'package:nkg_quanly/const/const.dart';
import 'package:nkg_quanly/const/utils.dart';
import 'package:nkg_quanly/model/calendarwork_model/calendarwork_model.dart';

import '../../../const/style.dart';
import '../../../const/widget.dart';
import '../calendar_work_detail.dart';
import '../calendar_work_search.dart';
import '../calendar_work_viewmodel.dart';

class CalendarWorkEOfficeScreen extends GetView {
  CalendarWorkEOfficeScreen({Key? key}) : super(key: key);
  final calendarWorkController = Get.put(CalendarWorkViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            headerWidgetSearch("Lịch làm việc", CalendarWorkSearch(), context),
            //date table
            headerTableDatePicker(context, calendarWorkController),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Tất cả lịch làm việc của tôi",
            //         style: Theme.of(context).textTheme.headline5,
            //       ),
            //       const Text(
            //         "1292",
            //         style: textBlueCountTotalStyle,
            //       )
            //     ],
            //   ),
            // ),
            //list work
            Container(
              color: Theme.of(context).cardColor,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Center(
                            child: Text(
                              "Cả ngày",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 1, thickness: 1),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Danh sách lịch làm việc",
                              style: Theme.of(context).textTheme.headline5),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15))
              ]),
            ),
            Expanded(
              child: Obx(() => (calendarWorkController
                      .rxCalendarWorkListItems.isNotEmpty)
                  ? GetBuilder(
                    init: calendarWorkController,
                    builder: (value) => ListView.builder(
                      controller: calendarWorkController.controller,
                        itemCount:
                        calendarWorkController.rxCalendarWorkListItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CalendarEOfficeWorkItem(
                              index,
                              calendarWorkController
                                  .rxCalendarWorkListItems[index]);
                        }),
                  )
                  : Align(alignment: Alignment.topCenter,child: noData())),
            ),
            //bottom button
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
                            calendarWorkController.onSelectDay(DateTime.now());
                            calendarWorkController.swtichBottomButton(0);
                          },
                          child: bottomDateButton(
                              "Ngày",
                              calendarWorkController.selectedBottomButton.value,
                              0),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            DateTime dateTo =
                                dateNow.add(const Duration(days: 7));
                            String strdateFrom = formatDateToString(dateNow);
                            String strdateTo = formatDateToString(dateTo);
                            calendarWorkController.postCalendarWorkByWeek(
                                strdateFrom, strdateTo);
                            calendarWorkController.swtichBottomButton(1);
                          },
                          child: bottomDateButton(
                              "Tuần",
                              calendarWorkController.selectedBottomButton.value,
                              1),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            calendarWorkController.postCalendarWorkByMonth();
                            calendarWorkController.swtichBottomButton(2);
                          },
                          child: bottomDateButton(
                              "Tháng",
                              calendarWorkController.selectedBottomButton.value,
                              2),
                        ),
                      )
                    ],
                  ),
                ))
            //bottom
          ],
        ),
      ),
    );
  }
}

class CalendarEOfficeWorkItem extends StatelessWidget {
  const CalendarEOfficeWorkItem(this.index, this.item, {Key? key}) : super(key: key);
  final int? index;
  final CalendarWorkListItems item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (BuildContext context) {
            return CarlendarWorkDetail(item);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(item.time!,
                  style: Theme.of(context).textTheme.headline4),
            ),
            Flexible(
                child: Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    Text(
                      item.location!,
                      style: CustomTextStyle.robotow400s12TextStyle,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_camera.png",
                          height: 20,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                        Text(
                          item.type!,
                          style: CustomTextStyle.robotow400s12TextStyle,
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_user.png',
                          width: 30,
                          height: 30,
                        ),
                        const Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                        Text(
                          item.creator!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
