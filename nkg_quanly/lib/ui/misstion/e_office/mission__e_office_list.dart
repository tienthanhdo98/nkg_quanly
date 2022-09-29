import 'package:flutter/material.dart';
import 'package:nkg_quanly/ui/menu/MenuController.dart';

import '../../../const.dart';
import '../../../const/style.dart';
import '../../../const/ultils.dart';
import '../../../const/widget.dart';
import '../../../model/misstion/mission_detail.dart';
import '../../theme/theme_data.dart';
import '../mission_detail.dart';
import '../mission_viewmodel.dart';
import '../misstion_search.dart';
import 'filter_mission_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class MissionEOfficeList extends GetView {
  final String? header;
  final MenuController menuController = Get.put(MenuController());
  final missionViewModel = Get.put(MissionViewModel());

  MissionEOfficeList({Key? key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //header
          headerWidgetSeatch(
              header!,
              MissionSearch(
                header: header,
              ),
              context),
          //date table
          headerTableDatePicker(
              Obx(() => TableCalendar(
                  locale: 'vi_VN',
                  headerVisible: false,
                  calendarFormat: missionViewModel.rxCalendarFormat.value,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: missionViewModel.rxSelectedDay.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(missionViewModel.rxSelectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(
                        missionViewModel.rxSelectedDay.value, selectedDay)) {
                      missionViewModel.onSelectDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (missionViewModel.rxCalendarFormat.value != format) {
                      // Call `setState()` when updating calendar format
                      missionViewModel.rxCalendarFormat.value = format;
                    }
                  })),
              Center(
                  child: InkWell(
                onTap: () {
                  if (missionViewModel.rxCalendarFormat.value !=
                      CalendarFormat.month) {
                    missionViewModel.switchFormat(CalendarFormat.month);
                  } else {
                    missionViewModel.switchFormat(CalendarFormat.week);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset(
                      "assets/icons/ic_showmore.png",
                      height: 15,
                      width: 80,
                    )),
              )),missionViewModel,
              context),
          //list
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
                          'Tất cả nhiệm vụ',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        InkWell(
                          onTap: () {
                            if (menuController.rxShowStatistic.value == true) {
                              menuController.changeStateShowStatistic(false);
                            } else {
                              menuController.changeStateShowStatistic(true);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(children: [
                              Obx(() => (missionViewModel
                                          .rxMissionStatisticModel.value.tong !=
                                      null)
                                  ? Text(
                                      missionViewModel
                                          .rxMissionStatisticModel.value.tong
                                          .toString(),
                                      style: textBlueCountTotalStyle)
                                  : const Text("0",
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
                            Get.to(() => FilterMissionScreen(missionViewModel));
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
                            crossAxisSpacing: 10,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Chưa xử lý',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                      missionViewModel.rxMissionStatisticModel
                                          .value.chuaXuLy
                                          .toString(),
                                      style: textBlackCountEofficeStyle)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đang thực hiện',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel.rxMissionStatisticModel
                                        .value.dangThucHien
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã hủy',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatisticModel.value.daHuy
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Đã tạm dưng',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatisticModel.value.daTamDung
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Quá hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatisticModel.value.quaHan
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Trong hạn',
                                      style: CustomTextStyle
                                          .robotow400s12TextStyle),
                                  Text(
                                    missionViewModel
                                        .rxMissionStatisticModel.value.trongHan
                                        .toString(),
                                    style: textBlackCountEofficeStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1,
              )),
          Expanded(
              child: Obx(() => (missionViewModel.rxMissionItem.isNotEmpty)
                  ? ListView.builder(
                      itemCount: missionViewModel.rxMissionItem.length,
                      itemBuilder: (context, index) {
                        return InkWell(
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
                                      height: 320,
                                      child: DetailMissionBottomSheet(
                                          index,
                                          missionViewModel
                                              .rxMissionItem[index]));
                                },
                              );
                            },
                            child: MissionListItem(
                                index, missionViewModel.rxMissionItem[index]));
                      })
                  : const Text("Hôm nay không có nhiệm vụ nào"))),
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
                          missionViewModel.rxSelectedDay.value = DateTime.now();
                          missionViewModel.onSelectDay(DateTime.now());
                          missionViewModel.swtichBottomButton(0);
                        },
                        child: bottomDateButton("Ngày",
                            missionViewModel.selectedBottomButton.value, 0),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DateTime datefrom = DateTime.now();
                          DateTime dateTo =
                              datefrom.add(const Duration(days: 7));
                          String strdateFrom = formatDateToString(datefrom);
                          String strdateTo = formatDateToString(dateTo);
                          missionViewModel.getMissionByWeek(
                              strdateFrom, strdateTo);
                          missionViewModel.swtichBottomButton(1);
                        },
                        child: bottomDateButton("Tuần",
                            missionViewModel.selectedBottomButton.value, 1),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          missionViewModel.getMissionByMonth();
                          missionViewModel.swtichBottomButton(2);
                        },
                        child: bottomDateButton("Tháng",
                            missionViewModel.selectedBottomButton.value, 2),
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

