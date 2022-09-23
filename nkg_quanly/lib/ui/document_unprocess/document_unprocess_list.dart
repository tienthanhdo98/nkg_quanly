import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';

import '../../const.dart';
import '../../const/style.dart';
import '../../const/ultils.dart';
import '../../const/widget.dart';
import '../../model/document/document_model.dart';
import '../../viewmodel/home_viewmodel.dart';
import '../document_nonapproved/document_nonapproved_detail.dart';
import '../document_nonapproved/document_nonapproved_search.dart';
import '../document_nonapproved/document_nonapproved_viewmodel.dart';
import '../theme/theme_data.dart';
import 'document_unprocess_viewmodel.dart';

class DocumentUnprocessList extends GetView {
  final String? header;
  final MenuController menuController = Get.put(MenuController());
  final documentUnprocessViewModel = Get.put(DocumentUnprocessViewModel());

  DocumentUnprocessList({this.header});

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              DocumentnonapprovedSearch(
                header: header,
                isApprove: true,
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
                    calendarFormat:
                        documentUnprocessViewModel.rxCalendarFormat.value,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: documentUnprocessViewModel.rxSelectedDay.value,
                    selectedDayPredicate: (day) {
                      return isSameDay(
                          documentUnprocessViewModel.rxSelectedDay.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) async {
                      if (!isSameDay(
                          documentUnprocessViewModel.rxSelectedDay.value,
                          selectedDay)) {
                        documentUnprocessViewModel.onSelectDay(selectedDay);
                      }
                    },
                    onFormatChanged: (format) {
                      if (documentUnprocessViewModel.rxCalendarFormat.value !=
                          format) {
                        // Call `setState()` when updating calendar format
                        documentUnprocessViewModel.rxCalendarFormat.value =
                            format;
                      }
                    })),
                Center(
                    child: InkWell(
                  onTap: () {
                    if (documentUnprocessViewModel.rxCalendarFormat.value !=
                        CalendarFormat.month) {
                      documentUnprocessViewModel
                          .switchFormat(CalendarFormat.month);
                    } else {
                      documentUnprocessViewModel
                          .switchFormat(CalendarFormat.week);
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
                  'Tất cả văn bản chưa xử lý',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: elevetedButtonWhite,
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
                                  child: FilterDocUnprocessBottomSheet(
                                      menuController,
                                      documentUnprocessViewModel));
                            },
                          );
                        },
                        child: const Text(
                          'Bộ lọc',
                          style: TextStyle(color: kVioletButton),
                        ),
                      )),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (documentUnprocessViewModel.rxItems.isNotEmpty)
                  ? ListView.builder(
                      itemCount: documentUnprocessViewModel.rxItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => DocumentnonapprovedDetail(
                                  id: documentUnprocessViewModel
                                      .rxItems[index].id!));
                            },
                            child: DocumentNonProcessListItem(index,
                                documentUnprocessViewModel.rxItems[index]));
                      })
                  : const Text("Hôm nay không có văn bản đến nào"))),
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
                          documentUnprocessViewModel.rxSelectedDay.value =
                              DateTime.now();
                          documentUnprocessViewModel
                              .onSelectDay(DateTime.now());
                          documentUnprocessViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton(
                            "Ngày",
                            documentUnprocessViewModel
                                .selectedBottomButton.value,
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
                          print(strdateFrom);
                          print(strdateTo);
                          documentUnprocessViewModel.getDocumentByWeek(
                              strdateFrom, strdateTo);
                          documentUnprocessViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton(
                            "Tuần",
                            documentUnprocessViewModel
                                .selectedBottomButton.value,
                            1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          documentUnprocessViewModel.getDocumentByMonth();
                          documentUnprocessViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton(
                            "Tháng",
                            documentUnprocessViewModel
                                .selectedBottomButton.value,
                            2),
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

class DocumentNonProcessListItem extends StatelessWidget {
  DocumentNonProcessListItem(this.index, this.docModel);

  final int? index;
  final Items? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}.${docModel!.name}",
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: priorityWidget(docModel!))),
            ],
          ),
          signWidget(docModel!),
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
                    const Text('Đơn vị ban hành',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child:  Text(docModel!.departmentPublic!,
                          style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày đến',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(formatDate(docModel!.toDate!),
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
                      child:  Text(formatDate(docModel!.endDate!),
                          style: Theme.of(context).textTheme.headline5))
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

class FilterDocUnprocessBottomSheet extends StatelessWidget {
  const FilterDocUnprocessBottomSheet(this.menuController, this.reportViewModel,
      {Key? key})
      : super(key: key);
  final MenuController? menuController;
  final DocumentUnprocessViewModel? reportViewModel;

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
                      'Tất cả văn bản chưa xử lý',
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
                  Obx(() => (menuController!.listStateStatus.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            menuController!.checkboxStatusState(
                                false, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!.checkboxStatusState(
                                true, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
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
            //chưa xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Chưa xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController!.listStateStatus.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(false, 1, "Chưa xử lý;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(true, 1, "Chưa xử lý;");
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
            //đang xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đang xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController!.listStateStatus.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(false, 2, "Đang xử lý;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(true, 2, "Đang xử lý;");
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
            //đã xử lý
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đã xử lý',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() => (menuController!.listStateStatus.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(false, 3, "Đã xử lý;");
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            menuController!
                                .checkboxStatusState(true, 3, "Đã xử lý;");
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
            // Tất cả don vi ban hanh
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tất cả đơn vị ban hành',
                      style: CustomTextStyle.roboto700TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (menuController!.listDepartmentStatus.containsKey(0))
                          ? InkWell(
                              onTap: () {
                                menuController!.checkboxDepartmentState(
                                    false, 0, "Bộ;Sở;");
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                menuController!.checkboxDepartmentState(
                                    true, 0, "Chưa xử lý;Đang xử lý;Đã xử lý;");
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
            //bo
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Bộ',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (menuController!.listDepartmentStatus.containsKey(1))
                          ? InkWell(
                              onTap: () {
                                menuController!
                                    .checkboxDepartmentState(false, 1, "Bộ;");
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                menuController!
                                    .checkboxDepartmentState(true, 1, "Bộ;");
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
            //so
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Sở',
                      style: CustomTextStyle.roboto400s16TextStyle,
                    ),
                  ),
                  Obx(() =>
                      (menuController!.listDepartmentStatus.containsKey(2))
                          ? InkWell(
                              onTap: () {
                                menuController!
                                    .checkboxDepartmentState(false, 2, "Sở;");
                              },
                              child: Image.asset(
                                'assets/icons/ic_checkbox_active.png',
                                width: 30,
                                height: 30,
                              ))
                          : InkWell(
                              onTap: () {
                                menuController!
                                    .checkboxDepartmentState(true, 2, "Sở;");
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
                            var department = "";
                            if (menuController!.listPriorityStatus
                                .containsKey(0)) {
                              reportViewModel!
                                  .getDocumentByFilter(status, level, department);
                            } else {
                              menuController!.listPriorityStatus
                                  .forEach((key, value) {
                                level += value;
                              });
                              menuController!.listStateStatus
                                  .forEach((key, value) {
                                status += value;
                              });
                              menuController!.listDepartmentStatus
                                  .forEach((key, value) {
                                department += value;
                              });
                            }
                            print(status);
                            print(level);
                            print(department);
                            reportViewModel!
                                .getDocumentByFilter(status, level, department);
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

Widget signWidget(Items docModel) {
  return (docModel.status == "Đã xử lý")
      ? Row(
          children: [
            Image.asset(
              'assets/icons/ic_sign.png',
              height: 14,
              width: 14,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            Text(
              docModel.status!,
              style: const TextStyle(color: kGreenSign),
            )
          ],
        )
      : Row(
          children: [
            Image.asset(
              'assets/icons/ic_not_sign.png',
              height: 14,
              width: 14,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            Text(
              docModel.status!,
              style: const TextStyle(color: kOrangeSign),
            )
          ],
        );
}

class DocModel {
  String? title;
  int? priority;
  bool? isSign;

  DocModel(this.title, this.priority, this.isSign);
}