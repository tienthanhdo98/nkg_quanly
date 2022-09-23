import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';
import 'package:nkg_quanly/ui/workbook/update_work_screen.dart';
import 'package:nkg_quanly/ui/workbook/workbook_detail.dart';
import 'package:nkg_quanly/ui/workbook/workbook_viewmodel.dart';
import '../../const.dart';
import '../../const/style.dart';
import '../../const/ultils.dart';
import '../../const/widget.dart';
import '../../model/workbook/workbook_model.dart';
import '../document_nonapproved/document_nonapproved_list.dart';
import '../document_nonapproved/document_nonapproved_search.dart';
import '../theme/theme_data.dart';
import 'add_new_work_screen.dart';

class WorkBookList extends GetView {
  String? header;
  final menuController = Get.put(MenuController());
  final workBookViewModel = Get.put(WorkBookViewModel());
  int selectedButton = 0;

  WorkBookList({Key? key, this.header}) : super(key: key);

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
              ),
              context),
          //date table
          headerTableDate(
              Obx(() => TableCalendar(
                  locale: 'vi_VN',
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                      defaultTextStyle: Theme.of(context).textTheme.headline2!),
                  calendarFormat: workBookViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: workBookViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(
                        workBookViewModel.rxSelectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(
                        workBookViewModel.rxSelectedDay.value, selectedDay)) {
                      workBookViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (workBookViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      workBookViewModel.rxCalendarFormat.value = format;
                    }
                  })),
              Center(
                  child: InkWell(
                onTap: () {
                  if (workBookViewModel.rxCalendarFormat.value !=
                      CalendarFormat.month) {
                    workBookViewModel.switchFormat(CalendarFormat.month);
                  } else {
                    workBookViewModel.switchFormat(CalendarFormat.week);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset(
                      "assets/icons/ic_showmore.png",
                      height: 15,
                      width: 80,
                    )),
              )),
              context),
          //list
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Row(
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Tất cả công việc',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {Get.to(() => AddNewWorkScreen());},
                      style: elevetedButtonBlue,
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.add,
                            color: kWhite,
                            size: 24.0,
                          ),
                          Text("Tạo mới", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    ElevatedButton(
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
                                child: FilterWorkbookFilterBottomSheet(
                                    menuController, workBookViewModel));
                          },
                        );
                      },
                      child: const Text(
                        'Bộ lọc',
                        style: TextStyle(color: kVioletButton),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: workBookViewModel.rxWorkBookListItems.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.to(() => WorkBookDetail(
                              id: workBookViewModel
                                  .rxWorkBookListItems[index].id!));
                        },
                        child: WorkBookItem(
                            index,
                            workBookViewModel.rxWorkBookListItems[index],
                            workBookViewModel));
                  }))),
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
                          workBookViewModel.rxSelectedDay.value =
                              DateTime.now();
                          workBookViewModel.onSelectDay(DateTime.now());
                          workBookViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            workBookViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // DateTime datefrom =  DateTime.now();
                          // DateTime dateTo =  datefrom.add(const Duration(days: 7));
                          // String strdateTo = formatDateToString(dateTo);
                          // print(strdateTo);
                          // workBookViewModel.postWorkBookByDay(strdateTo);
                          workBookViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            workBookViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // workBookViewModel.postWorkBookAll();
                          workBookViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            workBookViewModel.selectedBottomButton.value, 2),
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

class WorkBookItem extends StatelessWidget {
  WorkBookItem(this.index, this.docModel, this.workBookViewModel);

  final int? index;
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${index! + 1}.${docModel!.workName!}",
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: InkWell(
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
                        return SizedBox(
                            height: 300,
                            child: MenuItemWorkBookSheetBottomSheet(
                              docModel: docModel,
                              workBookViewModel: workBookViewModel,
                            ));
                      },
                    );
                  },
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.more_vert)),
                ),
              ),
            ],
          ),
          signWidget(docModel!),
          SizedBox(
            height: 80,
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
                    const Text('Nhóm công việc',
                        style: CustomTextStyle.grayColorTextStyle),
                    Text(docModel!.groupWorkName!,
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người thực hiện',
                        style: CustomTextStyle.grayColorTextStyle),
                    Text(docModel!.worker!,
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mức độ',
                        style: CustomTextStyle.grayColorTextStyle),
                    (docModel!.important == true)
                        ? Text("Có",
                            style: Theme.of(context).textTheme.headline4)
                        : Text('Không',
                            style: Theme.of(context).textTheme.headline4)
                  ],
                ),
              ],
            ),
          ),
          const Text('Mô tả', style: CustomTextStyle.grayColorTextStyle),
          Text(docModel!.description!,
              style: Theme.of(context).textTheme.headline4),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
          const Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}