class MissionListItem extends StatelessWidget {
  MissionListItem(this.index, this.docModel);

  final int? index;
  final MissionItem? docModel;

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
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: textCodeStyle(docModel!.code!)),
          signWidgetMission(docModel!),
          SizedBox(
            height: 70,
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
                    const Text('Người xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.organizationName!,
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
                        child: Text(formatDate(docModel!.deadline!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          formatDate(docModel!.processingDate!),
                          style: Theme.of(context).textTheme.headline5,
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

Widget signWidgetMission(MissionItem docModel) {
  if (docModel.state == "Đang thực hiện") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(
          docModel.state!,
          style: const TextStyle(color: kGreenSign, fontSize: 12),
        )
      ],
    );
  } else if (docModel.state == "Chưa xử lý") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_not_sign.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.state!,
            style: const TextStyle(color: kOrangeSign, fontSize: 12))
      ],
    );
  } else if (docModel.state == "Đã hủy") {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_cancel_red.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.state!,
            style: const TextStyle(color: kRedPriority, fontSize: 12))
      ],
    );
  } else {
    return Row(
      children: [
        Image.asset(
          'assets/icons/ic_still.png',
          height: 14,
          width: 14,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
        Text(docModel.state!,
            style: const TextStyle(color: Colors.black, fontSize: 12))
      ],
    );
  }
}

class DetailMissionBottomSheet extends StatelessWidget {
  const DetailMissionBottomSheet(this.index, this.docModel, {Key? key})
      : super(key: key);
  final int? index;
  final MissionItem? docModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin nhiệm vụ',
            style: TextStyle(
                color: kBlueButton,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16),
          ),
          const Divider(
            thickness: 1,
            color: kBlueButton,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
          signWidgetMission(docModel!),
          SizedBox(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Người xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(docModel!.organizationName!,
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
                        child: Text(formatDate(docModel!.deadline!),
                            style: Theme.of(context).textTheme.headline5))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ngày xử lý',
                        style: CustomTextStyle.grayColorTextStyle),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          formatDate(docModel!.processingDate!),
                          style: Theme.of(context).textTheme.headline5,
                        ))
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
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
                          Get.to(() =>
                              MissionDetail(id: int.parse(docModel!.id!)));
                        },
                        style: buttonFilterBlue,
                        child: const Text('Xem chi tiết')),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterMissionBottomSheet extends StatelessWidget {
  const FilterMissionBottomSheet(this.menuController, this.missionViewModel,
      {Key? key})
      : super(key: key);
  final MenuController? menuController;
  final MissionViewModel? missionViewModel;

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
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(0))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 0);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 0);
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
            //tat ca don vi
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
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(1))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 1);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 1);
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: missionViewModel!.rxListDepartmentFilter.length,
                  itemBuilder: (context, index) {
                    var item = missionViewModel!.rxListDepartmentFilter[index];
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
                              Obx(() => (missionViewModel!.mapDepartmentFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxDepartment(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxDepartment(
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
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(2))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 2);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 2);
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: listLevel.length,
                  itemBuilder: (context, index) {
                    var item = listLevel[index];
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
                              Obx(() => (missionViewModel!.mapLevelFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxLevel(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxLevel(
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
                  Obx(() => (missionViewModel!.mapAllFilter.containsKey(3))
                      ? InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(false, 3);
                          },
                          child: Image.asset(
                            'assets/icons/ic_checkbox_active.png',
                            width: 30,
                            height: 30,
                          ))
                      : InkWell(
                          onTap: () {
                            missionViewModel!.checkboxFilterAll(true, 3);
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: listMissionState.length,
                  itemBuilder: (context, index) {
                    var item = listMissionState[index];
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
                              Obx(() => (missionViewModel!.mapStatusFilter
                                      .containsKey(index))
                                  ? InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxStatus(
                                            false, index, "$item;");
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_checkbox_active.png',
                                        width: 30,
                                        height: 30,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        missionViewModel!.checkboxStatus(
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
                            if (missionViewModel!.mapAllFilter.containsKey(0)) {
                              missionViewModel!.postMissionByFilter(
                                status,
                                level,
                                department,
                              );
                            } else {
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(1)) {
                                department = "";
                              } else {
                                missionViewModel!.mapDepartmentFilter
                                    .forEach((key, value) {
                                  department += value;
                                });
                              }
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(2)) {
                                level = "";
                              } else {
                                missionViewModel!.mapLevelFilter
                                    .forEach((key, value) {
                                  level += value;
                                });
                              }
                              if (missionViewModel!.mapAllFilter
                                  .containsKey(3)) {
                                status = "";
                              } else {
                                missionViewModel!.mapStatusFilter
                                    .forEach((key, value) {
                                  status += value;
                                });
                              }
                            }
                            print(department);
                            print(level);
                            print(status);
                            missionViewModel!
                                .postMissionByFilter(status, level, department);
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

class DayPickerBottomSheet extends StatelessWidget {
  DayPickerBottomSheet(this.missionViewModel,{Key? key}) : super(key: key);
  int? day;
  int? month;
  int? year;
  MissionViewModel? missionViewModel;
  @override
  Widget build(BuildContext context) {
    day = dateNow.day.toInt();
    month = dateNow.month.toInt();
    year = dateNow.year.toInt();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 25, 25),
      child: Column(children: [
        const Text("Chọn ngày"),
         Text("Thứ 6, $day tháng $month, $year"),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatefulBuilder(
                builder: (context, dayStateChange) {
                  return NumberPicker(
                    textStyle: const TextStyle(color: kDarkGray,fontSize: 24),
                    selectedTextStyle:const TextStyle(color: Colors.black,fontSize: 24) ,
                    value: day!,
                    minValue: 1,
                    maxValue: 31,
                    onChanged: (value) => dayStateChange(() => day = value),
                  );
                },
              ),
              StatefulBuilder(
                builder: (context, dayStateChange) {
                  return NumberPicker(
                    textStyle: const TextStyle(color: kDarkGray,fontSize: 24),
                    selectedTextStyle:const TextStyle(color: Colors.black,fontSize: 24) ,
                    value: month!,
                    minValue: 1,
                    maxValue: 12,
                    onChanged: (value) => dayStateChange(() => month = value),
                  );
                },
              ),
              StatefulBuilder(
                builder: (context, dayStateChange) {
                  return NumberPicker(
                    textStyle: const TextStyle(color: kDarkGray,fontSize: 24),
                    selectedTextStyle:const TextStyle(color: Colors.black,fontSize: 24) ,

                    value: year!,
                    minValue: 2000,
                    maxValue: 2030,
                    onChanged: (value) => dayStateChange(() => year = value),
                  );
                },
              ),

            ],
          ),
        ),
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
                        var strSelectedDay = "$day/$month/$year";
                        var selectedDay = convertStringToDate(strSelectedDay);
                        missionViewModel!.onSelectDay(selectedDay);
                        Get.back();
                      },
                      style: buttonFilterBlue,
                      child: const Text('Chọn')),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