Widget signWidget(WorkBookListItems docModel) {
  if (docModel.status == true) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
        const Text(
          'Hoàn thành',
          style: TextStyle(color: kGreenSign),
        )
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
        const Text('Đang xử lý', style: TextStyle(color: kOrangeSign))
      ],
    );
  }
}

class MenuItemWorkBookSheetBottomSheet extends StatelessWidget {
  const MenuItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.workBookViewModel})
      : super(key: key);
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => WorkBookDetail(
                        id: docModel!.id!,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_info.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text(
                        "Xem chi tiết công việc",
                        style: Theme.of(context).textTheme.headline3,
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
                  Get.to(() => UpdateWorkBookScreen(docModel!));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_modify.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Chỉnh sửa công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
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
                      return SizedBox(
                          height: 300,
                          child: DeleteItemWorkBookSheetBottomSheet(
                            docModel: docModel,
                            workBookViewModel: workBookViewModel,
                          ));
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/ic_modify.png",
                        height: 20,
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Text("Xóa công việc",
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DeleteItemWorkBookSheetBottomSheet extends StatelessWidget {
  final WorkBookListItems? docModel;
  final WorkBookViewModel? workBookViewModel;

  const DeleteItemWorkBookSheetBottomSheet(
      {Key? key, this.docModel, this.workBookViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Thông báo",
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Bạn có chắc chắn muốn xóa bản ghi ',
                  style: CustomTextStyle.roboto400s16TextStyle,
                  children: <TextSpan>[
                    TextSpan(
                        text: docModel!.workName!,
                        style: CustomTextStyle.roboto700TextStyle),
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image.asset(
                'assets/ic_trash.png',
                width: 110,
                height: 100,
              )),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            height: 50,
            child: Align(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: kWhite,
                            //change background color of button
                            onPrimary: kBlueButton,
                            //change text color of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(color: kVioletButton)),
                          ),
                          child: const Text('Đóng')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            workBookViewModel!
                                .deleteWorkBookItem(docModel!.id!);
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return kBlueButton;
                                  } else {
                                    return kBlueButton;
                                  } // Use the component's default.
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text('Xác nhận')),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class FilterWorkbookFilterBottomSheet extends StatelessWidget {
  const FilterWorkbookFilterBottomSheet(
      this.menuController, this.workBookViewModel,
      {Key? key})
      : super(key: key);
  final MenuController? menuController;
  final WorkBookViewModel? workBookViewModel;

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
                      'Tất cả nhiệm vụ',
                      style: TextStyle(
                          color: kBlueButton,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ),
                  Obx(() => (workBookViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(true, 0);
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
            // Tất cả van de trinh
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
                  Obx(() => (workBookViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(false, 2);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(true, 2);
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
            //list van de trinh
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: lisLevel.length,
                  itemBuilder: (context, index) {
                    var item = lisLevel[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (workBookViewModel!.mapLevelFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        workBookViewModel!.checkboxLevel(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        workBookViewModel!.checkboxLevel(
                                            true, index, "$item;");
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
                      ],
                    );
                  }),
            ),
            // Tất cả loai phieu trinh
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
                  Obx(() => (workBookViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(false, 3);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            workBookViewModel!.checkboxFilterAll(true, 3);
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
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: lisStatus.length,
                  itemBuilder: (context, index) {
                    var item = lisStatus[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: CustomTextStyle.roboto400s16TextStyle,
                                ),
                              ),
                              Obx(() => (workBookViewModel!.mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        workBookViewModel!.checkboxStatus(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        workBookViewModel!.checkboxStatus(
                                            true, index, "$item;");
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
                      ],
                    );
                  }),
            ),

            //bottom button
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
                            if (workBookViewModel!.mapAllFilter
                                .containsKey(0)) {
                              // workBookViewModel!.postMissionByFilter(
                              //   status,
                              //   level,
                              //   department,);
                            } else {
                              if (workBookViewModel!.mapAllFilter
                                  .containsKey(1)) {
                                department = "";
                              } else {
                                workBookViewModel!.mapDepartmentFilter
                                    .forEach((key, value) {
                                  department += value;
                                });
                              }
                              if (workBookViewModel!.mapAllFilter
                                  .containsKey(2)) {
                                level = "";
                              } else {
                                workBookViewModel!.mapLevelFilter
                                    .forEach((key, value) {
                                  level += value;
                                });
                              }
                              if (workBookViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                workBookViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(department);
                            print(level);
                            print(status);
                            // workBookViewModel!.postMissionByFilter(
                            //     status,
                            //     level,
                            //     department);
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

var lisLevel = ["Thấp", "Trung bình", "Cao"];
var lisStatus = ["Chưa xử lý", "Đang thực hiện"];
